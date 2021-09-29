import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/Bloc/General/general_bloc.dart';
import 'package:restaurant/Bloc/User/user_bloc.dart';
import 'package:restaurant/Helpers/validate_form.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/Widgets.dart';
import 'package:restaurant/Helpers/Helpers.dart';


class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}


class _ChangePasswordPageState extends State<ChangePasswordPage> {

  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _repeatPasswordController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    clearTextEditingController();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void clearTextEditingController(){
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _repeatPasswordController.clear();
  }

  @override
  Widget build(BuildContext context)
  {
    final generalBloc = BlocProvider.of<GeneralBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state){

        if( state is LoadingUserState ){
          modalLoading(context);
        
        } else if ( state is SuccessUserState ){

          Navigator.pop(context);
          modalSuccess(context, 'Password changed', () => Navigator.pop(context));
          clearTextEditingController();
        
        } else if ( state is FailureUserState ){

          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: TextFrave(text: 'Change Password'),
            centerTitle: true,
            leadingWidth: 80,
            leading: TextButton(
              onPressed: () => Navigator.pop(context),
              child: TextFrave(text: 'Cancel', fontSize: 17, color: ColorsFrave.primaryColor )
            ),
            actions: [
              TextButton(
                onPressed: (){
                  if( _keyForm.currentState!.validate()){
                    userBloc.add( OnChangePasswordEvent(_currentPasswordController.text, _newPasswordController.text) );
                  }
                }, 
                child: TextFrave(text: 'Save', fontSize: 16, color: ColorsFrave.primaryColor)
              )
            ],
          ),
        body: SafeArea(
          child: Form(
            key: _keyForm,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: BlocBuilder<GeneralBloc, GeneralState>(
                builder: (context, state) 
                  => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    TextFrave(text: 'Current Password'),
                    SizedBox(height: 5.0),
                    _FormFieldFravePassword(
                        controller: _currentPasswordController,
                        isPassword: state.isShowPassword,
                        suffixIcon: IconButton(
                          splashRadius: 20,
                          icon: state.isShowPassword ? Icon(Icons.remove_red_eye_outlined) : Icon(Icons.visibility_off_rounded) ,
                          onPressed: () {
                    
                            bool isShowPassword =! generalBloc.state.isShowPassword;
                            generalBloc.add( OnShowOrHidePasswordEvent(isShowPassword) );
                    
                          }
                        ),
                        validator: passwordValidator,
                    ),
                    SizedBox(height: 20.0),
                    TextFrave(text: 'New Password'),
                    SizedBox(height: 5.0),
                    _FormFieldFravePassword(
                        controller: _newPasswordController,
                        isPassword: state.isNewPassword,
                        suffixIcon: IconButton(
                          splashRadius: 20,
                          icon: state.isNewPassword ? Icon(Icons.remove_red_eye_outlined) : Icon(Icons.visibility_off_rounded) ,
                          onPressed: () {
                    
                            bool isShowPassword =! generalBloc.state.isNewPassword;
                            generalBloc.add( OnShowOrHideNewPasswordEvent(isShowPassword) );
                    
                          }
                        ),
                        validator: passwordValidator,
                    ),
                    SizedBox(height: 20.0),
                    TextFrave(text: 'Repeat Password'),
                    SizedBox(height: 5.0),
                    _FormFieldFravePassword(
                      controller: _repeatPasswordController,
                      isPassword: state.isRepeatpassword,
                      suffixIcon: IconButton(
                        splashRadius: 20,
                        icon: state.isRepeatpassword ? Icon(Icons.remove_red_eye_outlined) : Icon(Icons.visibility_off_rounded) ,
                        onPressed: () {
                  
                          bool isShowPassword =! generalBloc.state.isRepeatpassword;
                          generalBloc.add( OnShowOrHideRepeatPasswordEvent(isShowPassword) );
                  
                        }
                      ),
                      validator: (val){
                        if( val != _newPasswordController.text ){
                          return 'Passwords do not match';
                        } else if ( val!.isEmpty ){
                          return 'Repeat password is required';
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormFieldFravePassword extends StatelessWidget {
  
  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final int maxLine;
  final bool readOnly;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  const _FormFieldFravePassword({ 
    this.controller, 
    this.hintText, 
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.maxLine = 1,
    this.readOnly = false,
    this.suffixIcon,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.getFont('Roboto', fontSize: 18),
      obscureText: isPassword,
      maxLines: maxLine,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: .5, color: Colors.grey)),
        contentPadding: EdgeInsets.only(left: 15.0),
        hintText: hintText,
        hintStyle: GoogleFonts.getFont('Roboto', color: Colors.grey),
        suffixIcon: suffixIcon 
      ),
      validator: validator,
    );
  }
}