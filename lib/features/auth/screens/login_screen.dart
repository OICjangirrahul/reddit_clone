import 'package:flutter/material.dart';
import 'package:reddit/core/constants/constants.dart';

import '../../../core/common/sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.logopath,
          height: 40,
          ),
          actions: [
            TextButton(onPressed: (){},child: Text('Skip', style: TextStyle(fontWeight: FontWeight.bold),))
          ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text('Dive into anything',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,letterSpacing: 0.5),),
         const SizedBox(height: 30),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Image.asset(Constants.loginEmote,height: 400,),
         ),
           const SizedBox(height: 30),
           const SignInButton()
        ],
      ),
    );
  }
}