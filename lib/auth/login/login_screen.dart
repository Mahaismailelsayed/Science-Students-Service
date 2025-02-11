import 'package:flutter/material.dart';
import 'package:gradproject/core/app_colors.dart';

class LoginScreen extends StatefulWidget {
  static const String RouteName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
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
                color: AppColors.primaryColor, // Dark Blue color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
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
                Image.asset("assets/images/logo.jpg", height: 80), // Replace with your logo

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
                  ]
                ),
              ],
            ),
          ),

          // Login Card (Floating on the Curve)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
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
              child: Column(
                children: [
                  // Login Title
                  Text(
                    textAlign: TextAlign.start,
                    "Login",
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
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
                  SizedBox(height: 15),

                  // Username Input
                  TextField(
                    cursorColor: AppColors.lightGrayColor,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightGrayColor, width: 2.0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightGrayColor, width: 2.0),
                        borderRadius: BorderRadius.circular(50),
// Border color when focused
                      ),
                      prefixIcon: Icon(Icons.person,color: AppColors.primaryColor,),
                      hintText: "Username",

                    ),
                  ),
                  SizedBox(height: 10),

                  // Password Input
                  TextField(
                    cursorColor: AppColors.lightGrayColor,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightGrayColor, width: 2.0),
                        borderRadius: BorderRadius.circular(50),

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightGrayColor, width: 2.0),
                        borderRadius: BorderRadius.circular(50),
// Border color when focused
                      ),
                      prefixIcon: Icon(Icons.lock,color: AppColors.primaryColor,),
                      hintText: "Password",

                      suffixIcon: Icon(Icons.visibility,color: AppColors.primaryColor,),
                    ),
                  ),

                  // Remember Me Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        activeColor: AppColors.primaryColor,
                        checkColor: AppColors.whiteColor,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      Text("Remember Me",style: TextStyle(color: Colors.black45),),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Circular Login Button (Floating Over the Split)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.4,
            child: InkWell(
              onTap: () {
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
            )
          ),

          // Social Media Icons (At the Bottom)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.facebook, size: 30, color: Colors.white),
                SizedBox(width: 100),
                Icon(Icons.play_circle_fill, size: 30, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
