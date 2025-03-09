import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproject/core/app_colors.dart';

import '../../controllers/cubit/auth_cubit.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String RouteName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isMale = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            print("succes");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else if (state is FailedToRegisterState) {
            print("failed");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height * 0.83,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 40,
                  child: Row(
                    children: [
                      Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Faculty Of Science,\nAin Shams University",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'ENGR',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          Text(
                            "كلية العلوم جامعة عين شمس",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'andlso',
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Container(
                              height: 2.5,
                              color: AppColors.primaryColor,
                              width: 55,
                            ),
                            SizedBox(height: 25),
                            _buildTextFormField(
                              label: "First Name",
                              controller: firstNameController,
                            ),
                            _buildTextFormField(
                              label: "Last Name",
                              controller: lastNameController,
                            ),
                            _buildTextFormField(
                              label: "Email",
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            _buildTextFormField(
                              label: "Phone",
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                            ),
                            _buildTextFormField(
                              label: "Password",
                              controller: passwordController,
                              isSecure: true,
                            ),
                            _buildTextFormField(
                              label: "Confirm Password",
                              controller: confirmedPasswordController,
                              isSecure: true,
                            ),
                            _buildTextFormField(
                              label: "NID",
                              controller: idController,
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 85, right: 85),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthCubit>(context).Register(
                                      firstName : firstNameController.text.trim(),
                                      lastName : lastNameController.text.trim(),
                                      email: emailController.text.trim(),
                                      phone : phoneController.text.trim(),
                                      password: passwordController.text.trim(),
                                      confirmPassword: confirmedPasswordController.text.trim(),
                                      NID: idController.text.trim(),
                                    );
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    state is RegisterLoadingState ? "Loading..." : "Register",
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    bool isSecure = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: isSecure,
          keyboardType: keyboardType,
          cursorColor: AppColors.goldColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.goldColor, width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.goldColor, width: 2.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (input) {
            if (input == null || input.isEmpty) {
              return "$label  مطلوب ";
            }
            return null;
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildGenderRadio(String title, bool value) {
    return SizedBox(
      width: 150,
      child: RadioListTile<bool>(
        title: Text(title, style: TextStyle(color: AppColors.primaryColor)),
        value: value,
        groupValue: isMale,
        onChanged: (value) {
          setState(() {
            isMale = value!;
          });
        },
      ),
    );
  }
}