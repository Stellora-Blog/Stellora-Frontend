import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../const/Constants.dart';
import '../const/Dialog.dart';
import '../controller/RegisterController.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ever(controller.isLoading, (isLoading) {
      if (!isLoading && _shouldShowSuccess()) {
        _showSuccessDialog();
      }
    });
    _listenForFieldErrors();

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
        width: double.infinity,
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
                padding: EdgeInsets.only(bottom: hight(context) * .6),
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
                padding: EdgeInsets.only(top: 300, left: 16, right: 16),
                key: _formKey,
                child: Form(
                    child: Column(
                  children: [
                    SizedBox(height: hight(context) * .0001),
                    _buildTextField(
                        "Enter your name",
                        (val) => controller.name.value = val,
                        controller.nameError),
                    SizedBox(height: 10),
                    _buildTextField(
                        "Enter Gmail",
                        (val) => controller.email.value = val,
                        controller.emailError),
                    SizedBox(height: 10),
                    _buildTextField(
                        "Enter Password",
                        (val) => controller.password.value = val,
                        controller.passwordError,
                        obscureText: true),
                    SizedBox(height: 10),
                    _buildTextField(
                        "Confirm Password",
                        (val) => controller.confirmPassword.value = val,
                        controller.confirmPasswordError,
                        obscureText: true),
                    SizedBox(height: 15),
                    _buildRegisterButton(),
                    _buildLoginText(),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff5a1a98), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      child: Column(
        children: [
          _buildTextField("Enter your namesss",
              (val) => controller.name.value = val, controller.nameError),
          SizedBox(height: 10),
          _buildTextField("Enter Gmail", (val) => controller.email.value = val,
              controller.emailError),
          SizedBox(height: 10),
          // _buildTextField("Enter your Salary", (val) => controller.salary.value = val, controller.salaryError, keyboardType: TextInputType.number),
          SizedBox(height: 10),
          _buildTextField(
              "Enter Password",
              (val) => controller.password.value = val,
              controller.passwordError,
              obscureText: true),
          SizedBox(height: 10),
          _buildTextField(
              "Confirm Password",
              (val) => controller.confirmPassword.value = val,
              controller.confirmPasswordError,
              obscureText: true),
          SizedBox(height: 20),
          _buildRegisterButton(),
          _buildLoginText(),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, Function(String) onChanged, RxnString errorText,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Obx(() => Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: hight(Get.context!) * .025),
              child: TextFormField(
                cursorColor: Color(0xff5a1a98),
                obscureText: obscureText
                    ? (label == "Enter Password"
                        ? !controller.isPasswordVisible.value
                        : !controller.isConfirmPasswordVisible.value)
                    : false,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18,
                  ),
                  hintText: label,
                  errorText: errorText.value,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xff5a1a98), width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: label.contains("Password")
                      ? IconButton(
                          icon: Icon(
                            (label == "Enter Password"
                                    ? controller.isPasswordVisible.value
                                    : controller.isConfirmPasswordVisible.value)
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: label == "Enter Password"
                              ? controller.togglePasswordVisibility
                              : controller.toggleConfirmPasswordVisibility,
                        )
                      : null,
                ),
                onChanged: onChanged,
              ),
            )),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Obx(() => Padding(
      padding:
      EdgeInsets.symmetric(horizontal: hight(Get.context!) * .025),
      child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              backgroundColor: Color(0xff5a1a98),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed:
                controller.isLoading.value ? null : controller.registerUser,
            child: controller.isLoading.value
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2))
                : Text("Register",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ));
  }

  Widget _buildLoginText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?", style: TextStyle(color: Colors.white)),
        TextButton(
          onPressed: () => Get.toNamed("/Login"),
          child: Text("Login", style: TextStyle(color: Color(0xff5a1a98))),
        ),
      ],
    );
  }

  bool _shouldShowSuccess() {
    return controller.nameError.value == null &&
        controller.emailError.value == null &&
        controller.passwordError.value == null &&
        controller.confirmPasswordError.value == null;
  }

  void _showSuccessDialog() {
    DialogHelper.showSuccessDialog(
      title: "Success",
      message: "The account has been created successfully",
      onOkPressed: () => Get.offAllNamed('/Login'),
    );
  }

  void _listenForFieldErrors() {
    final errorListeners = [
      controller.nameError,
      controller.emailError,
      controller.passwordError,
      controller.confirmPasswordError,
    ];

    for (var error in errorListeners) {
      ever(error, (value) {
        if (value != null) {
          DialogHelper.showErrorDialog(
            title: "Error",
            message: value,
          );
        }
      });
    }
  }
}
