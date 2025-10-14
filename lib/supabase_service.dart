import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static late final SupabaseClient client;

  static Future<void> init({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
    client = Supabase.instance.client;
  }

  static Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (_) {
      throw Exception('حدث خطأ غير متوقع أثناء تسجيل الدخول.');
    }
  }

  static Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );

      final userId = response.user?.id;
      if (userId != null) {
        // ✅ أي مستخدم جديد من التطبيق -> user
        await client.from('profiles').insert({
          'id': userId,
          'email': email,
          'role': 'user',
        });
      }

      return response;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (_) {
      throw Exception('حدث خطأ غير متوقع أثناء إنشاء الحساب.');
    }
  }

  static Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = client.auth.currentUser;
      if (user == null) return null;

      final response = await client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      return response;
    } catch (_) {
      return null;
    }
  }

  static Future<bool> isUserAdmin() async {
    try {
      final profile = await getUserProfile();
      return profile != null && profile['role'] == 'admin';
    } catch (_) {
      return false;
    }
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }
}
