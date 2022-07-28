import 'dart:async';
import 'dart:io';
import 'package:barber/bottombar.dart';
import 'package:barber/routes.dart';
import 'package:barber/screens/loginscreen.dart';
import 'package:flutter/foundation.dart';

//import 'package:flutter_stripe/flutter_stripe.dart';

// import 'package:barber/screens/loginscreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:barber/constant/appconstant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_strategy/url_strategy.dart';

import 'constant/preferenceutils.dart';

Future<void> main() async {
  setPathUrlStrategy();
  HttpOverrides.global = MyHttpOverrides();
  runApp(
      Sizer(
      builder: (context, orientation, deviceType) {
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Beauty Salon",
          initialRoute: MyRoutes.start,
          //home: new SplashScreen(),
          routes: {
            "/":(BuildContext context)=>SplashScreen(),
            MyRoutes.login:(context)=>LoginScreen(0),
           // MyRoutes.home:(context)=>BottomBar(0),
          },
        );
      }));
  //for stripe
 /* Stripe.publishableKey = "demo";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();*/
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(context,MaterialPageRoute(builder: (context) => new BottomBar(0)));
    // Navigator.of(context).pushReplacementNamed('/HomeScreen');

    // bool login = PreferenceUtils.getlogin(AppConstant.isLoggedIn);
    //  print("loginStatus:$login");
    //
    //
    //
    //
    //
    //  if(login == true){
    //
    //
    //  }else if(login == false){
    //
    //    Navigator.of(context).pushReplacementNamed('/LoginScreen');
    //
    //  }else if(login == null){
    //
    //    Navigator.of(context).pushReplacementNamed('/LoginScreen');
    //  }

    //
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    PreferenceUtils.init();
   // initPlatformState();
    startTime();
// For each of the above functions, you can also pass in a
// reference to a function as well:

  }


  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        body: new Container(
          padding: EdgeInsets.only(bottom: 50),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('images/splash.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> savetoken(String token) async {
    PreferenceUtils.setString(AppConstant.fcmtoken, token);
  }
  Future<void> initPlatformState() async {
    if (!mounted) return;
    //
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    //
    // // OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);
    //
    // var settings = {
    //   OSiOSSettings.autoPrompt: false,
    //   OSiOSSettings.promptBeforeOpeningPushUrl: true
    // };
    //
    //
    // // NOTE: Replace with your own app ID from https://www.onesignal.com
    // await OneSignal.shared
    //     .init("29561882-aa25-43ef-b277-83a677b09524", iOSSettings: settings);
    //
    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared.consentGranted(true);
    await OneSignal.shared.setAppId(AppConstant.oneSignalAppKey);
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    OneSignal.shared.promptLocationPermission();
    var status = await OneSignal.shared.getDeviceState();
    // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    // var status = await OneSignal.shared.getPermissionSubscriptionState();
    var pushtoken = status!.userId!;
    print("pushtoken123456:$pushtoken");
    PreferenceUtils.setString(AppConstant.fcmtoken, pushtoken);
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}