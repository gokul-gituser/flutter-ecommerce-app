import 'dart:ui';

import 'package:ecommerce_client/controllers/login_controller.dart';
import 'package:ecommerce_client/pages/login_page.dart';
import 'package:ecommerce_client/utils/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Create Your Account",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                controller: ctrl.registerNameCtrl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    labelText: "Your Name",
                    hintText: "Enter your Full Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                controller: ctrl.registerPhoneCtrl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.phone_android),
                    labelText: "Mobile Number",
                    hintText: "Enter your mobile number"),
              ),
              const SizedBox(
                height: 20,
              ),
              OtpTextField(
                otpController: ctrl.otpController,
                visible: ctrl.otpFieldShown,
                onComplete: (otp) {
                  ctrl.enteredOtp = int.tryParse(otp ?? '0000');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if(ctrl.otpFieldShown){
                    ctrl.addUser();
                  }else{
                    ctrl.sendOTP();
                  }

                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.cyan),
                child: Text(
                  ctrl.otpFieldShown ? "Register" : "Send OTP" ,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(const LoginPage());
                  },
                  child: const Text('Already Have an Account? Login'))
            ],
          ),
        ),
      );
    });
  }
}
