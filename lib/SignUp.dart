
import 'package:flutter/material.dart';
import 'package:flutter_application_100/home2.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SIGN UP",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFA45963),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[100],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formState,
              child: Column(
                children: <Widget>[
                  
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/library_welcome.png"),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      hintText: "Enter your username",
                      prefixIcon:
                          const Icon(Icons.person, color: Color(0xFFA45963)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your username';
                      } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return "Please use only letters (A-Z, a-z)";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                      prefixIcon:
                          const Icon(Icons.lock, color: Color(0xFFA45963)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

          
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      prefixIcon:
                          const Icon(Icons.email, color: Color(0xFFA45963)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email';
                      } else if (!value.contains('@') ||
                          !value.endsWith('.com')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

               
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Phone",
                      hintText: "Enter your phone number",
                      prefixIcon:
                          const Icon(Icons.phone, color: Color(0xFFA45963)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your phone number';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  
                  ElevatedButton(
                    onPressed: () {
                      if (formState.currentState!.validate()) {
                        String username = usernameController.text;
                        String email = emailController.text;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              username: username,
                              email: email,
                            ),
                          ),
                          (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all fields correctly"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA45963),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
