# State of AI Code Review

Research project analyzing AI code review at scale on real production pull requests. Refreshed quarterly.

**Live site:** https://stateofcodereview.com
**Latest snapshot:** [data/2026-q2/](./data/2026-q2/)
**Methodology:** [methodology/](./methodology/)

## What this is

A public dataset and report on how AI code review tools actually perform on real production pull requests. Covers four chapters:

1. **Bug taxonomy** — what classes of bug AI catches in production code
2. **Vulnerability landscape** — security findings in 2026, including prompt injection as a new category
3. **Cross-file findings** — what AI sees that single-file linters cannot
4. **Codified review standards** — what 610 engineering teams enforce as review rules

## Dataset (2026-Q2 snapshot)

- 17,773 AI-generated suggestions with explicit developer feedback
- 200 distinct organizations
- 639 distinct repositories
- 103 programming languages
- Time window: September 2025 to May 2026
- 7,276 codified review rules from 610 organizations (KodyRules census, separate table)

All findings come from production code reviews. No benchmarks, no synthetic data.

See [methodology/filters.md](./methodology/filters.md) for filtering criteria, engine cutoff, and privacy thresholds.

## How to cite

> State of AI Code Review (2026-Q2). Research by Kodus. https://stateofcodereview.com

BibTeX and other formats: [CITATION.cff](./CITATION.cff) (added at publish).

## License

Data and report content licensed under [CC BY 4.0](./LICENSE). Reuse with attribution.

## Attribution

Research by [Kodus](https://kodus.io), an open source AI code review tool. The dataset is sourced from the Kodus production code review pipeline.

## Refresh cadence

Quarterly snapshots. Each refresh adds a new `data/YYYY-qN/` folder; old snapshots stay immutable so existing citations do not break.

| Snapshot | Status | Date |
|---|---|---|
| 2026-Q2 | In progress | 2026-05 (planned) |
| 2026-Q3 | Planned | 2026-08 |
| 2026-Q4 | Planned | 2026-11 |

## Repo structure

```
stateofcodereview.com/
├── README.md                      this file
├── LICENSE                        CC BY 4.0
├── methodology/                   how the data was produced
│   ├── README.md
│   ├── filters.md                 engine cutoff, label whitelist, privacy
│   └── queries/                   reproducible SQL (BigQuery dialect)
├── data/                          immutable quarterly snapshots
│   └── 2026-q2/                   CSVs + manifest per snapshot
├── site/                          Astro static site (deployed to Vercel)
└── .github/workflows/             quarterly refresh automation
```
