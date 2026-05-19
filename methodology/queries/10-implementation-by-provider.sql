-- Implementation rate by LLM provider.
-- Joins the BYOK config (organization_parameters.byok_config) with delivered
-- suggestions from pullRequests.files. The BYOK config schema is:
--   { main: { provider, model, ... }, fallback?: { ... } }
-- We use the main.provider only. Fallback usage is not joined here.

WITH files_unnest AS (
  SELECT
    organizationId,
    JSON_EXTRACT_ARRAY(files) AS files_arr
  FROM `kody-408918.kodus_mongo.pullRequests`
  WHERE files IS NOT NULL
    AND ARRAY_LENGTH(JSON_EXTRACT_ARRAY(files)) > 0
    AND createdAt >= '2025-09-01'
),
suggestions AS (
  SELECT organizationId, JSON_EXTRACT_ARRAY(file_json, '$.suggestions') AS suggs
  FROM files_unnest, UNNEST(files_arr) AS file_json
),
flat AS (
  SELECT
    organizationId,
    JSON_VALUE(s, '$.deliveryStatus')       AS deliveryStatus,
    JSON_VALUE(s, '$.implementationStatus') AS implementationStatus,
    JSON_VALUE(s, '$.label')                AS label
  FROM suggestions, UNNEST(suggs) AS s
),
byok AS (
  SELECT
    organization_id,
    JSON_VALUE(configValue, '$.main.provider') AS provider,
    JSON_VALUE(configValue, '$.main.model')    AS model
  FROM `kody-408918.kodus_postgres.organization_parameters`
  WHERE configKey = 'byok_config'
)
SELECT
  b.provider,
  COUNT(*) AS delivered,
  COUNT(DISTINCT f.organizationId) AS orgs,
  COUNTIF(f.implementationStatus = 'implemented')           AS fully,
  COUNTIF(f.implementationStatus = 'partially_implemented') AS partial,
  COUNTIF(f.implementationStatus = 'not_implemented')       AS ignored,
  ROUND(SAFE_DIVIDE(COUNTIF(f.implementationStatus = 'implemented'), COUNT(*)) * 100, 1) AS pct_full,
  ROUND(SAFE_DIVIDE(COUNTIF(f.implementationStatus IN ('implemented','partially_implemented')), COUNT(*)) * 100, 1) AS pct_any
FROM flat f
JOIN byok b ON b.organization_id = f.organizationId
WHERE f.deliveryStatus = 'sent'
  AND f.label IN ('bug', 'security', 'performance', 'cross-file', 'cross_file')
GROUP BY b.provider
ORDER BY delivered DESC;
