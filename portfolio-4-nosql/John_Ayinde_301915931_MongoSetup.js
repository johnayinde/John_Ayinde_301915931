// MongoDB setup for fictional Landmark Hotel guest preferences.
// The data below is for this portfolio only.
const hotelDb = db.getSiblingDB('landmark_hotel_nosql');

const validator = {
  $jsonSchema: {
    bsonType: 'object',
    required: ['guest_email', 'preferences', 'created_at', 'updated_at'],
    properties: {
      guest_email: {
        bsonType: 'string',
        pattern: '^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$',
        description: 'Fictional guest email; required and unique'
      },
      preferences: {
        bsonType: 'object',
        required: ['preferred_room_type', 'smoking'],
        properties: {
          preferred_room_type: { bsonType: 'string' },
          bed_type: { bsonType: 'string' },
          smoking: { bsonType: 'bool' },
          accessibility_needs: { bsonType: 'array', items: { bsonType: 'string' } },
          dietary_preferences: { bsonType: 'array', items: { bsonType: 'string' } },
          interests: { bsonType: 'array', items: { bsonType: 'string' } }
        }
      },
      notification_settings: {
        bsonType: 'object',
        properties: {
          email_updates: { bsonType: 'bool' },
          sms_updates: { bsonType: 'bool' }
        }
      },
      created_at: { bsonType: 'date' },
      updated_at: { bsonType: 'date' }
    }
  }
};

if (!hotelDb.getCollectionNames().includes('guest_profiles')) {
  hotelDb.createCollection('guest_profiles', { validator, validationLevel: 'strict', validationAction: 'error' });
} else {
  hotelDb.runCommand({
    collMod: 'guest_profiles',
    validator,
    validationLevel: 'strict',
    validationAction: 'error'
  });
}

hotelDb.guest_profiles.createIndex(
  { guest_email: 1 },
  { unique: true, name: 'uq_guest_profiles_email' }
);

const now = new Date();
const profiles = [
  {
    guest_email: 'amina.yusuf@example.com',
    preferences: {
      preferred_room_type: 'Deluxe', bed_type: 'King', smoking: false,
      accessibility_needs: [], dietary_preferences: ['Vegetarian'], interests: ['Dining']
    },
    notification_settings: { email_updates: true, sms_updates: false }
  },
  {
    guest_email: 'chinedu.okafor@example.com',
    preferences: {
      preferred_room_type: 'Standard', bed_type: 'Twin', smoking: false,
      accessibility_needs: [], dietary_preferences: [], interests: ['Fitness']
    },
    notification_settings: { email_updates: true, sms_updates: true }
  },
  {
    guest_email: 'grace.mensah@example.com',
    preferences: {
      preferred_room_type: 'Suite', bed_type: 'King', smoking: false,
      accessibility_needs: ['Step-free access'], dietary_preferences: ['Vegetarian'], interests: ['Wellness', 'Dining']
    },
    notification_settings: { email_updates: false, sms_updates: true }
  },
  {
    guest_email: 'daniel.adeyemi@example.com',
    preferences: {
      preferred_room_type: 'Standard', bed_type: 'Queen', smoking: false,
      accessibility_needs: [], dietary_preferences: [], interests: ['Business travel']
    },
    notification_settings: { email_updates: true, sms_updates: false }
  }
];

profiles.forEach((profile) => {
  hotelDb.guest_profiles.updateOne(
    { guest_email: profile.guest_email },
    {
      $set: {
        guest_email: profile.guest_email,
        preferences: profile.preferences,
        notification_settings: profile.notification_settings,
        updated_at: now
      },
      $setOnInsert: { created_at: now }
    },
    { upsert: true }
  );
});

print('MongoDB database: ' + hotelDb.getName());
print('Guest profile count: ' + hotelDb.guest_profiles.countDocuments());
print('Indexes:');
printjson(hotelDb.guest_profiles.getIndexes());
