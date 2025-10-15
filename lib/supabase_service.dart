import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://ibockwwxokdypenewkkv.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlib2Nrd3d4b2tkeXBlbmV3a2t2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA1MDQ4NzIsImV4cCI6MjA3NjA4MDg3Mn0.Irlv1QXK55bGwf8xwPN-BaIj5wqrbl-wzHOj5fnYxoQ',
    );
  }

  static String? get userId => client.auth.currentUser?.id;
}
