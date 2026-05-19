-- Implementation rate by programming language.
-- Full population, not sampled. Filters to engine cutoff (>= 2025-09-01),
-- delivered suggestions only (deliveryStatus = 'sent'), and the modern
-- label whitelist. Outputs counts and percentages for fully implemented,
-- partially implemented, and ignored.

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
    LOWER(JSON_VALUE(s, '$.language'))      AS language,
    JSON_VALUE(s, '$.label')                AS label,
    JSON_VALUE(s, '$.deliveryStatus')       AS deliveryStatus,
    JSON_VALUE(s, '$.implementationStatus') AS implementationStatus
  FROM suggestions, UNNEST(suggs) AS s
)
SELECT
  language,
  COUNT(*) AS delivered,
  COUNT(DISTINCT organizationId) AS orgs,
  COUNTIF(implementationStatus = 'implemented')           AS fully,
  COUNTIF(implementationStatus = 'partially_implemented') AS partial,
  COUNTIF(implementationStatus = 'not_implemented')       AS ignored,
  ROUND(SAFE_DIVIDE(COUNTIF(implementationStatus = 'implemented'), COUNT(*)) * 100, 1) AS pct_full,
  ROUND(SAFE_DIVIDE(COUNTIF(implementationStatus IN ('implemented','partially_implemented')), COUNT(*)) * 100, 1) AS pct_any
FROM flat
WHERE deliveryStatus = 'sent'
  AND label IN ('bug', 'security', 'performance', 'cross-file', 'cross_file')
  AND language IS NOT NULL AND language != ''
GROUP BY language
HAVING delivered >= 100 AND orgs >= 3
ORDER BY delivered DESC;
