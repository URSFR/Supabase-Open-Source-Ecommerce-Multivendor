import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:opem/provider/user_provider.dart';
import 'package:opem/screens/buy_screen.dart';
import 'package:opem/screens/login_screen.dart';
import 'package:opem/screens/register_screen.dart';
import 'package:opem/supabase/components/auhstate.dart';
import 'package:opem/supabase/components/authrequiredstate.dart';
import 'package:opem/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configLoading();

  await Supabase.initialize(
      url: Supaurl,
      anonKey: AnonKey,
      authCallbackUrlHostname: 'login-callback', // optional
      debug: true, // optional
  );
  runApp(MultiProvider(providers:[ ChangeNotifierProvider(
    create: (_)=> UserProvider(),),
    // ChangeNotifierProvider(
    //   create: (_)=> LocationProvider(),),
    // ChangeNotifierProvider(
    //   create: (_)=> StoreProvider(),),
    // ChangeNotifierProvider(
    //   create: (_)=> CartProvider(),),
    // ChangeNotifierProvider(
    //   create: (_)=> CouponProvider(),),
    // ChangeNotifierProvider(
    //   create: (_)=> OrderProvider(),),
  ],

    child: MaterialApp(debugShowCheckedModeBanner: false,home: MyApp(), builder: EasyLoading.init(),
    ),
  ),);
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce Multivendor',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Supabase.instance.client.auth.currentUser!=null?BuyScreen():LoginScreen(),
    );
  }


}