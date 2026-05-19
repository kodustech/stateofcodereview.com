# 2026-Q2 snapshot

**Status:** in progress (queries frozen; CSV exports pending)
**Dataset window:** 2025-09-01 to 2026-05-19
**Publication target:** 2026-05

## Honest baseline (from queries 09, 10, 11)

| Metric | Value |
|---|---|
| Delivered suggestions (sent, post-cutoff) | 112,336 |
| Distinct organizations | 456 |
| Fully implemented | 19,107 (17.0%) |
| Partially implemented | 18,390 (16.4%) |
| Ignored | 74,839 (66.6%) |
| Any implementation (full + partial) | 37,497 (33.4%) |

## By label

| Label | Delivered | Orgs | Full | Any |
|---|---|---|---|---|
| bug | 90,527 | 433 | 17.3% | 32.8% |
| cross_file | 10,992 | 231 | 15.3% | 39.2% |
| security | 6,552 | 308 | 14.7% | 28.8% |
| performance | 4,265 | 239 | 18.3% | 36.7% |

## BYOK provider mix (from query 10)

| Provider | Orgs | Delivered | Full | Any |
|---|---|---|---|---|
| google_gemini | 24 | 7,294 | 20.5% | 35.5% |
| openai | 19 | 2,696 | 17.8% | 37.9% |
| anthropic | 15 | 2,316 | 21.2% | 39.0% |
| openai_compatible | 11 | 2,125 | 28.6% | 45.8% |
| open_router | 10 | 2,750 | 22.4% | 37.1% |

## Selection-bias correction

An earlier internal draft used `suggestion_embedded.feedbackType` and reported 94.7% acceptance. That table is selection-biased to suggestions that received explicit developer engagement (thumbs-up, thumbs-down, or detected implementation). Silent ignores were missing. The published numbers use the full population from `pullRequests.files` filtered by `deliveryStatus = 'sent'`. See [../../methodology/README.md](../../methodology/README.md) §ii.

## CSVs (added at publish)

- [ ] manifest.json
- [ ] implementation-overall.csv
- [ ] implementation-by-label.csv
- [ ] implementation-by-language.csv
- [ ] implementation-by-provider.csv
- [ ] implementation-by-model.csv
- [ ] funnel.csv
- [ ] bug-classes.csv
- [ ] security-vulnerabilities.csv
- [ ] cross-file-findings.csv
- [ ] codified-rules.csv
