import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix_clone_app/data/data_base_helper.dart';
import 'package:netflix_clone_app/screens/home_screen.dart';
import 'package:netflix_clone_app/screens/signup_screen.dart';
import 'package:netflix_clone_app/widgets/bottom_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    var user = await _databaseHelper.getUser(email, password);
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login successful!'),
      ));
      Get.to(BottomNavBar());
      // Navigate to home screen or dashboard
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid email or password'),
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
              autofillHints: [AutofillHints.username],
            ),
            SizedBox(
              height: 20,
            ),
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
              autofillHints: [AutofillHints.username],
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                _login();
              },
              child: Container(
                width: double.infinity * 0.8,
                height: 45,
                child: Center(child: Text("Login")),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text(
                "Don't have an account? Sign Up",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
