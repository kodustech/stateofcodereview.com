# Site

The published web report at https://stateofcodereview.com.

## Stack

- **Astro** — chosen to match the codereviewbench.com precedent (which produced 2,133 organic backlinks)
- **Vercel** — deploy target; domain DNS already points at NS{1,2}.vercel-dns.com
- **MDX** — for chapter content (lets us mix prose with chart components)

## Bootstrap

Not yet initialized. Run from this directory:

```sh
npm create astro@latest . -- --template minimal --typescript strict --no-install
npm install
npm install @astrojs/mdx @astrojs/sitemap @astrojs/tailwind
```

Then add to `astro.config.mjs`:

```js
import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://stateofcodereview.com',
  integrations: [mdx(), sitemap()],
});
```

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
- JSON-LD `ResearchProject` schema on the landing page
- JSON-LD `Dataset` schema on `/data/`
- JSON-LD `sameAs` linking to https://kodus.io (research attribution)
- Open Graph + Twitter card per page with custom OG image per chapter
- `sitemap.xml` (handled by @astrojs/sitemap)
- `robots.txt` allowing all crawlers including AI training (for AEO citations)
- Reciprocal footer link to kodus.io with `rel="noopener"` (NOT `nofollow`)
