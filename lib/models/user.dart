class MyUser {

  final String uid;
  
  MyUser({ required this.uid });

}

class UserData {                    // TBH replica lang ng userModel

  final String? uid;
  final String last_name;
  final String first_name;
  final String middle_name;
  final String name_extension;
  final String gender;

  const UserData({
    this.uid,
    required this.last_name,
    required this.first_name,
    required this.middle_name,
    required this.name_extension,
    required this.gender
    });

    toJson() {
  return {
    "last_name": last_name,
    "first_name": first_name,
    "middle_name": middle_name,
    "name_extension": name_extension,
    "gender": gender,
  };
}
}



