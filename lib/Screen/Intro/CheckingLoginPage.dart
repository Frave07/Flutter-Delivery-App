import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/Bloc/Auth/auth_bloc.dart';
import 'package:restaurant/Bloc/User/user_bloc.dart';
import 'package:restaurant/Screen/Client/ClientHomePage.dart';
import 'package:restaurant/Screen/Home/SelectRolePage.dart';
import 'package:restaurant/Screen/Login/LoginPage.dart';
import 'package:restaurant/Themes/ColorsFrave.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';


class CheckingLoginPage extends StatefulWidget {
  @override
  _CheckingLoginPageState createState() => _CheckingLoginPageState();
}


class _CheckingLoginPageState extends State<CheckingLoginPage> with TickerProviderStateMixin {

  late AnimationController _animationController;
  
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(_animationController)..addStatusListener((status) {
      if( status == AnimationStatus.completed ){
        _animationController.reverse();
      } else if ( status == AnimationStatus.dismissed ){
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        
        if( state is LoadingAuthState ){

          Navigator.pushReplacement(context, routeFrave(page: CheckingLoginPage()));
        
        } else if ( state is LogOutAuthState ){

          Navigator.pushAndRemoveUntil(context, routeFrave(page: LoginPage()), (route) => false);    
         
        } else if ( state.rolId != '' ){

          userBloc.add( OnGetUserEvent(state.user!) );

          if( state.rolId  == '1' || state.rolId  == '3' ){

            Navigator.pushAndRemoveUntil(context, routeFrave(page: SelectRolePage()), (route) => false);
          
           } else if ( state.rolId  == '2' ){

            Navigator.pushAndRemoveUntil(context, routeFrave(page: ClientHomePage()), (route) => false);          
          }
        }
      },
      child: Scaffold(
        backgroundColor: ColorsFrave.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) 
                  => Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Image.asset('Assets/Logo/logo-white.png'),
                    ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}