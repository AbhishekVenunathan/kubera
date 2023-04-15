import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kubera/screens/auth/onboard.dart';
import 'package:kubera/splash.dart';
import 'package:kubera/widgets/bottom_navigation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sizer/sizer.dart';

import 'controller/auth.dart';
import 'controller/init.dart';
import 'screens/auth/mobile_entry.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create Channel if not present
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  /// Firebase on Foreground
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
  Get.put(InitCon());
  Get.put(AuthCon());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        defaultTransition: Transition.cupertino,
        title: 'Jaadu',
        themeMode: ThemeMode.light,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: const Color(0xFFFFFFFF),
            primaryColorLight: const Color(0xFF42D77F),
            primaryColor: const Color(0xFF1DAD58)),
        // home: GetStorage().read('usertoken').toString() == 'null'
        //     ? const OnboardView()
        //     : BottomBar(currentindex: 0),
        home: SplashView(),
        // home: MobileEntryView(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'Kuberaa_Notifications',
//   'Important Notifications',
//   'This is where you\'ll recieve Notifications about everything.',
//   importance: Importance.high,
//   playSound: true,
// );

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  /// We first initialise Firebase App for handling the background notifications
  await Firebase.initializeApp();
  print("Handling a background message: " +
      message.messageId.toString() +
      message.data.toString() +
      message.notification.toString());
}
