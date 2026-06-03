---
name: optimocms
description: >
  Build, import, and manage websites on OptimoCMS — a multi-tenant headless CMS
  with AI generation, booking, ecommerce, loyalty, reviews, and recruitment.
  Use when the user wants to create a site, import a website, add pages, manage
  booking/ecommerce/loyalty, generate content with AI, or publish.
  Requires OptimoCMS MCP server to be connected (API key with omc_ prefix).
  Agencies can also use the TypeScript SDK directly (@optimocms/sdk).
---

# OptimoCMS

> **MCP Server**: `optimocms` — Streamable HTTP
> **Endpoint**: `https://europe-west4-cms-sg.cloudfunctions.net/mcpServer`
> **Auth**: `Authorization: Bearer omc_...` or `?apiKey=omc_...`
> **SDK**: `npm install @optimocms/sdk`

## Setup

### 1. Get an API key

1. Log in to your OptimoCMS dashboard
2. Go to **Bureau → Instellingen → API Sleutels**
3. Click **Nieuwe API sleutel** and copy the key (starts with `omc_`)
4. The key is shown only once — store it securely

### 2. Set the environment variable

**macOS / Linux:**
```bash
export OPTIMOCMS_API_KEY="omc_your_key_here"
```

Add to `~/.bashrc` or `~/.zshrc` to persist.

**Windows (PowerShell):**
```powershell
$env:OPTIMOCMS_API_KEY = "omc_your_key_here"
```

Add to your PowerShell profile to persist.

### 3. Connect to Claude Code

If you installed this plugin via `claude plugin install`, the MCP server is
configured automatically via `.mcp.json`. Claude Code will pick up the
`optimocms` MCP server and all tools become available.

Verify by asking Claude: *"List my OptimoCMS sites"*

### 4. Connect to Cursor

Add to your project's `.cursor/mcp.json`:
```json
{
  "mcpServers": {
    "optimocms": {
      "url": "https://europe-west4-cms-sg.cloudfunctions.net/mcpServer",
      "headers": {
        "Authorization": "Bearer omc_your_key_here"
      }
    }
  }
}
```

Or use the environment variable:
```json
{
  "mcpServers": {
    "optimocms": {
      "url": "https://europe-west4-cms-sg.cloudfunctions.net/mcpServer",
      "headers": {
        "Authorization": "Bearer ${OPTIMOCMS_API_KEY}"
      }
    }
  }
}
```

## Quick Start (SDK)

```typescript
import { OptimoCMS } from '@optimocms/sdk';

const client = new OptimoCMS({ apiKey: 'omc_xxx' });
const sites = await client.sites.list();
const page = await client.pages.get('site1', 'page1');
```

## Permissions & Tiers

Each API key has scoped permissions:

| Permission | Tools / Methods | Who |
|------------|----------------|-----|
| `read` | list/get sites, pages, media, analytics | All tiers |
| `write` | create/update pages, publish, blocks, SEO, navigation | Starter+ |
| `ai` | generate, translate, assist, templates | Professional+ |
| `verticals` | booking, ecommerce, loyalty, reviews, recruitment | Professional+ |

Rate limits per tier:

| Tier | API calls/mo | Rate/min | AI tokens/mo |
|------|-------------|----------|-------------|
| Starter (€29) | 1,000 | 10 | 0 |
| Professional (€79) | 5,000 | 20 | 100,000 |
| Agency (€199) | 50,000 | 60 | 500,000 |

## Workflows

### 1. Create a new site from scratch

```
MCP:
1. list_sites() → check current sites
2. generate_page(siteId, prompt, language?, useHeroVideo?, videoModelId?) → AI creates page (€0.05–0.50/call)
   - useHeroVideo: true → generates AI hero video (Professional+ plans)
   - videoModelId: 'seedance-fast' (1 credit, default), 'seedance-standard' (2 credits), 'kling-standard' (1 credit)
3. publish_site(siteId) → deploy to production

SDK:
const result = await client.ai.generateSite({
  name: 'La Bella Pizzeria',
  prompt: 'Italian restaurant with online menu and reservations',
  language: 'nl',
  useHeroVideo: true,
  videoModelId: 'seedance-fast',
  pages: [
    { prompt: 'Homepage with hero and featured dishes' },
    { prompt: 'Menu page with categories and prices' },
    { prompt: 'Contact page with reservation form' },
  ],
});
```

### 2. Install a template

```
MCP:
1. list_sites() → pick target site
2. generate_template(siteId, "Modern restaurant template")
3. publish_site(siteId)

SDK:
await client.templates.install(siteId, {
  templateId: 'restaurant-modern',
  designTokens: { colorPrimary: '#b91c1c', fontHeading: 'Playfair Display' },
});
```

### 3. Import an existing website

```
MCP:
1. preview_import(url) → review what will be imported (FREE, no cost)
2. import_website(url, language?, siteName?) → crawl + AI mapping
3. list_pages(siteId) → review imported pages
4. assist_content(siteId, pageId, "Fix the about section") → adjust content
5. publish_site(siteId)

SDK:
const preview = await client.import.fromUrl({ url: 'https://example.com' });
// Review preview.pagesImported, preview.status
const result = await client.import.fromUrl({
  url: 'https://example.com',
  name: 'My Imported Site',
  includeImages: true,
});
```

### 4. Edit pages and content

