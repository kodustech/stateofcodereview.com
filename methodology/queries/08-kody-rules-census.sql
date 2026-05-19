-- The KodyRules census: what 610 engineering teams codified as review standards.
-- This dataset is independent of engine version (it is user-authored, not LLM-generated).

WITH rules_unnest AS (
  SELECT
    organizationId,
    JSON_EXTRACT_ARRAY(rules) AS rules_arr
  FROM `kody-408918.kodus_mongo.kodyRules`
),
flat_rules AS (
  SELECT
    organizationId,
    LOWER(JSON_VALUE(r, '$.title')) AS title,
    JSON_VALUE(r, '$.severity') AS severity,
    JSON_VALUE(r, '$.origin') AS origin,
    JSON_VALUE(r, '$.scope') AS scope
  FROM rules_unnest, UNNEST(rules_arr) AS r
)
SELECT
  title,
  COUNT(*) AS occurrences,
  COUNT(DISTINCT organizationId) AS distinct_orgs
FROM flat_rules
WHERE title IS NOT NULL AND title != ''
GROUP BY title
HAVING distinct_orgs >= 3
ORDER BY distinct_orgs DESC, occurrences DESC
LIMIT 100;
