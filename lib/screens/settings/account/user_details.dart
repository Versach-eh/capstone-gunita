class UserDetails {
  String firstName;
  String lastName;
  String middleName;
  String nameExtension;

  UserDetails({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.nameExtension,
  });

  // Create a factory method to convert Firestore data to UserDetails object
  factory UserDetails.fromFirestore(Map<String, dynamic> data) {
    return UserDetails(
      firstName: data['firstName'],
      lastName: data['lastName'],
      middleName: data['middleName'],
      nameExtension: data['nameExtension'],
    );
  }
}