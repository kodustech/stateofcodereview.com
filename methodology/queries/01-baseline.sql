-- Baseline counts for the 2026-Q2 snapshot.
-- Used in: methodology/filters.md sample-size table.

SELECT
  COUNT(*) AS total_suggestions,
  COUNT(DISTINCT organization_id) AS distinct_orgs,
  COUNT(DISTINCT repositoryFullName) AS distinct_repos,
  COUNT(DISTINCT language) AS distinct_languages,
  COUNTIF(feedbackType = 'suggestionImplemented') AS implemented,
  COUNTIF(feedbackType = 'positiveReaction') AS thumbs_up,
  COUNTIF(feedbackType = 'negativeReaction') AS thumbs_down
FROM `kody-408918.kodus_postgres.suggestion_embedded`
WHERE label IN ('bug', 'security', 'performance', 'cross_file', 'cross-file')
  AND createdAt >= '2025-09-01';
