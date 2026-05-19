-- Sample of accepted bug findings for taxonomy clustering.
-- Run multiple times with different RAND() seeds to get a stable taxonomy.
-- Suggestion text is reviewed for sensitive substrings before publication.

SELECT
  language,
  severity,
  SUBSTR(suggestionContent, 1, 240) AS suggestion_preview
FROM `kody-408918.kodus_postgres.suggestion_embedded`
WHERE label = 'bug'
  AND createdAt >= '2025-09-01'
  AND feedbackType = 'suggestionImplemented'
  AND severity IN ('critical', 'high')
  AND suggestionContent IS NOT NULL
  AND LENGTH(suggestionContent) > 50
ORDER BY RAND()
LIMIT 200;
