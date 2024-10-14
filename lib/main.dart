import 'dart:convert';
import 'package:e_tourism/screens/driversListScreen.dart';
import 'package:e_tourism/screens/editGuide.dart';
import 'package:e_tourism/screens/guidesListScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E_Tourism',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home:  Guideslistscreen(),
    );
  }
}



// LoginScreen widget
class LoginScreen extends StatefulWidget  {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey for form validation
  final _emailController = TextEditingController(); // Controller for email input
  final _passwordController = TextEditingController(); // Controller for password input

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to validate email format
  String? _validateEmail(String? value) {
    const emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(emailPattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Function to validate password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }


  Future<void> _loginUser(String email, String password) async {
    final url = Uri.parse('http://localhost:5000/api/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',  // Set content type to JSON
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),  // Encode body as JSON
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print('Login successful: $responseBody');

      // Extract the full_name from the response
      String fullName = responseBody['full_name'];

      // Check if the widget is still mounted before using context
      if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );
      // Navigate to the RegistrationScreen (or the home screen/dashboard)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(userName: fullName),
        ),
      );
    } else {
      if (!mounted) return;  // Safeguard before showing a snackbar

      print('Failed to login. Status code: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid login credentials')),
      );
    }
  }



  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      print('Email: $email');
      print('Password: $password');

      await _loginUser(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E_Tourism Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the RegistrationScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationScreen()),
                      );
                    },
                    child: const Text('Register'),
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

class WelcomeScreen extends StatelessWidget {
  final String userName;

  const WelcomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Text(
          'Welcome $userName',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}



class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    const emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(emailPattern);
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }






  // void _handleRegistration() {
  //   if (_formKey.currentState!.validate()) {
  //     String fullName = _fullNameController.text;
  //     String email = _emailController.text;
  //     String password = _passwordController.text;
  //     // Simulate API call here, for now, just print to console.
  //     print('Full Name: $fullName');
  //     print('Email: $email');
  //     print('Password: $password');
  //     // Navigate to another page, maybe login after successful registration
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Registration Successful')),
  //     );
  //     Navigator.pop(context); // Go back to login after successful registration
  //   }
  // }

  Future<void> _registerUser(String fullName, String email, String password) async {
    final url = Uri.parse('http://localhost:5000/api/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',  // Set content type to JSON
      },
      body: jsonEncode({
        'full_name': fullName,
        'email': email,
        'password': password,
      }),  // Encode body as JSON
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print('User registered successfully: $responseBody');

      // Check if the widget is still mounted before using context
      if (!mounted) return;

      // Navigate back to LoginScreen after successful registration
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful')),
      );

      Navigator.pop(context);  // Go back to login screen
    } else {
      if (!mounted) return;  // Safeguard before showing a snackbar

      print('Failed to register user. Status code: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to register user')),
      );
    }
  }


  void _handleRegistration() async {
    if (_formKey.currentState!.validate()) {
      String fullName = _fullNameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      await _registerUser(fullName, email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E_Tourism Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Register',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: _validateFullName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _handleRegistration,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




