import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/Bloc/Auth/auth_bloc.dart';
import 'package:restaurant/Screen/Delivery/ListOrdersDeliveryPage.dart';
import 'package:restaurant/Screen/Delivery/OrderDeliveredPage.dart';
import 'package:restaurant/Screen/Delivery/OrderOnWayPage.dart';
import 'package:restaurant/Screen/Profile/ChangePasswordPage.dart';
import 'package:restaurant/Screen/Profile/EditProdilePage.dart';
import 'package:restaurant/Screen/Home/SelectRolePage.dart';
import 'package:restaurant/Screen/Intro/CheckingLoginPage.dart';
import 'package:restaurant/Widgets/AnimationRoute.dart';
import 'package:restaurant/Widgets/ImagePicker.dart';
import 'package:restaurant/Widgets/Widgets.dart';
import 'package:restaurant/Helpers/Helpers.dart';

class DeliveryHomePage extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        
        if( state is LoadingAuthState ){
          
          modalLoading(context);

        } else if ( state is SuccessAuthState ){
          
          Navigator.pop(context);
          modalSuccess(context, 'Picture Change Successfully', () => Navigator.pushReplacement(context, routeFrave(page: DeliveryHomePage())));
          Navigator.pop(context);

        } else if ( state is FailureAuthState ){
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
               SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center,
                child: ImagePickerFrave()
              ),
              SizedBox(height: 20.0),
              Center(
                child: TextFrave(text: authBloc.state.user!.firstName! + ' ' + authBloc.state.user!.lastName!, fontSize: 25, fontWeight: FontWeight.w500 )
              ),
              SizedBox(height: 5.0),
              Center(
                child: TextFrave(text: authBloc.state.user!.email!, fontSize: 20, color: Colors.grey )
              ),
              SizedBox(height: 15.0),
              TextFrave(text: 'Account', color: Colors.grey ),
              SizedBox(height: 10.0),
              ItemAccount(
                text: 'Profile setting',
                icon: Icons.person,
                colorIcon: 0xff01C58C,
                onPressed: () => Navigator.push(context, routeFrave(page: EditProfilePage())),
              ),
              ItemAccount(
                text: 'Change Password',
                icon: Icons.lock_rounded,
                colorIcon: 0xff1B83F5,
                onPressed: () => Navigator.push(context, routeFrave(page: ChangePasswordPage())),
              ),
              ItemAccount(
                text: 'Change Role',
                icon: Icons.swap_horiz_rounded,
                colorIcon: 0xffE62755,
                onPressed: () => Navigator.pushAndRemoveUntil(context, routeFrave(page: SelectRolePage()), (route) => false),
              ),
              ItemAccount(
                text: 'Dark mode',
                icon: Icons.dark_mode_rounded,
                colorIcon: 0xff051E2F,
              ),
              SizedBox(height: 15.0),
              TextFrave(text: 'Delivery', color: Colors.grey ),
              SizedBox(height: 10.0),
              ItemAccount(
                text: 'Orders',
                icon: Icons.checklist_rounded,
                colorIcon: 0xff5E65CD,
                 onPressed: () => Navigator.push(context, routeFrave(page: ListOrdersDeliveryPage())),
              ),
              ItemAccount(
                text: 'On Way',
                icon: Icons.delivery_dining_rounded,
                colorIcon: 0xff1A60C1,
                onPressed: () => Navigator.push(context, routeFrave(page: OrderOnWayPage())),
              ),
              ItemAccount(
                text: 'Delivered',
                icon: Icons.check_rounded,
                colorIcon: 0xff4BB17B,
                onPressed: () => Navigator.push(context, routeFrave(page: OrderDeliveredPage())),
              ),
              SizedBox(height: 15.0),
              TextFrave(text: 'Personal', color: Colors.grey ),
              SizedBox(height: 10.0),
              ItemAccount(
                text: 'Privacy & Policy',
                icon: Icons.policy_rounded,
                colorIcon: 0xff6dbd63,
              ),
              ItemAccount(
                text: 'Security',
                icon: Icons.lock_outline_rounded,
                colorIcon: 0xff1F252C,
              ),
              ItemAccount(
                text: 'Term & Conditions',
                icon: Icons.description_outlined,
                colorIcon: 0xff458bff,
              ),
              ItemAccount(
                text: 'Help',
                icon: Icons.help_outline,
                colorIcon: 0xff4772e6,
              ),
              Divider(),
              ItemAccount(
                text: 'Sign Out',
                icon: Icons.power_settings_new_sharp,
                colorIcon: 0xffF02849,
                onPressed: () {
                  authBloc.add(LogOutEvent());
                  Navigator.pushAndRemoveUntil(context, routeFrave(page: CheckingLoginPage()), (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}