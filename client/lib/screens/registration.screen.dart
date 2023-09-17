import 'package:app/const/colors.const.dart';
import 'package:app/const/route.const.dart';
import 'package:app/controllers/auth.controller.dart';
import 'package:app/controllers/classes/response.class.dart';
import 'package:app/utils/isString.util.dart';
import 'package:app/widgets/animated_opacity_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final Controller _authController = Get.put(Controller());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  bool _passwordMatched = true;

  late final FocusNode _usernameFocus;
  late final FocusNode _confirmFocus;

  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;

  bool _isPasswordVisible = false;

  Future<void> handleRegister(email, username, password) async {
    await _authController.register(username, password, email);
    return Get.toNamed(MobileRoute.login);
  }

  @override
  void initState() {
    _emailFocus = FocusNode();
    _usernameFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmFocus = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _authController.response.value = ApiResponse(
        message: '',
        code: '00',
        data: '',
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPrimary,
        body: Column(
          children: [
            Obx(
              () => AnimatedOpacityWidget(
                statusBarHeight: statusBarHeight,
                responseCode: _authController.response.value.code,
                responseMessage: _authController.response.value.message,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Registration",
                      style: GoogleFonts.roboto(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Create your account with few steps",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: kSecondary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        focusNode: _emailFocus,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          labelText: "Email",
                          labelStyle: TextStyle(color: kLight),
                          prefixIcon: const Icon(Icons.mail_outline),
                          prefixIconColor: Colors.white,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: TextStyle(color: kLight),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: kSecondary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: usernameController,
                        focusNode: _usernameFocus,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          labelText: "Username",
                          labelStyle: TextStyle(color: kLight),
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          prefixIconColor: Colors.white,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: TextStyle(color: kLight),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: kSecondary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        focusNode: _passwordFocus,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          labelText: "Password",
                          labelStyle: TextStyle(color: kLight),
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          prefixIconColor: Colors.grey.shade400,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            child: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        style: TextStyle(color: kLight),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      decoration: BoxDecoration(
                        color: kSecondary,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: _passwordMatched
                                ? Colors.transparent
                                : Colors.red),
                      ),
                      child: TextFormField(
                        controller: confirmController,
                        focusNode: _confirmFocus,
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          labelText: "Confirm",
                          labelStyle: TextStyle(color: kLight),
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          prefixIconColor: Colors.grey.shade400,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: TextStyle(color: kLight),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 50,
                      width: double.infinity, // Make the button full-width
                      child: ElevatedButton(
                        onPressed: () async {
                          if (passwordController.text.trim() !=
                              confirmController.text.trim()) {
                            setState(() {
                              _passwordMatched = false;
                            });

                            return;
                          }
                          if (emailController.text.isNotEmpty &&
                              usernameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            await handleRegister(
                              emailController.text,
                              usernameController.text,
                              passwordController.text,
                            );
                            setState(() {
                              _passwordMatched = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 12.0,
                          ),
                        ),
                        child: _authController.isLoading.value
                            ? LoadingAnimationWidget.prograssiveDots(
                                color: kLight,
                                size: 50,
                              )
                            : Text(
                                "Sign Up".toUpperCase(),
                                style: TextStyle(color: kLight),
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: double.infinity, // Make the button full-width
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(MobileRoute.login);
                        },
                        child: Text(
                          "Already have an account?".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
