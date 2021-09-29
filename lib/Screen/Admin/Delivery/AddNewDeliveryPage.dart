import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant/Bloc/User/user_bloc.dart';
import 'package:restaurant/Helpers/validate_form.dart';
import 'package:restaurant/Screen/Admin/AdminHomePage.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/Widgets.dart';
import 'package:restaurant/Helpers/Helpers.dart';


class AddNewDeliveryPage extends StatefulWidget {
  @override
  _AddNewDeliveryPageState createState() => _AddNewDeliveryPageState();
}


class _AddNewDeliveryPageState extends State<AddNewDeliveryPage> {

  late TextEditingController _nameController;
  late TextEditingController _lastnameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _lastnameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    clearTextEditingController();
    _nameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();    
    super.dispose();
  }

  void clearTextEditingController(){
    _nameController.clear();
    _lastnameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        
        if( state is LoadingUserState ){

          modalLoading(context);

        }else if ( state is SuccessUserState ){

          Navigator.pop(context);
          modalSuccess(context, 'Delivery Successfully Registered', 
            () => Navigator.pushAndRemoveUntil(context, routeFrave(page: AdminHomePage()), (route) => false));
          userBloc.add( OnClearPicturePathEvent());

        } else if ( state is FailureUserState ){

          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: TextFrave(text: 'Add New Delivery'),
            centerTitle: true,
            leadingWidth: 80,
            leading: TextButton(
              child: TextFrave(text: 'Cancel', color: ColorsFrave.primaryColor, fontSize: 17 ),
              onPressed: () => Navigator.pop(context),
            ),
            elevation: 0,
            actions: [
              TextButton(
                onPressed: () {
                  if( _keyForm.currentState!.validate() ){
                    userBloc.add( OnRegisterDeliveryEvent(
                      _nameController.text, 
                      _lastnameController.text, 
                      _phoneController.text, 
                      _emailController.text, 
                      _passwordController.text, 
                      userBloc.state.pictureProfilePath 
                    ));
                    
                  }
                }, 
                child: TextFrave(text: ' Save ', color: ColorsFrave.primaryColor )
              )
            ],
          ),
        body: Form(
          key: _keyForm,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center,
                child: _PictureRegistre()
              ),
              SizedBox(height: 20.0),
              TextFrave(text: 'Name'),
              SizedBox(height: 5.0),
              FormFieldFrave(
                hintText: 'name',
                controller: _nameController,
                validator: RequiredValidator(errorText: 'Name is required'),
              ),
              SizedBox(height: 20.0),
              TextFrave(text: 'Lastname'),
              SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _lastnameController,
                hintText: 'lastname',
                validator: RequiredValidator(errorText: 'Lastname is required'),
              ),
              SizedBox(height: 20.0),
              TextFrave(text: 'Phone'),
              SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _phoneController,
                hintText: '---.---.---',
                keyboardType: TextInputType.number,
                validator: RequiredValidator(errorText: 'Lastname is required'),
              ),
              SizedBox(height: 15.0),
                TextFrave(text: 'Email'),
                SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _emailController,
                  hintText: 'email@frave.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: validatedEmail
                ),
                SizedBox(height: 15.0),
                TextFrave(text: 'Password'),
                SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _passwordController,
                  hintText: '********',
                  isPassword: true,
                  validator: passwordValidator,
                ),
            ],
          ),
        ),
      ),
    );
  }
}



class _PictureRegistre extends StatelessWidget {

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.solid, color: Colors.grey[300]!),
        shape: BoxShape.circle
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () => modalPictureRegister(
          ctx: context, 
          onPressedChange: () async {
            
            Navigator.pop(context);
            final XFile? imagePath = await _picker.pickImage(source: ImageSource.gallery);
            if( imagePath != null ) userBloc.add( OnSelectPictureEvent(imagePath.path));

          },
          onPressedTake: () async {

            Navigator.pop(context);
            final XFile? photoPath = await _picker.pickImage(source: ImageSource.camera);
            userBloc.add( OnSelectPictureEvent(photoPath!.path));

          }
        ),
        child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) 
                => state.pictureProfilePath == ''
                   ? Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                        Icon(Icons.wallpaper_rounded, size: 60, color: ColorsFrave.primaryColor ),
                        SizedBox(height: 10.0),
                        TextFrave(text: 'Picture', color: Colors.black45 )
                     ],
                   ) 
                   : Container(
                      height: 100,  
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(state.pictureProfilePath))
                        )
                      ),
                     ),
            ),
           
      ),
    );
  }
}