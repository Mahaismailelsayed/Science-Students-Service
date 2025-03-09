import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproject/auth/register/register_screen.dart';
import '../controllers/cubit/auth_cubit.dart';
import '../core/app_colors.dart';

class GlobalPassword extends StatefulWidget {
  static const String RouteName = 'global_screen';

  @override
  State<GlobalPassword> createState() => _GlobalPasswordState();
}

class _GlobalPasswordState extends State<GlobalPassword> {
  final globalPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSecure = true;

  void _togglePasswordVisibility() {
    setState(() {
      isSecure = !isSecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is GlobalSuccessState) {
            print("Navigating to RegisterScreen");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          } else if (state is FailedToGlobalState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: Stack(
              children: [
                // Bottom Section (Dark Blue)
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

                // Top Section (White with Logo & Text)
                Positioned(
                  top: 70,
                  left: 40,
                  child: Row(
                    children: [
                      // University Logo
                      Image.asset("assets/images/logo.png", height: 80),
                      // University Name
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

                // Form Container
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.4,
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
                          Text(
                            "Global Password",
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Container(
                            height: 2.5,
                            color: AppColors.primaryColor,
                            width: 120,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: isSecure,
                            cursorColor: AppColors.lightGrayColor,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.whiteColor,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.lightGrayColor, width: 2.0),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.lightGrayColor, width: 2.0),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              hintText: "Global Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isSecure ? Icons.visibility_off : Icons.visibility,
                                  color: AppColors.primaryColor,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                            controller: globalPasswordController,
                            validator: (input) {
                              if (input == null || input.isEmpty) {
                                return "GlobalPassword Required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),

                // Submit Button
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.35,
                  left: MediaQuery.of(context).size.width * 0.4,
                  child: InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context).globalPass(
                          Password: globalPasswordController.text,
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
                          colors: [AppColors.primaryColor, AppColors.lightGreenColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_forward, size: 30, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                // Loading Indicator
                if (state is GlobalLoadingState)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
