import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix_clone_app/data/data_base_helper.dart';
import 'package:netflix_clone_app/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _signup() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    Map<String, dynamic> user = {
      'name': name,
      'email': email,
      'password': password,
    };

    try {
      await _databaseHelper.insertUser(user);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User registered successfully!'),
      ));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            "assets/logo.png",
            height: 50,
            width: 120,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle:
                    TextStyle(color: Colors.white), // Maintain white text color
                filled: true, // Set background color
                fillColor: Colors.grey.withOpacity(0.2), // Grey background
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust border radius for roundness
                  borderSide: BorderSide(
                      color: Colors.red, width: 2.0), // Red border with width
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  //  cursorColor: Colors.red, // Maintain red border
                ),
                // Set red cursor color
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle:
                    TextStyle(color: Colors.white), // Maintain white text color
                filled: true, // Set background color
                fillColor: Colors.grey.withOpacity(0.2), // Grey background
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust border radius for roundness
                  borderSide: BorderSide(
                      color: Colors.red, width: 2.0), // Red border with width
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  //  cursorColor: Colors.red, // Maintain red border
                ),
                // Set red cursor color
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle:
                    TextStyle(color: Colors.white), // Maintain white text color
                filled: true, // Set background color
                fillColor: Colors.grey.withOpacity(0.2), // Grey background
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust border radius for roundness
                  borderSide: BorderSide(
                      color: Colors.red, width: 2.0), // Red border with width
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                  //  cursorColor: Colors.red, // Maintain red border
                ),
                // Set red cursor color
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                _signup();
              },
              child: Container(
                width: double.infinity * 0.8,
                height: 45,
                child: Center(child: Text("Sign Up")),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Already have an account? Login',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
