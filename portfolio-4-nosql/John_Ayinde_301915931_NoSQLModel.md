# NoSQL Model and Suitability

## Selected model
MongoDB document database. Collection: `guest_profiles`.

## Example document shape
A profile document uses a stable `guest_email` reference and nests preferences and notification settings:

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

The sample profile is fictional. The setup script adds `created_at` and `updated_at` timestamps and configures MongoDB schema validation.

## Why a document model?
- Preference fields can vary by guest and may evolve over time.
- Nested arrays and objects naturally represent preferences and notification settings.
- A unique index on `guest_email` supports lookup and prevents duplicate profiles.
- The model is straightforward to query by preferred room type or accessibility needs.

## Why not store everything in MongoDB?
The project keeps core bookings, room assignments and payments in PostgreSQL because they use relational constraints and transactional rules. Duplicating those core records across two systems would introduce synchronisation and consistency work. MongoDB is used here for flexible guest preference documents, not as the source of truth for payment processing or room allocation.

## Relationship to the relational database
`guest_email` matches the unique `guests.email` value in PostgreSQL. This is an application-level reference; MongoDB does not enforce a foreign key to PostgreSQL. A production integration would need an explicit synchronization policy and failure handling.

## Limitations and security
- Email is used as a stable example key for the portfolio; production systems should use carefully governed identifiers and access controls.
- Do not store payment-card data or sensitive personal information in this sample collection.
- Use database authentication, least-privilege roles, encrypted connections and appropriate backup policies in any real deployment.
- Document validation helps maintain shape but does not replace business rules or authorization.
