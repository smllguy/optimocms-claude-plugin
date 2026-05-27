# Design Tokens Reference

OptimoCMS uses CSS custom properties (design tokens) for theming.
All Puck components reference these tokens — never hardcode colors or fonts.

## How Tokens Work

Each site has a `designTokens` object stored in Firestore. When a page renders,
these values are injected as CSS custom properties on the root element.

Components use them like: `color: var(--dt-color-text, #111827)` where the
second value is the fallback if the token isn't set.

## Available Tokens

### Color Tokens

| CSS Variable | SDK Field | Purpose | Typical Default |
|-------------|-----------|---------|----------------|
| `--dt-color-primary` | `colorPrimary` | Accent/CTA color, buttons, links | `#2563eb` |
| `--dt-color-on-primary` | — | Text on primary background | `#ffffff` |
| `--dt-color-background` | `colorBackground` | Page background | `#ffffff` |
| `--dt-color-surface` | `colorSurface` | Card/panel background | `#f8f9fa` |
| `--dt-color-secondary` | — | Dark/contrast sections | `#111827` |
| `--dt-color-text` | `colorText` | Primary text color | `#111827` |
| `--dt-color-text-muted` | `colorTextMuted` | Secondary/helper text | `#6b7280` |
| `--dt-color-sale` | — | Sale/discount price | `#dc2626` |
| `--dt-color-border` | — | Border color (auto-derived) | `#d1d5db` |

### Font Tokens

| CSS Variable | SDK Field | Purpose | Typical Default |
|-------------|-----------|---------|----------------|
| `--dt-font-body` | `fontBody` | Body text font-family | `system-ui, sans-serif` |
| `--dt-font-heading` | `fontHeading` | Heading font-family | `inherit` |
| `--dt-font-heading-weight` | — | Heading font-weight | `700` |

### Border Radius Tokens

| CSS Variable | SDK Field | Purpose | Typical Default |
|-------------|-----------|---------|----------------|
| `--dt-radius-card` | `radiusCard` | Cards, panels | `12px` |
| `--dt-radius-button` | `radiusButton` | Buttons | `8px` |
| `--dt-radius-input` | `radiusInput` | Form inputs | `8px` |

### Shadow Tokens

| CSS Variable | Purpose | Typical Default |
|-------------|---------|----------------|
| `--dt-shadow-card` | Card box-shadow | `0 2px 8px rgba(0,0,0,0.08)` |

## Updating Tokens via SDK

```typescript
await client.designTokens.update(siteId, {
  colorPrimary: '#b91c1c',
  colorBackground: '#fefce8',
  colorText: '#1c1917',
  fontHeading: 'Playfair Display',
  fontBody: 'Inter',
  radiusCard: '16px',
  radiusButton: '24px',
});
```

After updating tokens, `publish_site` to make changes live.

## Common Derived Patterns

Components use these derived patterns in their styles:

```css
/* Border from text color at 12% opacity */
border: 1px solid color-mix(in srgb, var(--dt-color-text, #1a1a1a) 12%, transparent);

/* Gradient using primary color */
background: linear-gradient(135deg, var(--dt-color-primary), var(--dt-color-primary-dark));

/* Muted background for sections */
background-color: var(--dt-color-surface, #f8f9fa);

/* Dark section background */
background-color: var(--dt-color-secondary, #111827);
```

## Theme Presets

Common theme combinations:

### Minimal Light
```json
{
  "colorPrimary": "#111827",
  "colorBackground": "#ffffff",
  "colorSurface": "#f9fafb",
  "colorText": "#111827",
  "fontBody": "Inter",
  "fontHeading": "Inter",
  "radiusCard": "8px",
  "radiusButton": "4px"
}
```

### Bold & Colorful
```json
{
  "colorPrimary": "#7c3aed",
  "colorBackground": "#faf5ff",
  "colorSurface": "#ffffff",
  "colorText": "#1e1b4b",
  "fontBody": "DM Sans",
  "fontHeading": "Clash Display",
  "radiusCard": "16px",
  "radiusButton": "24px"
}
```

### Restaurant / Warm
```json
{
  "colorPrimary": "#b91c1c",
  "colorBackground": "#fffbeb",
  "colorSurface": "#ffffff",
  "colorText": "#1c1917",
  "fontBody": "Lora",
  "fontHeading": "Playfair Display",
  "radiusCard": "12px",
  "radiusButton": "8px"
}
```

### Corporate / Professional
```json
{
  "colorPrimary": "#1d4ed8",
  "colorBackground": "#ffffff",
  "colorSurface": "#f1f5f9",
  "colorText": "#0f172a",
  "fontBody": "Source Sans Pro",
  "fontHeading": "Source Sans Pro",
  "radiusCard": "8px",
  "radiusButton": "6px"
}
```

## Important Rules

1. **Never hardcode colors in block props** — always reference design tokens.
2. **Tokens update live** — changing a token instantly affects all components.
3. **Font tokens use Google Fonts names** — the site loads them automatically.
4. **Radius values include unit** — pass `"12px"`, not `12`.
5. **Publish after token changes** to make them visible on the live site.
