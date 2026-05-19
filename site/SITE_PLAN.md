# Site plan

Notes for the published web report at https://stateofcodereview.com.

## Stack (current)

- **Astro 6.3.5** — matches the codereviewbench.com precedent (which produced 2,133 organic backlinks)
- **TypeScript strict** — initialized
- **Vercel** — deploy target; domain DNS already points at NS{1,2}.vercel-dns.com

## Still to add

```sh
npx astro add mdx sitemap tailwind
```

Then update `astro.config.mjs` with `site: 'https://stateofcodereview.com'` so the sitemap integration generates absolute URLs.

## Planned page structure

```
/                              landing — TL;DR + chapter cards
/methodology/                  filters, queries, citation format
/bugs/                         Chapter 1: bug taxonomy
/vulnerabilities/              Chapter 2: 2026 vulnerability landscape
/cross-file/                   Chapter 3: what AI catches that linters miss
/rules/                        Chapter 4: KodyRules census
/data/                         CSV downloads + machine-readable JSON
/about/                        attribution, contact, license
```

## SEO essentials

- `<title>` and `<meta name="description">` per page
- JSON-LD `ResearchProject` schema on landing
- JSON-LD `Dataset` schema on `/data/`
- JSON-LD `sameAs` linking to https://kodus.io for research attribution
- Open Graph + Twitter card per page with custom OG image per chapter
- `sitemap.xml` (handled by @astrojs/sitemap)
- `robots.txt` allowing all crawlers including AI training (for AEO citations)
- Reciprocal footer link to kodus.io with `rel="noopener"` (NOT `nofollow`)
