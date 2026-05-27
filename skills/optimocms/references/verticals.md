# Verticals Reference

OptimoCMS supports multiple business verticals. Each vertical adds
domain-specific features, components, and API endpoints to a site.

Verticals require `verticals` permission on the API key and the
corresponding vertical flag enabled on the site's tier.

## Booking & Reservations

Appointment scheduling for services (salons, clinics, consultants).

### MCP Tools

| Tool | Description |
|------|-------------|
| `get_available_slots` | Get free time slots for a date |
| `create_booking` | Book an appointment |
| `list_bookings` | List bookings (filter by status/date) |

### SDK Methods

```typescript
// Check availability
const slots = await client.booking.getSlots(siteId, {
  serviceId: 'haircut',
  date: '2026-06-15',
  staffId: 'stylist-1',       // optional
});

// Create booking
const booking = await client.booking.create(siteId, {
  serviceId: 'haircut',
  date: '2026-06-15',
  startTime: '14:00',
  customer: { name: 'Jan de Vries', email: 'jan@example.com', phone: '+31612345678' },
});

// List bookings
const bookings = await client.booking.list(siteId, { status: 'confirmed', date: '2026-06-15' });
```

### Puck Components

- `BookingWidget` — appointment calendar with time slot picker
- `ReservationWidget` — restaurant-style table reservation

### Booking Statuses

`pending` → `confirmed` → `completed`
`pending` → `cancelled`
`confirmed` → `no_show`

---

## Ecommerce (Shop)

Product catalog, orders, and coupons.

### MCP Tools

| Tool | Description |
|------|-------------|
| `list_products` | List products (filter by category) |
| `create_product` | Create a product (price in cents!) |
| `update_product` | Update product fields |
| `list_orders` | List orders (filter by status) |

### SDK Methods

```typescript
// Products
const products = await client.shop.products.list(siteId, { category: 'pizza' });
await client.shop.products.create(siteId, {
  title: 'Margherita',
  priceCents: 1299,    // €12.99
  category: 'Pizza',
  stock: 100,
});
await client.shop.products.update(siteId, productId, { priceCents: 1499, active: true });

// Orders
const orders = await client.shop.orders.list(siteId, { status: 'paid' });

// Coupons
await client.shop.coupons.create(siteId, {
  code: 'SUMMER20',
  type: 'percentage',
  value: 20,
  maxUses: 100,
  expiresAt: '2026-09-01T00:00:00Z',
});
```

### Important

- **Prices are always in cents** — `1999` = €19.99
- Default currency is EUR
- `stock: null` means unlimited stock

### Puck Components

- `ProductListSection` — product catalog grid (1-4 columns)
- `ProductDetailSection` — single product detail page
- `OrderConfirmationSection` — post-purchase confirmation
- `DeliveryTrackerSection` — delivery status tracking

### Order Statuses

`pending` → `paid` → `shipped` → `delivered` → `completed`
`paid` → `cancelled` → `refunded`

---

## Loyalty

Points-based loyalty program with rewards.

### MCP Tools

| Tool | Description |
|------|-------------|
| `get_member_status` | Get member points balance and tier |
| `earn_points` | Award points to a member |
| `list_rewards` | List available rewards |

### SDK Methods

```typescript
// Check member
const member = await client.loyalty.getMember(siteId, memberId);
// member.points, member.tier, member.lifetimePoints

// Award points
await client.loyalty.earnPoints(siteId, {
  memberId: 'member_123',
  points: 50,
  description: 'Aankoop pizza',
  amountCents: 1299,
});

// Redeem reward
await client.loyalty.redeemReward(siteId, {
  memberId: 'member_123',
  rewardId: 'free-coffee',
});

// List rewards
const rewards = await client.loyalty.listRewards(siteId, { active: true });
```

### Puck Components

- `LoyaltyWidget` — points balance with earn/redeem
- `LoyaltyStampCard` — digital stamp card (buy 10 get 1 free)
- `LoyaltyLeaderboard` — top members ranking
- `LoyaltyRewardsSection` — available rewards catalog

---

## Reviews

Customer review management with moderation.

### MCP Tools

| Tool | Description |
|------|-------------|
| `list_reviews` | List reviews (filter: all/pending/approved/rejected) |

### SDK Methods

```typescript
const reviews = await client.reviews.list(siteId, { status: 'pending' });
// Each review: { id, customerName, rating (1-5), title, body, approved, rejected }
```

### Puck Components

- `ExternalReviewsSection` — displays reviews from Google/Trustpilot
- `TestimonialSection` — manually curated testimonials (not a vertical, always available)

---

## Recruitment

Job vacancy management with applications.

### MCP Tools

| Tool | Description |
|------|-------------|
| `list_jobs` | List vacancies (filter by status) |
| `create_job` | Create a job vacancy (starts as draft) |

### SDK Methods

```typescript
// Create job
await client.recruitment.createJob(siteId, {
  title: 'Senior Frontend Developer',
  description: 'We zoeken een ervaren developer...',
  department: 'Engineering',
  jobType: 'full_time',
  location: 'Amsterdam',
});

// List jobs
const jobs = await client.recruitment.listJobs(siteId, { status: 'published' });
```

### Job Statuses

`draft` → `review` → `published` → `closed` / `filled`
`published` → `paused` → `published`
Any → `archived`

### Job Types

`full_time`, `part_time`, `contract`, `internship`, `volunteer`, `temporary`

### Puck Components

- `RecruitmentWidget` — job listings with application form
- `RecruitmentJobAlertWidget` — email alerts for new positions
- `JobPostingJsonLdSection` — Schema.org structured data for SEO

---

## Hospitality (Rental & Parks)

Vacation rentals and holiday parks.

### Puck Components

- `RentalBlock` — accommodation listing with availability
- `ParkBlock` — vacation park with unit overview

---

## Real Estate

Property listings, agents, and market data.

### Puck Components

- `RealEstateListingsBlock` — property grid (sale/rent filter)
- `RealEstateFeaturedBlock` — featured properties carousel
- `RealEstateRecentBlock` — recently added listings
- `RealEstateStatsBlock` — market statistics
- `RealEstateCitiesBlock` — properties per city
- `RealEstateAgentBlock` — single agent profile
- `RealEstateAgentGridBlock` — agent team grid

---

## Vertical Tier Requirements

| Vertical | Required Tier |
|----------|--------------|
| Booking | Professional+ |
| Ecommerce | Professional+ |
| Loyalty | Professional+ |
| Reviews | Professional+ |
| Recruitment | Professional+ |
| Real Estate | Agency |
| Hospitality | Agency |
