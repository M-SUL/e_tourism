import 'dart:convert';
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
      home: const LoginScreen(),
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



  // Handle login
  // void _handleLogin() {
  //   if (_formKey.currentState!.validate()) {
  //     String email = _emailController.text;
  //     String password = _passwordController.text;
  //
  //     if (email == "test@example.com" && password == "password123") {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Valid login credentials')),
  //       );
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const RegistrationScreen()),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Invalid login credentials')),
  //       );
  //     }
  //   }
  // }

  Future<void> _loginUser(String email, String password) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/login');
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
      backgroundColor: Colors.purple[25],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image Widget for the Icon
                  Image.asset(
                    'lib/images/travelling.png',
                    height: 125,
                    width: 125,
                  ),
                  const SizedBox(height: 80),

                  // Email TextField
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),

                  // Password TextField
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.deepPurple, // Button color
                    ),
                    child: const Text('Log In',
                    style: TextStyle(
                      color: Colors.white
                    ),),
                  ),
                  const SizedBox(height: 16),

                  // NEW USER label
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'NEW USER',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sign in button (for new user registration)
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the registration screen for new users
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistrationScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text('Sign in',
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                  ),
                ],
              ),
            ),
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
    final url = Uri.parse('http://10.0.2.2:8000/api/register');
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
      backgroundColor: Colors.purple[25],
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/travelling.png',
                height: 125,
                width: 125,
              ),
              const SizedBox(height: 80),
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
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('Register',
                style: TextStyle(
                  color: Colors.white
                )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// RegistrationScreen widget
// class RegistrationScreen extends StatelessWidget {
//   const RegistrationScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('E_Tourism Registration'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Register',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 24),
//             const TextField(
//               decoration: InputDecoration(
//                 labelText: 'Full Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const TextField(
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const TextField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () {
//                 print("Register button pressed");
//               },
//               child: const Text('Register'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



