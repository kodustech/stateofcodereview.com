# Snapshots

Each quarterly snapshot is a frozen CSV export of the figures shown in the report. Snapshots are immutable. New snapshots add a new folder; existing folders are never edited so existing citations do not break.

## Current

- [2026-q2/](./2026-q2/) — first published snapshot

## Planned

- 2026-q3 (publish 2026-08)
- 2026-q4 (publish 2026-11)
- 2027-q1 (publish 2027-02)

## File conventions per snapshot

Each `YYYY-qN/` folder contains:

- `manifest.json` — run date, dataset window, row counts per CSV
- `language-acceptance.csv` — per-language counts and acceptance rate
- `funnel.csv` — raw suggestion funnel by priority and delivery status
- `severity-by-label.csv` — acceptance by (label, severity)
- `bug-classes.csv` — top bug classes from taxonomy clustering
- `security-vulnerabilities.csv` — vulnerability landscape from taxonomy clustering
- `cross-file-findings.csv` — cross-file finding categories
- `codified-rules.csv` — top KodyRules across distinct organizations

All CSVs include only aggregates that meet the privacy thresholds in [../methodology/filters.md](../methodology/filters.md).
