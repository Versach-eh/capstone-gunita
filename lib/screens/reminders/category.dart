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
  List<Category> categories = [
    Category('Daily Routine', Colors.purple),
    Category('Birthday', Colors.red),
    Category('Medicine', Colors.blue),
    // Add more predefined categories as needed
  ];

  List<Category> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 80),
          Text(
            'Choose category.',
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
              return Column(
                children: [
                  if (index > 0) Divider(color: Colors.black, thickness: 2.0),
                  buildSelectionButton(
                    text: categories[index].name,
                    onPressed: () => toggleCategorySelection(categories[index].name),
                    isSelected: isCategorySelected(categories[index].name),
                    dynamicColor: categories[index].color,
                  ),
                ],
              );
            },
          ),

          SizedBox(height: 100),

          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(top: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                // Category? result = await Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => NewCategoryScreen(
                //       resetNewCategory: resetNewCategory,
                //       onCategorySaved: (category) {
                //         setState(() {
                //           categories.add(Category(category['categoryName'], category['categoryColor']));
                //           toggleCategorySelection(category['categoryName']);
                //         });
                //       },
                //     ),
                //   ),
                // );

                // if (result != null) {
                //   setState(() {
                //     categories.add(result);
                //     toggleCategorySelection(result.name);
                //   });
                // }
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
                    if (selectedCategories.isNotEmpty) {
                      // Assuming you want to send the first selected category in the list
                      Category selectedCategory = selectedCategories.first;
                      Navigator.pop(context, {'selectedCategory': selectedCategory});
                    } else {
                      // Handle the case where no category is selected
                      Navigator.pop(context, {'selectedCategory': null});
                    }
                  },
                  child: Text(
                    'Save',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectionButton({
    required String text,
    required VoidCallback onPressed,
    required bool isSelected,
    Color? dynamicColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.grey.withOpacity(0.3) : Colors.transparent,
        onPrimary: isSelected ? Colors.black : Colors.transparent,
        elevation: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 15.0,
              backgroundColor: dynamicColor ?? Colors.grey.withOpacity(0.5),
            ),
            SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 23.0,
                fontFamily: 'Magdelin',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetNewCategory() {
    // Implement your reset logic here
  }

  void toggleCategorySelection(String categoryName) {
    setState(() {
      if (isCategorySelected(categoryName)) {
        selectedCategories.removeWhere((category) => category.name == categoryName);
      } else {
        // Check if the category is not already selected to avoid duplicates
        if (!selectedCategories.any((category) => category.name == categoryName)) {
          Category category = categories.firstWhere(
            (category) => category.name == categoryName,
            orElse: () => Category('', Colors.transparent),
          );
          selectedCategories.add(category);
        }
      }
    });
  }

  bool isCategorySelected(String categoryName) {
    return selectedCategories.any((category) => category.name == categoryName);
  }
}
