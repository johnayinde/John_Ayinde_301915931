# Portfolio 4: MongoDB Guest Preference Model

I used MongoDB for guest preferences rather than for the hotel’s core reservation records. Preferences can differ greatly between guests and may gain new fields over time, so a document model fits this part of the system well.

## Collection and document structure

The collection is called `guest_profiles`. Each document uses the guest's email address as an example reference to the PostgreSQL `guests.email` value, then groups related preferences and notification settings together.

```json
{
  "guest_email": "amina.yusuf@example.com",
  "preferences": {
    "preferred_room_type": "Deluxe",
    "bed_type": "King",
    "smoking": false,
    "accessibility_needs": [],
    "dietary_preferences": ["Vegetarian"],
    "interests": ["Dining"]
  },
  "notification_settings": {
    "email_updates": true,
    "sms_updates": false
  }
}
```

The sample email and preferences are fictional. The setup script adds `created_at` and `updated_at`, validates the main document shape, and creates a unique index on `guest_email`.

## Why this is suitable

- Guests will not all have the same preference fields.
- Related arrays and nested settings can be read and updated together.
- The unique email index supports direct lookups and prevents duplicate profile documents.
- The structure supports queries such as finding guests who prefer a room type or need accessibility support.

## Why bookings remain in PostgreSQL

Bookings, room assignments and payments need referential integrity and transaction rules, especially the rule against overlapping active room reservations. Moving those records to a separate document database would add synchronisation and consistency problems without helping this small use case. PostgreSQL remains the source of truth for that data.

## Relationship and limits

MongoDB does not enforce a foreign key to PostgreSQL, so the email reference is managed by the application. In a real system, I would define how profile creation, changes and failures are handled between the two databases.

This portfolio does not use real guest data, card details, passwords or connection strings. A production version would also need authentication, least-privilege roles, encrypted connections and tested backups.
