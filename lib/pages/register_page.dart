// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  // Email and password text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  // Tap to go to the login page
  final void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap,
  });

  // Register method
  Future<void> register(BuildContext context) async {
    // Get AuthService instance
    final _auth = AuthService();

    // Passwords match -> create user
    if (_pwController.text == _confirmPwController.text) {
      try {
        await _auth.signUpWithEmailPassword(
          _emailController.text.trim(),
          _pwController.text.trim(),
        );

        // Show success dialog
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Registration Successful!"),
          ),
        );

        // Clear the text fields after successful registration
        _emailController.clear();
        _pwController.clear();
        _confirmPwController.clear();

      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Registration Error"),
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      // Passwords don't match -> tell the user to fix
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 50),

              // Welcome message
              Text(
                "Let's create a new account for you",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // Email textfield
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
                focusNode: null,
              ),

              const SizedBox(height: 10),

              // Password textfield
              MyTextfield(
                hintText: "Password",
                obscureText: true,
                controller: _pwController,
                focusNode: null,
              ),

              const SizedBox(height: 10),

              // Confirm password textfield
              MyTextfield(
                hintText: "Confirm Password",
                obscureText: true,
                controller: _confirmPwController,
                focusNode: null,
              ),

              const SizedBox(height: 25),

              // Register button
              MyButton(
                text: "Register",
                onTap: () => register(context),
              ),

              const SizedBox(height: 25),

              // Login prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Login now",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
