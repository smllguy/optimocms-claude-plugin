# Puck Components Reference

OptimoCMS uses Puck as its page builder. Each page consists of an array of blocks,
where each block has a `type` (component name) and `props` (configuration).

## Block Format

```json
{
  "type": "HeroSection",
  "props": {
    "title": "Welcome",
    "subtitle": "Best pizza in town",
    "ctaText": "Book Now",
    "ctaLink": "/reserveren",
    "backgroundImage": "https://..."
  }
}
```

## Layout Components

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `GridSection` | CSS Grid layout container | `columns`, `gap`, `autoFlow`, `templateColumns`, `templateRows` |
| `FlexSection` | Flexbox layout container | `direction`, `justify`, `align`, `gap`, `wrap` |
| `ColumnsSection` | Multi-column content layout | `columns` (2-4), `gap`, `reverseOnMobile` |
| `ContainerSection` | Content wrapper with max-width | `maxWidth` (sm/md/lg/xl/full), `padding` |
| `SplitContentSection` | Two-panel split layout (text + image) | `imagePosition` (left/right), `content`, `image` |
| `SpacerSection` | Vertical whitespace | `height` (px) |
| `DividerSection` | Horizontal divider line | `style` (solid/dashed/dotted), `color`, `thickness` |
| `BentoGridSection` | Bento-style grid with mixed sizes | `items[]` with `colSpan`, `rowSpan`, `image`, `label`, `description` |
| `RepeaterSection` | Repeatable content blocks | `items[]`, `columns`, `gap` |

## Content Components

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `TextSection` | Rich text content block | `content` (HTML string), `alignment` |
| `ImageSection` | Single image with optional caption | `src`, `alt`, `caption`, `objectFit` |
| `VideoSection` | Embedded video (YouTube/Vimeo/self-hosted) | `url`, `aspectRatio` (16:9, 4:3, 1:1), `autoplay` |
| `ButtonSection` | Call-to-action button | `text`, `link`, `variant` (primary/secondary/outline), `size` |
| `TableSection` | Data table | `headers[]`, `rows[][]`, `striped` |
| `EmbedSection` | External embed (iframe) | `src` (URL), `height` |

## Hero & Banner Components

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `HeroSection` | Full-width hero with CTA | `title`, `subtitle`, `ctaText`, `ctaLink`, `backgroundImage`, `backgroundVideo`, `overlay` |
| `VideoHeroSection` | Hero with background video | `videoUrl`, `title`, `subtitle`, `ctaText`, `ctaLink`, `overlay` |
| `CTABannerSection` | Call-to-action banner strip | `title`, `subtitle`, `ctaText`, `ctaLink`, `backgroundColor` |
| `AlertBarSection` | Top-of-page alert/notification bar | `message`, `type` (info/warning/success/error), `dismissible`, `link` |

## Feature & Service Components

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `FeatureCardsSection` | Grid of feature cards with icons | `items[]` with `icon`, `title`, `description` |
| `ServiceCardsSection` | Service/offering cards | `items[]` with `title`, `description`, `image`, `price`, `ctaText` |
| `PricingSection` | Pricing comparison table | `plans[]` with `name`, `price`, `features[]`, `ctaText`, `highlighted` |
| `ComparisonSection` | Feature comparison table | `headers[]`, `rows[]` with `feature`, `values[]` |
| `StatisticsSection` | Animated stat counters | `items[]` with `value`, `label`, `prefix`, `suffix` |
| `StepsSection` | Step-by-step process | `items[]` with `title`, `description`, `icon` |
| `TimelineSection` | Chronological timeline | `items[]` with `date`, `title`, `description` |
| `ProgressBarSection` | Skill/progress bars | `items[]` with `label`, `percentage`, `color` |

## Social Proof Components

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `TestimonialSection` | Customer testimonials/reviews | `items[]` with `quote`, `author`, `role`, `avatar`, `rating` |
| `LogoCloudSection` | Partner/client logos grid | `items[]` with `src`, `alt`, `link`, `columns` (2-8) |
| `TrustBarSection` | Trust badges/certifications | `items[]` with `icon`, `label` |
| `TeamSection` | Team member profiles | `items[]` with `name`, `role`, `photo`, `bio`, `socialLinks` |
| `ExternalReviewsSection` | Reviews from Google/Trustpilot etc. | `provider`, `placeId` or `businessId` |

## Navigation Components

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `NavbarSection` | Site navigation bar | `logo`, `items[]` with `label`, `href`, `children[]` |
| `FooterSection` | Site footer with columns | `columns[]` with `title`, `links[]`, `copyright`, `socialLinks` |
| `BreadcrumbSection` | Breadcrumb navigation | `items[]` with `label`, `href` |
| `AnchorLinksSection` | In-page anchor navigation | `items[]` with `label`, `anchor` |
| `BackToTopSection` | Scroll-to-top button | `showAfter` (px) |
| `SiteSearchSection` | Full-text site search | `placeholder`, `maxResults` |

