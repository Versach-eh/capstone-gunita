class ContactInfo {
  String contactNumber;
  String email;

  ContactInfo({
    required this.contactNumber,
    required this.email,
  });

  // Create a factory method to convert Firestore data to ContactInfo object
  factory ContactInfo.fromFirestore(Map<String, dynamic> data) {
    return ContactInfo(
      contactNumber: data['contactNumber'],
      email: data['email'],
    );
  }
}