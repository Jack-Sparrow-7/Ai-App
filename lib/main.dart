import 'package:ai_app/app.dart';
import 'package:ai_app/core/di/injection.dart';
import 'package:ai_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initInjection();
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }
  runApp(const App());
}
