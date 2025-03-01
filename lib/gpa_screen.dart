import 'package:flutter/material.dart';
import 'package:gradproject/core/app_colors.dart';

class GpaScreen extends StatefulWidget {
  static const String RouteName = 'gpa_screen';

  @override
  State<GpaScreen> createState() => _GpaScreenState();
}

class _GpaScreenState extends State<GpaScreen> {

  final TextEditingController _controller = TextEditingController();
  final List<String> options = ["A", "A-", "B+","B","C+","C","D","F"];

    @override
    Widget build(BuildContext context) {
      return Stack(children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,

            leading: IconButton(
              icon: Icon(
                Icons.arrow_back, color: AppColors.whiteColor, size: 25,),
              onPressed: () {
                Navigator.pop(context); // يرجع للصفحة السابقة
              },
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.lightGreenColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            title: Text('GPA Calculator',
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontFamily: 'IMPRISHA',
                    fontSize: 20,
                    fontWeight: FontWeight.w700)
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightGreen.shade200,
                            Colors.lightGreen.shade400
                          ], // اللونين
                          begin: Alignment.topLeft, // نقطة البداية
                          end: Alignment.bottomRight, // نقطة النهاية
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),

                        child: Text(
                          'Course Name', style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'IMPRISHA',
                        ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightGreen.shade200,
                            Colors.lightGreen.shade300
                          ], // اللونين
                          begin: Alignment.topLeft, // نقطة البداية
                          end: Alignment.bottomRight, // نقطة النهاية
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        child: Text(
                          'Credit', style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'IMPRISHA',
                        ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightGreen.shade200,
                            Colors.lightGreen.shade400
                          ], // اللونين
                          begin: Alignment.topLeft, // نقطة البداية
                          end: Alignment.bottomRight, // نقطة النهاية
                        ),
                        color: AppColors.goldColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        child: Text(
                          'Course Grade', style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'IMPRISHA',
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                  child:  Row(
                          children: [
            Expanded(
              flex: 2,
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Course',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2.0,), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2.0),
                    )
                ),
              ),
            ),
            SizedBox(width: 15,),
            Expanded(
              flex: 1,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2.0,), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2.0),
                    )
                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              flex: 2,
              child: TextField(
                controller: _controller,
                readOnly: true, // لا يسمح بالكتابة اليدوية
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2.0,), // Default border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2.0),
                  ),
                  suffixIcon: PopupMenuButton<String>(
                    icon: Icon(Icons.arrow_drop_down), // أيقونة القائمة المنسدلة
                    onSelected: (String value) {
                      setState(() {
                        _controller.text = value;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return options.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ),
              )
            ),
          ],
                  )
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [ Colors.lightGreen.shade200, Colors.lightGreen.shade400],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    style:  ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // اجعل الخلفية شفافة
                    shadowColor: Colors.transparent,),
                    onPressed: (){
                      setState(() {
                      });
                    },
                    child: Text("Add Course",style: TextStyle(color: AppColors.primaryColor,fontFamily: 'IMPRISHA',fontSize: 20,fontWeight: FontWeight.w700),),
                  ),
                ),
              )
            ],
          ),
        ),
      ]
      );
    }
  }
