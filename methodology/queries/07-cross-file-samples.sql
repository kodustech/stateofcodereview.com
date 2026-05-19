-- Sample of accepted cross-file findings.
-- These are the bug classes a single-file linter cannot catch:
-- duplication across files, inconsistent handling of the same concept,
-- schema drift, type incompatibility, N+1 split between controller and view.

SELECT
  language,
  severity,
  SUBSTR(suggestionContent, 1, 280) AS suggestion_preview
FROM `kody-408918.kodus_postgres.suggestion_embedded`
WHERE label IN ('cross_file', 'cross-file')
  AND createdAt >= '2025-09-01'
  AND feedbackType = 'suggestionImplemented'
  AND suggestionContent IS NOT NULL
  AND LENGTH(suggestionContent) > 50
ORDER BY RAND()
LIMIT 150;
