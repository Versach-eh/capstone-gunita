class UserBirthday {
  // Include the birthday field in the model
  DateTime birthday;

  UserBirthday({
    required this.birthday,
  });

  // Create a factory method to convert Firestore data to UserBirthday object
  factory UserBirthday.fromFirestore(Map<String, dynamic> data) {
    return UserBirthday(
      birthday: data['birthday'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(
              data['birthday'].microsecondsSinceEpoch)
          : DateTime.now(),
    );
  }
}