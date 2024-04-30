import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_client/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_client/model/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class LoginController extends GetxController{
  GetStorage box = GetStorage();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerPhoneCtrl = TextEditingController();

  TextEditingController loginNumberCtrl = TextEditingController();

  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  bool otpFieldShown = false;
  int? sentOtp;
  int? enteredOtp;

  User? loginUser;

  @override
  void onReady() {
    // TODO: implement onReady
    Map<String,dynamic>? user = box.read('loginUser');
    if(user != null){
      loginUser = User.fromJson(user);
      Get.to(HomePage());
    }
    super.onReady();
  }


  @override
  void onInit() {
    // TODO: implement onInit
    userCollection = firestore.collection('users');
    super.onInit();
  }

  addUser(){
    try {
      if(sentOtp == enteredOtp){
        DocumentReference doc = userCollection.doc();
        User user = User(
            id:doc.id,
            name: registerNameCtrl.text,
            phone:int.parse(registerPhoneCtrl.text)
        );
        final userJson = user.toJson();
        doc.set(userJson);
        Get.snackbar('Success', "User Added Successfully", colorText: Colors.green);
        registerPhoneCtrl.clear();
        registerNameCtrl.clear();
        otpController.clear();
      }else{
        Get.snackbar('Error', 'Entered OTP is incorrect', colorText: Colors.red);
      }

    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  sendOTP(){
    try {
      if(registerNameCtrl.text.isEmpty || registerPhoneCtrl.text.isEmpty){
        Get.snackbar('Error', 'Please Fill the Fields', colorText: Colors.red);
        return;
      }
      final random = Random();
      int otp = 1000 + random.nextInt(9000);
      print(otp);

      if(otp != null){
        otpFieldShown = true;
        sentOtp = otp;
        Get.snackbar('OTP has been sent ', 'Check your phone number for OTP', colorText: Colors.green);
      }else{
        Get.snackbar('Error', 'OTP not send', colorText: Colors.red);

      }
    } catch (e) {
      // TODO
      print(e);
    }finally{
      update();
    }
  }
  
  Future<void> loginWithPhone() async {
    try{
      String phoneNumber= loginNumberCtrl.text;
      if(phoneNumber.isNotEmpty){
        var querySnapshot  = await userCollection.where("phone", isEqualTo: int.tryParse(phoneNumber)).limit(1).get();
        if(querySnapshot.docs.isNotEmpty){
          var userDoc = querySnapshot.docs.first;
          var userData = userDoc.data() as Map<String,dynamic>;
          box.write('loginUser', userData);
          loginNumberCtrl.clear();
          Get.to(HomePage());
          Get.snackbar('Success ', 'Logged In', colorText: Colors.green);
        }else{
          Get.snackbar('Error', 'User not Found. Please Register First', colorText: Colors.red);
        }
      }else{
        Get.snackbar('Error', 'Please enter a phone number', colorText: Colors.red);
      }
    }catch(error){
      Get.snackbar('Error', 'Failed to Login', colorText: Colors.red);

    }
  }
}