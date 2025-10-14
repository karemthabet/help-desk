import 'package:cloud_task/app_theme.dart';
import 'package:cloud_task/auth_wrapper.dart';
import 'package:cloud_task/supabase_service.dart';
import 'package:flutter/material.dart';

const String supabaseUrl = 'https://etvrjagrrrpvehtqxdpw.supabase.co';
const String supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV0dnJqYWdycnJwdmVodHF4ZHB3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAzOTExOTAsImV4cCI6MjA3NTk2NzE5MH0.dCDvlwxXhKJA-77QmBOI7ZxdKvssL3j69NRtahnW2Qs';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await SupabaseService.init(url: supabaseUrl, anonKey: supabaseAnonKey);
    runApp(const MyApp());
  } catch (e) {
    runApp(
      MaterialApp(
        home: Scaffold(body: Center(child: Text('فشل في تهيئة التطبيق: $e'))),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام الشكاوى',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AuthWrapper(),
    );
  }
}
