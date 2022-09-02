import 'package:flutter/material.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/helpers.dart';
import 'package:restaurant/presentation/screens/login/check_email_screen.dart';
import 'package:restaurant/presentation/screens/login/login_screen.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

class ForgotPasswordScreen extends StatefulWidget {

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}


class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    _emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const TextCustom(text: 'Reset Password', fontSize: 21, fontWeight: FontWeight.w500 ),
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pushReplacement(context, routeFrave(page: LoginScreen())),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: ColorsFrave.primaryColor ),
              TextCustom(text: 'Back', color: ColorsFrave.primaryColor, fontSize: 16)
            ],
          ),
        ),
        actions: const [
          Icon(Icons.help_outline_outlined, color: Colors.black),
          SizedBox(width: 15.0),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              const TextCustom(
                text: 'Enter the email associated with your account and well send an email with instruccions to reset your password.', 
                maxLine: 4, 
                color: Colors.grey,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              const TextCustom(text: 'Email Address'),
              const SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _emailController,
                hintText: 'example@frave.com',
                validator: validatedEmail,
              ),
              const SizedBox(height: 30.0),
              BtnFrave(
                text: 'Send Instructions',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                onPressed: (){
                    Navigator.push(context, routeFrave(page: CheckEmailScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}