import 'package:cloud_task/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final _supabase = SupabaseService.client;

  Future<void> signUp(String email, String password, String name) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user != null) {
      await _supabase.from('profiles').upsert({
        'id': user.id,
        'email': email,
        'name': name,
        'role': 'user', 
      });
    }
  }

  Future<void> login(String email, String password) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<Map<String, dynamic>?> getProfile() async {
    final userId = SupabaseService.userId;
    if (userId == null) return null;

    final response =
        await _supabase.from('profiles').select().eq('id', userId).maybeSingle();

    return response;
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  Future<Session?> getSession() async {
    return _supabase.auth.currentSession;
  }
}
