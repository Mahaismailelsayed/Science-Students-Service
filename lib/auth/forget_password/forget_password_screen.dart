import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproject/auth/login/login_screen.dart';
import 'package:gradproject/controllers/cubit/auth_cubit.dart';
import 'package:gradproject/core/app_colors.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgetSuccessState) {
            print("Navigating to LoginScreen");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else if (state is FailedToForgetState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: AppColors.whiteColor,
              body: Stack(children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                  ),
                ),

                // اللوجو واسم الجامعة
                Positioned(
                  top: 70,
                  left: 40,
                  child: Row(
                    children: [
                      Image.asset("assets/images/logo.png", height: 80),
                      Column(
                        children: [
                          Text(
                            "Faculty Of Science,\nAin Shams University",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'ENGR',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            "كلية العلوم جامعة عين شمس",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'andlso',
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // نموذج تسجيل الدخول
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.23,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                          // إدخال اسم المستخدم
                          TextFormField(
                            controller: userNameController,
                            cursorColor: AppColors.lightGrayColor,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.lightGrayColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.lightGrayColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              hintText: "Username",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Enter The User Name";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: emailController,
                            cursorColor: AppColors.lightGrayColor,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.lightGrayColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.lightGrayColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              hintText: "Email",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Enter The Email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // إدخال كلمة المرور
                          TextFormField(
                            controller: newPasswordController,
                            cursorColor: AppColors.lightGrayColor,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.lightGrayColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.lightGrayColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              hintText: "New Password",
                              suffixIcon: Icon(Icons.visibility,
                                  color: AppColors.primaryColor),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Enter the New Password";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: confirmNewPasswordController,
                            cursorColor: AppColors.lightGrayColor,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.lightGrayColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.lightGrayColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              hintText: "Confirm New Password",
                              suffixIcon: Icon(Icons.visibility,
                                  color: AppColors.primaryColor),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Enter the  Confirm New Password";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // زر تسجيل الدخول
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.19,
                  left: MediaQuery.of(context).size.width * 0.4,
                  child: InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context).ForgetPassword(
                          userName: userNameController.text.trim(),
                          email: emailController.text.trim(),
                          newPassword: newPasswordController.text.trim(),
                          confirmNewPassword: confirmNewPasswordController.text.trim(),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.lightGreenColor
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_forward,
                            size: 30, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]));
        },
      ),
    );
  }
}
