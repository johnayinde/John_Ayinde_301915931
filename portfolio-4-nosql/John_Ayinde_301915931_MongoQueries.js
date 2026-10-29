// Portfolio 4: run after John_Ayinde_301915931_MongoSetup.js using mongosh.
const hotelDb = db.getSiblingDB('landmark_hotel_nosql');

print('\n1. All guest profiles (excluding MongoDB internal _id):');
printjson(hotelDb.guest_profiles.find({}, { _id: 0 }).sort({ guest_email: 1 }).toArray());

print('\n2. Guests who prefer a Suite:');
printjson(hotelDb.guest_profiles.find(
  { 'preferences.preferred_room_type': 'Suite' },
  { _id: 0, guest_email: 1, preferences: 1 }
).toArray());

print('\n3. Guests with accessibility needs:');
printjson(hotelDb.guest_profiles.find(
  { 'preferences.accessibility_needs.0': { $exists: true } },
  { _id: 0, guest_email: 1, 'preferences.accessibility_needs': 1 }
).toArray());

print('\n4. Explain lookup by unique guest_email:');
const plan = hotelDb.guest_profiles.find({ guest_email: 'amina.yusuf@example.com' }).explain('executionStats');
printjson({
  nReturned: plan.executionStats.nReturned,
  totalKeysExamined: plan.executionStats.totalKeysExamined,
  totalDocsExamined: plan.executionStats.totalDocsExamined,
  winningPlan: plan.queryPlanner.winningPlan
});
