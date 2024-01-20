// firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:gunita20/screens/jigsaw/game_difficulty.dart';
import 'package:gunita20/screens/settings/account/conctact_info.dart';
import 'package:gunita20/screens/settings/account/user_birthday.dart';
import 'package:gunita20/screens/settings/account/user_details.dart';


class FirebaseService {
  final user = FirebaseAuth.instance.currentUser!;
  
  
  late final CollectionReference albumsCollection =                       //auto creates firestore collection > album under user logged in
      FirebaseFirestore.instance.collection('Users/${user.uid}/albums');



  Future<List<MyAlbum>> getAlbums() async {                               // load albums but not real time
    final QuerySnapshot snapshot = await albumsCollection.get();
    return snapshot.docs.map((doc) => _albumFromDocument(doc)).toList();
  }



  MyAlbum _albumFromDocument(DocumentSnapshot document) {
    return MyAlbum(
      id: document.id,
      title: document['title'],
      imageUrls: List<String>.from(document['imageUrls']),
      // imageTexts: List<String>.from(document['imageTexts']),
    );
  }


  Future<void> addAlbum(MyAlbum album) async {        // CREATES the NEW album in that specific firestore collection
    await albumsCollection.add({
      'title': album.title,
      'imageUrls': album.imageUrls,
      // 'imageTexts': album.imageTexts,
    });
  }



  Future<void> addImageToAlbum(String albumId, String imageUrl) async {
    await albumsCollection.doc(albumId).update({
      'imageUrls': FieldValue.arrayUnion([imageUrl]),
    });
  }

  // UPDATE USER DETAILS AREA

  Future<UserDetails?> getCurrentUserDetails(String userId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('UserDetails')
        .doc('details')
        .get();

    if (doc.exists) {
      return UserDetails.fromFirestore(doc.data() as Map<String, dynamic>);
    }

    return null;
  }

  Future<void> updateUserDetails(String userId, UserDetails userDetails) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('UserDetails')
        .doc('details')
        .set({
      'firstName': userDetails.firstName,
      'lastName': userDetails.lastName,
      'middleName': userDetails.middleName,
      'nameExtension': userDetails.nameExtension,
    });
  }



  // bday update
  Future<UserBirthday?> getCurrentUserBirthday(String userId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('UserBirthday')
        .doc('birthday')
        .get();

    if (doc.exists) {
      return UserBirthday.fromFirestore(doc.data() as Map<String, dynamic>);
    }

    return null;
  }

  Future<void> updateBirthday(String userId, DateTime birthday) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('UserBirthday')
        .doc('birthday')
        .set({'birthday': birthday});
  }

  Future<ContactInfo?> getCurrentUserContactInfo(String userId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('ContactInfo')
        .doc('info')
        .get();

    if (doc.exists) {
      return ContactInfo.fromFirestore(doc.data() as Map<String, dynamic>);
    }

    return null;
  }

  Future<void> updateContactInfo(
      String userId, String contactNumber, String email) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('ContactInfo')
        .doc('info')
        .set({
      'contactNumber': contactNumber,
      'email': email,
    });
  }

  // record score under that difficulty
  Future<void> addScore(Difficulty difficulty) async {     
    await jigsawScoresCollection.add({
      'scoresTimerValues': difficulty.scoresTimerValues,
    });
  }

 //auto creates firestore collection > Scoreboard under user logged in. change to each game
  late final CollectionReference jigsawScoresCollection =
      FirebaseFirestore.instance.collection('Users/${user.uid}/Jigsaw');

}

  
