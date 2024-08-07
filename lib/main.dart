
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';

import 'features/splash/screens/splashScreen.dart';
import 'firebase_options.dart';

var height;
var width;
String? currentUserName;
String? currentUserImage;
String? currentUserEmail;
UserModel ?currentUserModel;
ProductModel ?currentProductModel;
bool? firstTime;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // runApp(ProviderScope(child: DevicePreview(
  //     enabled: true,
  //     builder: (context) =>MyApp())));
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp(
        theme: ThemeData.from(
                colorScheme: ColorScheme.light(),
                // backgroundColor: Colors.white,
                textTheme: GoogleFonts.poppinsTextTheme())
            .copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen()
      ),
    );
  }
}
