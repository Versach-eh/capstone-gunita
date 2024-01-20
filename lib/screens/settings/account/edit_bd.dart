import 'package:flutter/material.dart';
import 'package:gunita20/screens/settings/account/user_birthday.dart';
import 'package:gunita20/services/firebase_service.dart';


class BirthdayScreen extends StatefulWidget {
  final String userId;

  const BirthdayScreen({super.key, required this.userId});

  @override
  _BirthdayScreenState createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBirthday();
  }

  void _loadBirthday() async {
    FirebaseService firestoreService = FirebaseService();
    UserBirthday? userBirthday =
        await firestoreService.getCurrentUserBirthday(widget.userId);

    if (userBirthday != null) {
      setState(() {
        _selectedDate = userBirthday.birthday;
        _isLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4f22cd),
        title: const Text('Edit Birthday'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: const Text('Birthday'),
                    subtitle: Text(
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    ),
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveBirthday,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
    );
  }

  void _saveBirthday() async {
    FirebaseService firestoreService = FirebaseService();

    await firestoreService.updateBirthday(widget.userId, _selectedDate);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Birthday updated successfully.')),
    );
  }
}