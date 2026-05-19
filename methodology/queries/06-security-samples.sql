-- Sample of accepted security findings for vulnerability landscape taxonomy.
-- Used to build the 2026 Vulnerability Landscape chapter.

SELECT
  language,
  severity,
  SUBSTR(suggestionContent, 1, 240) AS suggestion_preview
FROM `kody-408918.kodus_postgres.suggestion_embedded`
WHERE label = 'security'
  AND createdAt >= '2025-09-01'
  AND feedbackType = 'suggestionImplemented'
  AND severity IN ('critical', 'high')
  AND suggestionContent IS NOT NULL
  AND LENGTH(suggestionContent) > 50
ORDER BY RAND()
LIMIT 200;
