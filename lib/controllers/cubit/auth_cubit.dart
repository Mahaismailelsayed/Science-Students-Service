import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  //Global Pass http
  Future<void> globalPass({required String Password}) async {
    // Emit loading state
    emit(GlobalLoadingState());

    // Validate input
    if (Password.isEmpty) {
      emit(FailedToGlobalState(message: "Enter the Password"));
      return;
    }

    try {
      // Make API request
      final response = await http.post(
        Uri.parse(
            "http://authenticationapp.runasp.net/api/Account/CheckPassword?Password=W%4012qsx%24%25233"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "GlobalPassword": Password,
        }),
      );

      // Print response for debugging
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Decode response
      final responseBody = jsonDecode(response.body);

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Emit success state
        if (responseBody['success'] == true) {
          emit(GlobalSuccessState());
        } else {
          // Emit failed state with error message
          emit(FailedToGlobalState(
            message: responseBody['message'] ?? "فشل التحقق من كلمة المرور",));
        }
      }
    }
    catch (e) {
      // Handle any unexpected errors
      print("Error: $e");
      emit(FailedToGlobalState(message: "حدث خطأ غير متوقع"));
    }
  }

  //Register http
  Future<void> Register({required String firstName, required String lastName, required String email, required String phone, required String password, required String confirmPassword, required String NID}) async {
    emit(RegisterLoadingState());

    try {
      Response response = await http.post(
        Uri.parse("http://authenticationapp.runasp.net/api/Account/Register"),
        headers: {
          "Content-Type": "application/json",  // ✅ تأكيد إرسال البيانات بصيغة JSON
        },
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "phone": phone,
          "password": password,
          "confirmPassword": confirmPassword,
          "NID": NID,
        }),
      );
      print("📩 Response received! Status Code: ${response.statusCode}");
      print("📌 Response Body: ${response.body}");
      if( response.statusCode == 200 )
      {
        var data = jsonDecode(response.body);
        if( data['success'] == true )
        {
          debugPrint("Response is : $data");
          emit(RegisterSuccessState());
        }
        else
        {
          debugPrint("Response is : $data");
          emit(FailedToRegisterState(message: data['message']));
        }
      }
    }
    catch (e) {
      debugPrint("Failed to Register , reason : $e");
      emit(FailedToRegisterState(message: e.toString()));
    }
  }

  //Login http
  Future<void> Login({required String userName,required String password}) async {
    emit(LoginLoadingState());

    try{
      // Make API request
      final response = await http.post(
        Uri.parse(
            "http://authenticationapp.runasp.net/api/Account/Login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "userName" : userName,
          "password": password,
        }),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.body.isEmpty) {
        print("⛔ The Server Returned An Empty Response!");
        emit(FailedToLoginState(message: "الخادم لم يُرجع أي بيانات"));
        return;
      }

      var data;
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        print("⚠️ فشل تحويل JSON: $e");
        emit(FailedToLoginState(message: "حدث خطأ أثناء معالجة البيانات"));
        return;
      }

      if (data == null || data.isEmpty) {
        print("⛔ البيانات المسترجعة غير صالحة!");
        emit(FailedToLoginState(message: "استجابة غير متوقعة من الخادم"));
        return;
      }

      // ✅ التحقق من المفاتيح المطلوبة قبل استخدامها
      if (!data.containsKey('isAuthenticated') || !data.containsKey('message')) {
        print("⚠️ الرد لا يحتوي على المفاتيح المطلوبة!");
        emit(FailedToLoginState(message: "المصادقة فشلت: بيانات غير مكتملة"));
        return;
      }

      bool isAuthenticated = data['isAuthenticated'] ?? false;
      String message = data['message'] ?? "خطأ غير معروف";
      String token = data['token'] ?? "";

      if (!isAuthenticated || token.isEmpty) {
        print("❌ فشل تسجيل الدخول: $message");
        emit(FailedToLoginState(message: message));
        return;
      }

      print("✅ تسجيل الدخول ناجح! التوكن: $token");
      emit(LoginSuccessState(message: token));
    } catch (e) {
      print("❌ خطأ أثناء تسجيل الدخول: $e");
      emit(FailedToLoginState(message: "حدث خطأ غير متوقع، حاول مرة أخرى"));
    }
  }

  //ForgetPass http
  Future<void> ForgetPassword({ required String userName, required String email, required String newPassword, required String confirmNewPassword}) async {
    emit(ForgetLoadingState());

    try {
      Response response = await http.post(
        Uri.parse("http://authenticationapp.runasp.net/api/Account/ForgetPassword"),
        headers: {
          "Content-Type": "application/json",  // ✅ تأكيد إرسال البيانات بصيغة JSON
        },
        body: jsonEncode({
          "userName": userName,
          "email": email,
          "newPassword": newPassword,
          "confirmNewPassword": confirmNewPassword,
        }),
      );
      print("📩 Response received! Status Code: ${response.statusCode}");
      print("📌 Response Body: ${response.body}");
      if( response.statusCode == 200 )
      {
        var data = jsonDecode(response.body);
        if( data['isSuccess'] == true )
        {
          debugPrint("Response is : $data");
          emit(ForgetSuccessState());
        }
        else
        {
          debugPrint("Response is : $data");
          emit(FailedToForgetState(message: data['message']));
        }
      }
    }
    catch (e) {
      debugPrint("Failed to Register , reason : $e");
      emit(FailedToForgetState(message: e.toString()));
    }
  }

}

