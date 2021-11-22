import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hargun2021/home/splash-page.dart';
import 'package:hargun2021/auth/login-page.dart';
// import 'package:hargun2021/home/news-page.dart';
// import 'package:hargun2021/home/web-page.dart';
// import 'package:hargun2021/home/news-page.dart';
import 'package:hargun2021/home/home-page.dart';
import 'package:hargun2021/tutorials/Home--page.dart';
// import 'package:hargun2021/tutorials/cart-page.dart';
import 'package:hargun2021/tutorials/fetch-current-location.dart';
import 'package:hargun2021/tutorials/google-maps-with-location.dart';
import 'package:hargun2021/tutorials/image-picker.dart';
import 'package:hargun2021/tutorials/paymet-page-method.dart';

import 'auth/profileBCM.dart';
import 'auth/register-page.dart';
import 'auth/restuarant-add.dart';
import 'custom-widget/Cart-page.dart';
import 'custom-widget/testnewspage.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}
AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;






Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      // if (message != null) {
      //   Navigator.pushNamed(context, '/message',
      //       arguments: MessageArguments(message, true));
      // }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                channel!.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodiee',
      debugShowCheckedModeBanner: false,
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

      routes: {
        "/": (context) => SplashPage(),
        "/home": (context) => HomePage(),
        "/login": (context) => LoginPage(),
        "/image-picker": (context) => ImagePickerPAge(),
        "/register": (context) => RegisterUserPage(),
        // "/add": (context) => RegisterUserPage(),
        "/FetchLocation": (context) => FetchCurrentLocationPage(),
        "/news": (context) => NewsPage(),
        "/cart": (context) => CartPAGE(),
        "/add": (context) => RestaurantsDataPage(),
        "/payment": (context) => PaymentMethodsPage(),
        "/HOME": (context) => Ebooks(),
        "/profile": (context) => Profile(),
      },

      initialRoute: "/",
    );
  }
}


// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My App"),
//       ),
//       body: NewsPage(),
//     );
//   }
// }
//