## Interactive Components

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `FaqSection` | FAQ accordion | `items[]` with `question`, `answer` |
| `AccordionSection` | Generic collapsible sections | `items[]` with `title`, `content` |
| `TabsSection` | Tabbed content panels | `items[]` with `label`, `content` |
| `TabsContentSection` | Advanced tabs with rich content | `tabs[]` with `label`, `blocks[]` |
| `GallerySection` | Image gallery grid | `images[]` with `src`, `alt`, `caption`, `columns` |
| `ImageCarouselSection` | Image slider/carousel | `images[]` with `src`, `alt`, `caption`, `autoPlay`, `interval` |
| `LightboxSection` | Click-to-zoom image lightbox | `images[]` with `src`, `alt`, `thumbnail` |
| `CountdownSection` | Countdown timer | `targetDate`, `title`, `expiredMessage` |
| `PopupSection` | Modal popup overlay | `title`, `content`, `trigger` (click/timer/exit-intent), `delay` |
| `MapSection` | Interactive map | `provider` (openstreetmap/google), `lat`, `lng`, `zoom`, `markers[]` |
| `CalendlySection` | Calendly booking embed | `calendlyUrl`, `height` |
| `ChatbotSection` | AI chatbot widget | `systemPrompt`, `placeholder`, `welcomeMessage` |
| `DarkModeToggle` | Light/dark mode toggle | `position` |

## Form Components

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `ContactFormSection` | Standard contact form | `email`, `subject`, `fields[]`, `submitText` |
| `FormBuilderSection` | Custom form builder | `fields[]` with `type`, `label`, `required`, `options[]`, `borderRadius`, `maxWidth` |
| `NewsletterSection` | Email signup form | `title`, `description`, `placeholder`, `submitText` |
| `DonationSection` | Donation form with amounts | `amounts[]`, `currency` (EUR/USD/GBP), `showNameField`, `showMessageField` |

## Blog Components

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `BlogListSection` | Blog post listing grid | `postsPerPage`, `category`, `layout` (grid/list) |
| `BlogPostSection` | Single blog post content | `title`, `content`, `author`, `date`, `featuredImage`, `maxWidth` |

## Media Components

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `SocialLinksSection` | Social media icon links | `items[]` with `platform`, `url` |

## Vertical-Specific Components

These require the corresponding vertical to be enabled on the site.

### Booking & Reservations

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `BookingWidget` | Appointment booking calendar | `serviceId`, `staffId`, `showPrices` |
| `ReservationWidget` | Restaurant table reservation | `maxGuests`, `minAdvanceHours`, `showTimeSlots` |

### Ecommerce

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `ProductListSection` | Product catalog grid | `category`, `columns` (1-4), `showPrices`, `sortBy` |
| `ProductDetailSection` | Single product detail page | `productId` |
| `OrderConfirmationSection` | Order confirmation display | `showOrderSummary`, `showDeliveryInfo` |
| `DeliveryTrackerSection` | Delivery status tracker | `orderId` |

### Loyalty

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `LoyaltyWidget` | Points balance + earn/redeem | `memberId`, `showTier` |
| `LoyaltyStampCard` | Digital stamp card | `stamps`, `reward` |
| `LoyaltyLeaderboard` | Top members leaderboard | `limit`, `showPoints` |
| `LoyaltyRewardsSection` | Available rewards catalog | `columns`, `showPointsCost` |

### Recruitment

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `RecruitmentWidget` | Job listings with apply | `department`, `jobType`, `location` |
| `RecruitmentJobAlertWidget` | Job alert email signup | `departments[]`, `frequency` |
| `JobPostingJsonLdSection` | Schema.org JobPosting structured data | `jobId` |

### Hospitality

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `RentalBlock` | Rental/accommodation listing | `propertyId`, `showPrices`, `showAvailability` |
| `ParkBlock` | Vacation park with units | `parkId`, `showMap` |

### Real Estate

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `RealEstateListingsBlock` | Property listings grid | `type` (sale/rent), `city`, `priceRange` |
| `RealEstateFeaturedBlock` | Featured properties carousel | `limit`, `showPrice` |
| `RealEstateRecentBlock` | Recently added properties | `limit` |
| `RealEstateStatsBlock` | Market statistics dashboard | `city`, `period` |
| `RealEstateCitiesBlock` | Properties per city overview | `cities[]` |
| `RealEstateAgentBlock` | Single agent profile | `agentId` |
| `RealEstateAgentGridBlock` | Agent team grid | `columns` |

### Other

| Component | Description | Key Props |
|-----------|-------------|-----------|
| `VoiceAgentWidget` | AI voice assistant (phone) | `agentId`, `greeting` |
| `PushOptInButton` | Push notification opt-in | `label`, `position` |
| `CookieBannerBlock` | GDPR cookie consent banner | `message`, `acceptText`, `rejectText` |
| `GlobalBlockSection` | Reusable shared block (synced) | `globalBlockId` |

## AI-Generated Block Types

These are dynamically generated by AI and have flexible props:

| Component | Description |
|-----------|-------------|
| `AICompositionBlock` | AI-composed multi-section layout |
| `AIDynamicLayoutBlock` | AI-generated responsive layout |
| `AIDynamicCardsBlock` | AI-generated card grid |
| `AIDynamicBandBlock` | AI-generated horizontal band |
| `AITemplateBlock` | AI-generated from a template prompt |

## Tips for AI Agents

1. **Use `HeroSection` as the first block** on most pages — it sets the visual tone.
2. **Wrap related content in `GridSection` or `FlexSection`** for responsive layouts.
3. **Always include `NavbarSection` + `FooterSection`** unless the site already has them globally.
4. **Use design tokens in props** — never hardcode colors. Refer to `references/design-tokens.md`.
5. **Limit pages to 50 sections max** (`MAX_SECTIONS = 50`).
6. **Page size warning at 800KB** — keep block count and image data reasonable.
7. **Vertical components require the vertical to be enabled** — check site config first.
