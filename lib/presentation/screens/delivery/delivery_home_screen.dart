import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/helpers/helpers.dart';
import 'package:restaurant/presentation/screens/delivery/list_orders_delivery_screen.dart';
import 'package:restaurant/presentation/screens/delivery/order_delivered_screen.dart';
import 'package:restaurant/presentation/screens/delivery/order_on_way_screen.dart';
import 'package:restaurant/presentation/screens/home/select_role_screen.dart';
import 'package:restaurant/presentation/screens/intro/checking_login_screen.dart';
import 'package:restaurant/presentation/screens/profile/change_password_screen.dart';
import 'package:restaurant/presentation/screens/profile/edit_Prodile_screen.dart';

class DeliveryHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authBloc = BlocProvider.of<AuthBloc>(context);
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if( state is LoadingAuthState ){
          modalLoading(context);
        } else if ( state is SuccessAuthState ){
          Navigator.pop(context);
          modalSuccess(context, 'Picture Change Successfully', () => Navigator.pushReplacement(context, routeFrave(page: DeliveryHomeScreen())));
          Navigator.pop(context);

        } else if ( state is FailureAuthState ){
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center,
                child: ImagePickerFrave()
              ),
              const SizedBox(height: 20.0),
              Center(
                child: TextCustom(text: authBloc.state.user!.firstName + ' ' + authBloc.state.user!.lastName, fontSize: 25, fontWeight: FontWeight.w500 )
              ),
              const SizedBox(height: 5.0),
              Center(
                child: TextCustom(text: authBloc.state.user!.email, fontSize: 20, color: Colors.grey )
              ),
              const SizedBox(height: 15.0),
              const TextCustom(text: 'Account', color: Colors.grey ),
              const SizedBox(height: 10.0),
              ItemAccount(
                text: 'Profile setting',
                icon: Icons.person,
                colorIcon: 0xff01C58C,
                onPressed: () => Navigator.push(context, routeFrave(page: EditProfileScreen())),
              ),
              ItemAccount(
                text: 'Change Password',
                icon: Icons.lock_rounded,
                colorIcon: 0xff1B83F5,
                onPressed: () => Navigator.push(context, routeFrave(page: ChangePasswordScreen())),
              ),
              ItemAccount(
                text: 'Change Role',
                icon: Icons.swap_horiz_rounded,
                colorIcon: 0xffE62755,
                onPressed: () => Navigator.pushAndRemoveUntil(context, routeFrave(page: SelectRoleScreen()), (route) => false),
              ),
              ItemAccount(
                text: 'Dark mode',
                icon: Icons.dark_mode_rounded,
                colorIcon: 0xff051E2F,
              ),
              SizedBox(height: 15.0),
              TextCustom(text: 'Delivery', color: Colors.grey ),
              SizedBox(height: 10.0),
              ItemAccount(
                text: 'Orders',
                icon: Icons.checklist_rounded,
                colorIcon: 0xff5E65CD,
                 onPressed: () => Navigator.push(context, routeFrave(page: ListOrdersDeliveryScreen())),
              ),
              ItemAccount(
                text: 'On Way',
                icon: Icons.delivery_dining_rounded,
                colorIcon: 0xff1A60C1,
                onPressed: () => Navigator.push(context, routeFrave(page: OrderOnWayScreen())),
              ),
              ItemAccount(
                text: 'Delivered',
                icon: Icons.check_rounded,
                colorIcon: 0xff4BB17B,
                onPressed: () => Navigator.push(context, routeFrave(page: OrderDeliveredScreen())),
              ),
              const SizedBox(height: 15.0),
              const TextCustom(text: 'Personal', color: Colors.grey ),
              const SizedBox(height: 10.0),
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
              const Divider(),
              ItemAccount(
                text: 'Sign Out',
                icon: Icons.power_settings_new_sharp,
                colorIcon: 0xffF02849,
                onPressed: () {
                  authBloc.add(LogOutEvent());
                  Navigator.pushAndRemoveUntil(context, routeFrave(page: CheckingLoginScreen()), (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}