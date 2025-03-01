import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  static const String RouteName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _controller = TextEditingController();
  final List<String> options = ["Male", "Female"];

  String? selectedGender; // ✅ المتغير لتخزين الجنس المختار


  @override
  Widget build(BuildContext context) {
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
                    color: AppColors.whiteColor, // Dark Blue color
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
                            // University Logo
                            Container(
                              width: 85,
                              height: 85,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle, // ✅ يجعل الـ Container دائري
                                image: DecorationImage(
                                  image: AssetImage("assets/images/logo.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
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
                                ]
                            ),
                          ]
                      )
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
                       child: Column(
                           children: [
                             // Login Title
                             Text(
                               textAlign: TextAlign.start,
                               "Sign up",
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
                             SizedBox(height: 25),

                             // Username Input
                             buildTextField("First Name"),
                             buildTextField("Last Name"),
                             buildTextField("Phone", keyboardType: TextInputType.phone),
                             buildTextField("ID", keyboardType: TextInputType.number),
                             buildTextField("Email", keyboardType: TextInputType.emailAddress),
                             buildTextField("Password", isPassword: true),
                             buildTextField("Confirm Password", isPassword: true),

                             SizedBox(height: 10,),

                             Row(
                               children: [
                                 Text(
                                   textAlign: TextAlign.left,
                                   "Gender",
                                   style: TextStyle(
                                     fontStyle: FontStyle.normal,
                                     fontSize: 15,
                                     fontWeight: FontWeight.w700,
                                     color: AppColors.primaryColor,
                                   ),
                                 ),
                               ],
                             ),
                             TextField(
                               controller: _controller,
                               readOnly: true, // لا يسمح بالكتابة اليدوية
                               decoration: InputDecoration(
                                 enabledBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(10),
                                   borderSide: BorderSide(
                                     color: AppColors.goldColor,
                                     width: 2.0,), // Default border color
                                 ),
                                 focusedBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(10),
                                   borderSide: BorderSide(
                                       color: AppColors.goldColor,
                                       width: 2.0),
                                 ),
                                 suffixIcon: PopupMenuButton<String>(
                                   icon: Icon(Icons.arrow_drop_down,size: 35,color: AppColors.goldColor,), // أيقونة القائمة المنسدلة
                                   onSelected: (String value) {
                                     setState(() {

                                       _controller.text = value;
                                     });
                                   },
                                   itemBuilder: (BuildContext context) {
                                     return options.map((String choice) {
                                       return PopupMenuItem<String>(
                                         value: choice,
                                         child: Text(choice,style: TextStyle(
                                           fontStyle: FontStyle.normal,
                                           fontSize: 15,
                                           fontWeight: FontWeight.w700,
                                           color: AppColors.primaryColor,
                                         ),),
                                       );
                                     }).toList();
                                   },
                                 ),
                               ),
                             ),
                             SizedBox(height: 20),
                             Padding(
                               padding: const EdgeInsets.only(left: 85,right: 85),
                               child: ElevatedButton(
                                 style: ElevatedButton.styleFrom(
                                   backgroundColor: AppColors.primaryColor,
                                   padding: EdgeInsets.symmetric(vertical: 12),
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                 ),
                                 onPressed: ()  => showPopup(context),
                                 child: Center(
                                   child: Text(
                                     "Register",
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
            ]
        )
    );
  }

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // منع الإغلاق بالضغط خارج النافذة
      builder: (BuildContext context) {
        // تشغيل المؤقت لإغلاق النافذة بعد 3 ثوانٍ
        Future.delayed(Duration(seconds: 1), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        });

        return AlertDialog(
          title: Text("Registration completed successfully.",style: TextStyle(color:AppColors.primaryColor,fontSize: 18,fontFamily:"IMPRISHA",fontWeight: FontWeight.w600 )),
          icon: Icon(Icons.check,color: AppColors.primaryColor,size: 50,)
        );
      },
    );
  }

  Widget buildTextField(String label, {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
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
        TextField(
          obscureText: isPassword,
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
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
