import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../const/Constants.dart';
import '../controller/LoginController.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final LoginController controller = Get.put(LoginController());

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final success = await controller.login(
            _emailController.text, _passwordController.text);
        setState(() {
          _isLoading = false;
        });
        if (success) {
          Get.dialog(
            AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 24),
                  SizedBox(width: 8),
                  Text('Success', style: TextStyle(color: Colors.green)),
                ],
              ),
              content: Text('Login successful! Welcome back.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.offAllNamed('/home');
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        Get.dialog(
          AlertDialog(
            title: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 24),
                SizedBox(width: 8),
                Text('Error', style: TextStyle(color: Colors.red)),
              ],
            ),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff8527E1),
              Color(0xff902AF3),
              Color(0xff9E3AFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Photo/Logo.svg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.0),
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.2),
                    ],
                    stops: [0.0, 0.4, 1.0],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: SvgPicture.asset(
                      'assets/Photo/Logo.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: hight(context) * .4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/Photo/Logo.svg',
                      height: hight(context) * .06,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Stellora',
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(top: 400, left: 16, right: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 32),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: hight(Get.context!) * .025),
                        child: TextFormField(
                          cursorColor: Colors.deepPurple,
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'username',
                            labelStyle: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: hight(Get.context!) * .025),
                        child: TextFormField(
                          cursorColor: Colors.deepPurple,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: hight(Get.context!) * .030),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff5a1a98),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _isLoading ? null : _handleLogin,
                            child: _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: hight(context) * .01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: TextStyle(color: Colors.white)),
                          TextButton(
                            onPressed: () => Get.toNamed("/Register"),
                            child: Text("Register",
                                style: TextStyle(
                                  color: Color(0xff5a1a98),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
