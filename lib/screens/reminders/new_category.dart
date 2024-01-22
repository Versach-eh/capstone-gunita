import 'package:flutter/material.dart';

class NewCategoryScreen extends StatefulWidget {
  final VoidCallback resetNewCategory;
  final Function(Map<String, dynamic>) onCategorySaved;

  const NewCategoryScreen({
    Key? key,
    required this.resetNewCategory,
    required this.onCategorySaved,
  }) : super(key: key);

  @override
  _NewCategoryScreenState createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  TextEditingController _titleController = TextEditingController();

  List<Color> colorChoices = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
  ];

  Color selectedColor = Colors.red; // Default color

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void onSaveButtonPressed() {
    // Get the category name and color from the text field and selected color
    String categoryName = _titleController.text;
    Color categoryColor = selectedColor;

    // Pass the category name and color back to the previous screen
    Map<String, dynamic> result = {
      'categoryName': categoryName,
      'categoryColor': categoryColor,
    };

    widget.onCategorySaved(result);
    widget
        .resetNewCategory(); // Call the reset method before popping the screen
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
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
          SizedBox(height: 70),
          Container(
            width: 300,
            height: 250,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 184, 183, 183).withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white, width: 4.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        border: InputBorder.none,
                        hintText: 'Category name',
                        hintStyle: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'Magdelin',
                          color: Colors.black,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Magdelin',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Choose color:',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: colorChoices.map((Color color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedColor == color
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Back button press
                    widget
                        .resetNewCategory(); // Call the reset method before popping the screen
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
                  onPressed: onSaveButtonPressed,
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
}
