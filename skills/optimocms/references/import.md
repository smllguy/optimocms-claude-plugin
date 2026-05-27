# Website Import Reference

OptimoCMS can import existing websites and convert them to editable Puck pages.

## Import Flow

```
1. preview_import(url)    → Crawl + analyze (FREE, no AI tokens)
2. Review preview result  → Check detected sections, pages, blog posts
3. import_website(url)    → Full import with AI mapping (costs AI tokens)
4. list_pages(siteId)     → Review imported pages
5. assist_content(...)    → Fix any issues per page
6. publish_site(siteId)   → Deploy to production
```

## MCP Tools

### preview_import

Free crawl that shows what will be imported without creating anything.

```
preview_import(url: "https://example.com", language?: "nl")
```

Returns:
- Detected sections and their types
- WordPress detection (blog posts, plugins)
- Sub-page list with URLs
- Estimated import complexity

**Always call this first** — it's free and prevents surprises.

### import_website

Full import that creates a new OptimoCMS site.

```
import_website(
  url: "https://example.com",
  language?: "nl",
  siteName?: "My Site",
  siteId?: "existing-site-id",    // overwrite existing site
  selectedSubPages?: ["url1"],     // from preview results
  importBlogPosts?: true,          // WordPress blog posts
  hdImport?: true                  // vision-guided (Professional+)
)
```

## SDK Methods

```typescript
// Preview (free)
const preview = await client.import.fromUrl({
  url: 'https://example.com',
  includeImages: true,
});

// Import from Lovable
const result = await client.import.fromLovable({
  projectUrl: 'https://lovable.dev/projects/xxx',
  name: 'My Lovable Site',
});

// Check import status (async operation)
const status = await client.import.status(importId);
// status.progress (0-100), status.pagesImported, status.status
```

## Import Types

### Standard Import
- Crawls the website HTML
- AI maps sections to Puck components
- Copies text content and image URLs
- Cost: ~€0.30–1.00 per site

### HD Import (Professional+ tier)
- Uses vision AI to analyze screenshots
- Much more accurate layout reproduction
- Better color/font detection
- Cost: ~€1.00–2.00 per site
- Set `hdImport: true`

### WordPress Import
- Detects WordPress sites automatically
- Imports blog posts as individual pages
- Preserves categories and tags
- Set `importBlogPosts: true` (default)

### Lovable Import
- Direct import from Lovable projects
- SDK: `client.import.fromLovable({ projectUrl })`
- Preserves component structure where possible

## Best Practices

1. **Always preview first** — `preview_import` is free and shows what to expect.

2. **Select sub-pages carefully** — don't import everything. Common picks:
   - Homepage
   - About page
   - Services/Products page
   - Contact page
   - Skip: legal pages, login pages, utility pages

3. **Use HD Import for design-heavy sites** — standard import may miss
   visual nuances for sites with complex layouts.

4. **Fix content after import** — use `assist_content` to refine imported pages:
   ```
   assist_content(siteId, pageId, "Make the hero section more prominent")
   assist_content(siteId, pageId, "Add a CTA button to the services section")
   ```

5. **Update design tokens after import** — the importer tries to detect colors
   and fonts, but manual fine-tuning is often needed:
   ```typescript
   await client.designTokens.update(siteId, {
     colorPrimary: '#b91c1c',
     fontHeading: 'Playfair Display',
   });
   ```

6. **Check images** — imported images reference the original URLs.
   Consider re-uploading critical images to OptimoCMS media library.

7. **Publish only when satisfied** — review all pages before publishing.

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| Empty sections | JavaScript-rendered content | Use HD Import or add content manually |
| Wrong component mapping | Complex/unusual layout | Use `assist_content` to restructure |
| Missing images | CORS or blocked resources | Re-upload images to media library |
| Blog posts missing | Not a WordPress site | Blog import only works with WordPress |
| Import stuck at 0% | Site blocks crawlers | Check robots.txt, try different URL |
| Import failed | Site requires auth | Cannot import login-protected pages |

## Cost Summary

| Action | Cost | Rate Limit |
|--------|------|-----------|
| `preview_import` | FREE | 5/min |
| `import_website` (standard) | ~€0.30–1.00 | 1/min |
| `import_website` (HD) | ~€1.00–2.00 | 1/min |
| `import.fromLovable` | ~€0.50–1.50 | 1/min |
