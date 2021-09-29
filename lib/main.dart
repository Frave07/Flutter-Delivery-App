import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/Bloc/Auth/auth_bloc.dart';
import 'package:restaurant/Bloc/Cart/cart_bloc.dart';
import 'package:restaurant/Bloc/Delivery/delivery_bloc.dart';
import 'package:restaurant/Bloc/General/general_bloc.dart';
import 'package:restaurant/Bloc/MapClient/mapclient_bloc.dart';
import 'package:restaurant/Bloc/MapDelivery/mapdelivery_bloc.dart';
import 'package:restaurant/Bloc/My%20Location/mylocationmap_bloc.dart';
import 'package:restaurant/Bloc/Orders/orders_bloc.dart';
import 'package:restaurant/Bloc/Payments/payments_bloc.dart';
import 'package:restaurant/Bloc/Products/products_bloc.dart';
import 'package:restaurant/Bloc/User/user_bloc.dart';
import 'package:restaurant/Screen/Intro/CheckingLoginPage.dart';
import 'package:restaurant/Services/PushNotification.dart';
 
PushNotification pushNotification = PushNotification();

Future<void> _firebaseMessagingBackground( RemoteMessage message ) async {

  await Firebase.initializeApp();

}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackground);
  pushNotification.initNotifacion();
  runApp(MyApp());
}
 

 
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    pushNotification.onMessagingListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark ));

    return MultiBlocProvider(
      providers: [ 
        BlocProvider(create: (context) => AuthBloc()..add(CheckLoginEvent())),
        BlocProvider(create: (context) => GeneralBloc()),
        BlocProvider(create: (context) => ProductsBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => MylocationmapBloc()),
        BlocProvider(create: (context) => PaymentsBloc()),
        BlocProvider(create: (context) => OrdersBloc()),
        BlocProvider(create: (context) => DeliveryBloc()),
        BlocProvider(create: (context) => MapdeliveryBloc()),
        BlocProvider(create: (context) => MapclientBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food - Frave Developer',
        home: CheckingLoginPage(),
      ),
    );
  }
}