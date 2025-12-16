import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_receipt/config/app_router.dart';
import 'config/app_theme.dart';
import 'features/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
  //   if (systemOverlaysAreVisible) {
  //     await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //   }
  // });

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
