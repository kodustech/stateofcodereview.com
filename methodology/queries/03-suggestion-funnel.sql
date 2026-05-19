-- The "hidden 80% filter": from raw LLM output to delivered suggestion.
-- Samples 15,000 PRs created after the engine cutoff and parses the embedded suggestion array.
-- Used in: the funnel chart showing how many of every 100 raw suggestions reach the developer.

WITH files_unnest AS (
  SELECT
    _id AS pr_id,
    organizationId,
    JSON_EXTRACT_ARRAY(files) AS files_arr
  FROM `kody-408918.kodus_mongo.pullRequests`
  WHERE files IS NOT NULL
    AND ARRAY_LENGTH(JSON_EXTRACT_ARRAY(files)) > 0
    AND createdAt >= '2025-09-01'
  LIMIT 15000
),
suggestions AS (
  SELECT
    pr_id,
    organizationId,
    JSON_EXTRACT_ARRAY(file_json, '$.suggestions') AS suggs
  FROM files_unnest, UNNEST(files_arr) AS file_json
),
flat AS (
  SELECT
    JSON_VALUE(s, '$.priorityStatus') AS priorityStatus,
    JSON_VALUE(s, '$.deliveryStatus') AS deliveryStatus,
    JSON_VALUE(s, '$.label') AS label,
    JSON_VALUE(s, '$.severity') AS severity
  FROM suggestions, UNNEST(suggs) AS s
)
SELECT
  priorityStatus,
  deliveryStatus,
  COUNT(*) AS n,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct
FROM flat
WHERE priorityStatus IS NOT NULL
GROUP BY priorityStatus, deliveryStatus
ORDER BY n DESC;
