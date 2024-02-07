import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/add_album_screen.dart';
import 'package:gunita20/screens/album/album_images_screen.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:gunita20/screens/album/image_screen.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';
import 'package:gunita20/services/firebase_service.dart';
import 'package:intl/intl.dart';


class Album extends StatefulWidget {
  const Album({Key? key}) : super(key: key);

  @override
  _AlbumState createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  final FirebaseService firebaseService = FirebaseService();
  late Stream<List<MyAlbum>> albumsStream; // Declare the stream
    late String userName = ''; // Variable to store the user's name
    late DateTime userBirthday = DateTime.now();
    late String userAge = '';
    late String formattedUserBirthday = '';





  @override
  void initState() {
    super.initState();
    albumsStream = _fetchAlbumsStream(); // Initialize the stream
        _fetchUserName(); // Initialize the user's name

  }

  Future<void> _fetchUserName() async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference userDetailsCollection =
        FirebaseFirestore.instance.collection('Users/$uid/UserDetails');

    QuerySnapshot userDetailsQuery = await userDetailsCollection
        .where('first name', isNotEqualTo: null)
        .where('last name', isNotEqualTo: null)
        .where('birthday', isNotEqualTo: null)
        .limit(1)
        .get();

    if (userDetailsQuery.docs.isNotEmpty) {
      DocumentSnapshot userDetailsSnapshot = userDetailsQuery.docs.first;
      Map<String, dynamic> userDetails = userDetailsSnapshot.data() as Map<String, dynamic>;

      DateTime birthday = userDetails['birthday']?.toDate() ?? DateTime.now();
      String formattedBirthday = DateFormat('MMMM d, y').format(birthday);

      DateTime today = DateTime.now();
      int age = today.year - birthday.year - ((today.month > birthday.month || (today.month == birthday.month && today.day >= birthday.day)) ? 0 : 1);

      setState(() {
        userName = '${userDetails['first name']} ${userDetails['last name']}';
        userBirthday = birthday;
        formattedUserBirthday = formattedBirthday;
        userAge = age.toString();
      });
    } else {
      print('No UserDetails document found with required fields for UID: $uid');
    }
  } catch (error) {
    print('Error fetching user details: $error');
  }
}






  Stream<List<MyAlbum>> _fetchAlbumsStream() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference albumsCollection =
        FirebaseFirestore.instance.collection('Users/$uid/albums');

    return albumsCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return MyAlbum(
          id: doc.id,
          title: data['title'] ?? '',
          imageUrls: data['imageUrls'] != null
              ? List<String>.from(data['imageUrls'])
              : [],
        );
      }).toList();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 217, 217,1), 
      body: StreamBuilder<List<MyAlbum>>(
        stream: albumsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<MyAlbum> albums = snapshot.data ?? [];

          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/album.png'),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                      BlendMode.darken,)
                    )
                  ),
                  padding: EdgeInsets.fromLTRB(10,40,10,90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              userName,
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Magdelin',
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                              "Age: $userAge years old",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Magdelin',
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 30,),
                                Text(
                                  "Birthday: $formattedUserBirthday",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Magdelin',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(241, 245, 252, 1),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(60.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Your Memories",
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Magdelin',
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(69, 48, 178, 1),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddAlbumScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(69, 48, 178, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 14),
                            Text(
                              'Create an album',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Magdelin',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildAlbumList(albums),
                    ],
                  ),
                ),
              ),
              
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(158, 158, 158, 1).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavigationButton(Icons.home, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }),
            _buildNavigationButton(Icons.games, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameLibrary()),
              );
            }),
            _buildNavigationButton(Icons.photo_album, () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Album()),
              // );
            }),
            _buildNavigationButton(Icons.settings, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MySettings()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumList(List<MyAlbum> albums) {
  return Expanded(
    child: GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of albums per row
        crossAxisSpacing: 1.0, // Spacing between albums
        mainAxisSpacing: 1.0, // Spacing between rows
      ),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        final truncatedTitle = album.title.length > 20 // Set your desired limit
            ? album.title.substring(0, 20) + '...' // Truncate and add ellipsis
            : album.title;
        return InkWell(
          onTap: () {
            if (album.imageUrls.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDisplayScreen(
                    albumId: album.id,
                    currentUser: null,
                    album: album,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlbumImagesScreen(
                    album: album,
                    currentUser: null,
                  ),
                ),
              );
            }
          },
          
          child: Container(
            padding: EdgeInsets.fromLTRB(16.0,16,16,16),
            child: Column(
              children: [
                album.imageUrls.isNotEmpty
                    ? 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        album.imageUrls[0],
                        width: 190,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    )
                    : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                        width: 190, // Adjust the width to your desired size
                        height: 130, // Adjust the height to your desired size
                        color: Color.fromARGB(255, 228, 228, 228), // Light grey color
                        child: Icon(
                          Icons.image,
                          size: 40, // Adjust the icon size
                          color: const Color.fromRGBO(189, 189, 189, 1), // Darker grey color for the icon
                        ),
                      ),
                    ),
                SizedBox(width: 16.0),
                Text(truncatedTitle,
                style: TextStyle(
                      fontSize: 16.0, // Adjust the font size to your desired size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    ),
  );
}


  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30.0,
        color: Color.fromARGB(255, 133, 133, 133),
      ),
      onPressed: onPressed,
    );
  }
}
