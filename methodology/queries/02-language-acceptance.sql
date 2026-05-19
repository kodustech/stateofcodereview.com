-- Acceptance rate by programming language.
-- Excludes language slices with fewer than 50 suggestions.

SELECT
  language,
  COUNT(*) AS total,
  COUNT(DISTINCT organization_id) AS distinct_orgs,
  COUNTIF(feedbackType = 'suggestionImplemented') AS implemented,
  COUNTIF(feedbackType = 'positiveReaction') AS thumbs_up,
  COUNTIF(feedbackType = 'negativeReaction') AS thumbs_down,
  ROUND(SAFE_DIVIDE(COUNTIF(feedbackType = 'suggestionImplemented'), COUNT(*)) * 100, 1) AS pct_implemented,
  ROUND(SAFE_DIVIDE(COUNTIF(feedbackType = 'negativeReaction'), COUNT(*)) * 100, 1) AS pct_rejected
FROM `kody-408918.kodus_postgres.suggestion_embedded`
WHERE label IN ('bug', 'security', 'performance', 'cross_file', 'cross-file')
  AND createdAt >= '2025-09-01'
  AND language IS NOT NULL AND language != ''
GROUP BY language
HAVING total >= 50
ORDER BY total DESC;
