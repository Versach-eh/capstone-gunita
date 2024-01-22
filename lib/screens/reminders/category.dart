import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/reminders/new_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class Category {
  final String name;
  final Color color;

  Category(this.name, this.color);
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Stream<List<Category>> categoriesStream;
  List<Category> categories = [];
  Map<String, bool> selectedCategoryStates = {};

  @override
  void initState() {
    super.initState();
    categoriesStream = _getCategoriesStream();
  }

  Stream<List<Category>> _getCategoriesStream() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference categoriesCollection = FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection("categories");

    return categoriesCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Category(data['name'] ?? '', _parseColor(data['color']));
      }).toList();
    });
  }

  Color _parseColor(String colorString) {
    return Color(int.parse(colorString));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Category>>(
        stream: categoriesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          categories = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              SizedBox(height: 80),
              Text(
                'Choose category',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Magdelin',
                ),
              ),
              SizedBox(height: 80),
              ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  Category category = categories[index];

                  return Container(
                    decoration: BoxDecoration(
                      border: BorderDirectional(bottom: BorderSide(width: 1)),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Toggle the checkbox state when InkWell is tapped
                        setState(() {
                          selectedCategoryStates[category.name] =
                              !(selectedCategoryStates[category.name] ?? false);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                value: selectedCategoryStates[category.name] ??
                                    false,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategoryStates[category.name] =
                                        value!;
                                  });
                                },
                                fillColor:
                                    MaterialStatePropertyAll(category.color),
                                activeColor: category.color,
                                shape: CircleBorder(),
                                side: BorderSide.none,
                                splashRadius: 10,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                category.name,
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'Magdelin'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 100),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const NewCategoryScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Create New Category',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey.withOpacity(0.1),
                    fixedSize: Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        fixedSize: Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        _saveDataAndNavigateBack();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(150, 50),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _saveDataAndNavigateBack() {
    List<Category> selectedCategories = categories
        .where((category) => selectedCategoryStates[category.name] ?? false)
        .toList();

    // Prepare the data to pass back
    Map<String, List<Category>> data = {
      'selectedCategory': selectedCategories,
    };

    // Return the data to the previous screen
    Navigator.pop(context, data);
  }

  void resetNewCategory() {
    // Implement your reset logic here
  }
}
