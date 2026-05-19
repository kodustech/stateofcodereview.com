-- Acceptance rate by (label, severity).
-- Finding: severity does not predict acceptance. Label does.
-- Critical bugs are 93.6% accepted, medium bugs are 96.5% accepted.

SELECT
  label,
  CASE severity
    WHEN 'critical' THEN '1.critical'
    WHEN 'high' THEN '2.high'
    WHEN 'medium' THEN '3.medium'
    WHEN 'low' THEN '4.low'
  END AS sev_ord,
  COUNT(*) AS total,
  COUNT(DISTINCT organization_id) AS orgs,
  COUNTIF(feedbackType = 'suggestionImplemented') AS implemented,
  COUNTIF(feedbackType = 'positiveReaction') AS thumbs_up,
  COUNTIF(feedbackType = 'negativeReaction') AS thumbs_down,
  ROUND(SAFE_DIVIDE(COUNTIF(feedbackType = 'suggestionImplemented'), COUNT(*)) * 100, 1) AS pct_implemented,
  ROUND(SAFE_DIVIDE(COUNTIF(feedbackType = 'negativeReaction'), COUNT(*)) * 100, 1) AS pct_rejected
FROM `kody-408918.kodus_postgres.suggestion_embedded`
WHERE label IN ('bug', 'security', 'performance', 'cross_file', 'cross-file')
  AND createdAt >= '2025-09-01'
  AND severity IN ('low', 'medium', 'high', 'critical')
GROUP BY label, sev_ord
ORDER BY label, sev_ord;
