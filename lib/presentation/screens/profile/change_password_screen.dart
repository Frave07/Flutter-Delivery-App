import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/helpers.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

class ChangePasswordScreen extends StatefulWidget {

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}


class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

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
  Widget build(BuildContext context){

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
            title: const TextCustom(text: 'Change Password'),
            centerTitle: true,
            leadingWidth: 80,
            leading: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const TextCustom(text: 'Cancel', fontSize: 17, color: ColorsFrave.primaryColor )
            ),
            actions: [
              TextButton(
                onPressed: (){
                  if( _keyForm.currentState!.validate()){
                    userBloc.add( OnChangePasswordEvent(_currentPasswordController.text, _newPasswordController.text) );
                  }
                }, 
                child: const TextCustom(text: 'Save', fontSize: 16, color: ColorsFrave.primaryColor)
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
                    const SizedBox(height: 20.0),
                    const TextCustom(text: 'Current Password'),
                    const SizedBox(height: 5.0),
                    FormFieldFravePassword(
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
                    const SizedBox(height: 20.0),
                    const TextCustom(text: 'New Password'),
                    const SizedBox(height: 5.0),
                    FormFieldFravePassword(
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
                    const SizedBox(height: 20.0),
                    const TextCustom(text: 'Repeat Password'),
                    const SizedBox(height: 5.0),
                    FormFieldFravePassword(
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
                        } else{
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

class FormFieldFravePassword extends StatelessWidget {
  
  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final int maxLine;
  final bool readOnly;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  const FormFieldFravePassword({ 
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
        contentPadding: const EdgeInsets.only(left: 15.0),
        hintText: hintText,
        hintStyle: GoogleFonts.getFont('Roboto', color: Colors.grey),
        suffixIcon: suffixIcon 
      ),
      validator: validator,
    );
  }
}