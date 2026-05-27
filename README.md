# OptimoCMS Claude Plugin

Build, import, and manage websites on [OptimoCMS](https://optimocms.com) directly from Claude Code or Cursor.

This plugin bundles:
- **MCP Server** auto-configuration (`.mcp.json`)
- **Skills** with workflows, best practices, and component references
- **Cursor config** (`.cursor/mcp.json`)

## Installation

### Claude Code

```bash
claude plugin install github:optimocms/claude-plugin
```

### Manual

1. Clone or download this repository
2. Copy the contents to your Claude plugins directory:
   ```bash
   cp -r . ~/.claude/plugins/optimocms/
   ```

### Cursor

Copy `.cursor/mcp.json` to your project root, or merge the `optimocms` entry into your existing `.cursor/mcp.json`.

## Configuration

### 1. Get an API key

1. Log in to [OptimoCMS](https://optimocms.com)
2. Go to **Bureau → Instellingen → API Sleutels**
3. Click **Nieuwe API sleutel**
4. Copy the key (starts with `omc_`) — shown only once

### 2. Set the environment variable

**macOS / Linux:**
```bash
export OPTIMOCMS_API_KEY="omc_your_key_here"
# Add to ~/.bashrc or ~/.zshrc to persist
```

**Windows (PowerShell):**
```powershell
$env:OPTIMOCMS_API_KEY = "omc_your_key_here"
```

### 3. Verify

Ask Claude or Cursor:
> "List my OptimoCMS sites"

If the MCP server is connected, you'll see your sites.

## What's Included

| File | Purpose |
|------|---------|
| `.claude-plugin/plugin.json` | Plugin manifest (name, version, metadata) |
| `.mcp.json` | Auto-configures the OptimoCMS MCP server for Claude Code |
| `.cursor/mcp.json` | MCP server config for Cursor IDE |
| `skills/optimocms/SKILL.md` | Workflows, best practices, SDK examples, cost warnings |
| `skills/optimocms/references/` | Component types, design tokens, verticals, import guide |

## Available MCP Tools

### Read (all tiers)
- `list_sites` — List all sites in your agency
- `get_site` — Get site details
- `list_pages` — List pages of a site
- `get_page` — Get page with blocks
- `search_media` — Search media library
- `get_analytics` — Site analytics

### Write (Starter+)
- `create_page` — Create a new page
- `update_page` — Update page content/blocks
- `publish_site` — Deploy site to production

### AI (Professional+)
- `generate_page` — AI-generate a page from a prompt
- `translate_page` — Translate page to another language
- `assist_content` — AI content assistant
- `generate_template` — Generate from a template prompt
- `generate_template_variants` — Generate template variations

### Import
- `preview_import` — Preview website import (FREE)
- `import_website` — Full website import with AI mapping

### Verticals (Professional+)
- `get_available_slots` / `create_booking` / `list_bookings` — Booking
- `list_products` / `create_product` / `update_product` / `list_orders` — Shop
- `get_member_status` / `earn_points` / `list_rewards` — Loyalty
- `list_reviews` — Reviews
- `list_jobs` / `create_job` — Recruitment

## TypeScript SDK

For automation scripts and CI/CD, use the SDK directly:

```bash
npm install @optimocms/sdk
```

```typescript
import { OptimoCMS } from '@optimocms/sdk';

const client = new OptimoCMS({ apiKey: process.env.OPTIMOCMS_API_KEY! });

const sites = await client.sites.list();
const page = await client.pages.get('site1', 'page1');
await client.ai.generatePage('site1', { prompt: 'Restaurant homepage' });
await client.sites.publish('site1');
```

## Tiers & Pricing

| Tier | API calls/mo | Rate/min | AI tokens/mo |
|------|-------------|----------|-------------|
| Starter (€29) | 1,000 | 10 | 0 |
| Professional (€79) | 5,000 | 20 | 100,000 |
| Agency (€199) | 50,000 | 60 | 500,000 |

## License

MIT