```
MCP:
1. list_pages(siteId) → find the page
2. get_page(siteId, pageId) → see current blocks
3. update_page(siteId, pageId, { title?, blocks?, seo? })
4. publish_site(siteId)

SDK:
await client.pages.update(siteId, pageId, {
  title: 'Updated Title',
  seo: { description: 'New meta description', noIndex: false },
});
await client.blocks.insert(siteId, pageId, {
  type: 'HeroSection',
  props: { title: 'Welcome', subtitle: 'Best pizza in town' },
  position: 0,
});
```

### 5. Translate a site to multiple languages

```
MCP:
1. list_pages(siteId)
2. translate_page(siteId, pageId, targetLanguage) → per page (€0.05–0.20/call)
   Supported: nl, en, de, fr, es

SDK:
const pages = await client.pages.list(siteId);
for (const page of pages.data) {
  await client.ai.translatePage(siteId, page.id, { target: 'de' });
  await client.ai.translatePage(siteId, page.id, { target: 'fr' });
}
```

### 6. Add booking / reservations

```
MCP:
1. get_available_slots(siteId, date, serviceId?)
2. create_booking(siteId, { serviceId, date, startTime, customerName, customerEmail })
3. list_bookings(siteId, { status?, date? })

SDK:
const slots = await client.booking.getSlots(siteId, { serviceId: 'haircut', date: '2026-06-01' });
const booking = await client.booking.create(siteId, {
  serviceId: 'haircut',
  date: '2026-06-01',
  startTime: '14:00',
  customer: { name: 'Jan', email: 'jan@example.com' },
});
```

### 7. Manage shop products

```
MCP:
1. list_products(siteId)
2. create_product(siteId, { title, priceCents, description?, category? })
3. update_product(siteId, productId, { priceCents?, active? })
4. list_orders(siteId, { status? })

SDK:
await client.shop.products.create(siteId, {
  title: 'Margherita Pizza',
  priceCents: 1299,
  category: 'Pizza',
});
```

### 8. Loyalty program

```
MCP:
1. get_member_status(siteId, memberId)
2. earn_points(siteId, { memberId, points, description })
3. list_rewards(siteId)

SDK:
await client.loyalty.earnPoints(siteId, {
  memberId: 'member_123',
  points: 50,
  description: 'Aankoop pizza',
});
```

### 9. Customize design tokens (theming)

```
SDK:
await client.designTokens.update(siteId, {
  colorPrimary: '#2563eb',
  colorBackground: '#ffffff',
  fontHeading: 'Playfair Display',
  radiusCard: '16px',
});
```

Read `references/design-tokens.md` for all available `--dt-*` CSS tokens.

### 10. Multi-site automation (agency workflow)

```typescript
// Create 20 franchise sites from the same template
const franchises = ['Amsterdam', 'Rotterdam', 'Utrecht', /* ... */];

for (const city of franchises) {
  const site = await client.ai.generateSite({
    name: `La Bella ${city}`,
    prompt: `Italian restaurant in ${city}`,
    template: 'restaurant-modern',
  });
  await client.designTokens.update(site.siteId, {
    colorPrimary: '#b91c1c',
  });
}
```

## Cost Warnings

| Action | Cost | Rate Limit |
|--------|------|-----------|
| `generate_page` | ~€0.05–0.50 per call (+video: 1-2 credits) | 2/min |
| `generate_template` | ~€0.10–0.50 per call | 2/min |
| `generate_template_variants` | ~€0.20–1.00 per call | 2/min |
| `translate_page` | ~€0.05–0.20 per call | 5/min |
| `assist_content` | ~€0.05–0.20 per call | 5/min |
| `import_website` | ~€0.30–2.00 per site | 1/min |
| `preview_import` | FREE | 5/min |
| `publish_site` | FREE | 1 per 5 min/site |
| All read operations | FREE | tier rate/min |
| All write operations | FREE | tier rate/min |

**Always warn the user before calling AI tools** — these consume AI tokens and cost money.
A full site generation with 5 pages may cost €1–3.

## Best Practices

1. **Always `preview_import` before `import_website`** — preview is free,
   import costs AI tokens and creates a site.
2. **Batch translations carefully** — translating 10 pages × 4 languages = 40 AI calls.
   Warn the user about the total cost.
3. **Publish once, not per page** — make all page changes first, then `publish_site` once.
4. **Check rate limits** — if you get 429, wait for Retry-After header value.
   The SDK handles this automatically with exponential backoff.
5. **Use design tokens, not hardcoded colors** — see `references/design-tokens.md`.
6. **Blocks use Puck component types** — see `references/components.md` for all 70+ types.
7. **HD Import** — for Professional+ tiers, set `hdImport: true` for vision-guided
   refinement that produces much more accurate imports.

## SDK vs MCP: When to Use Which

| Use Case | Recommended |
|----------|------------|
| AI agent (Cursor, Claude, Lovable) | MCP tools |
| Automation script / CI/CD | SDK |
| Bulk operations (20+ sites) | SDK (loop with rate limit respect) |
| Interactive one-off tasks | MCP tools |
| Custom app integration | SDK |

## Error Handling (SDK)

```typescript
import { OptimoCMS, RateLimitError, NotFoundError } from '@optimocms/sdk';

try {
  await client.pages.get(siteId, pageId);
} catch (err) {
  if (err instanceof RateLimitError) {
    // SDK auto-retries, but if max retries exceeded:
    console.log(`Rate limited. Retry after ${err.retryAfter}s`);
  }
  if (err instanceof NotFoundError) {
    console.log('Page not found');
  }
}
```

## References

- Read `references/components.md` for all 70+ Puck component types with props
- Read `references/verticals.md` for booking, ecommerce, loyalty, reviews, recruitment details
- Read `references/design-tokens.md` for all CSS design tokens
- Read `references/import.md` for website import best practices and troubleshooting
