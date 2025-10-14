import 'dart:io';
import 'package:cloud_task/complaint_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  ComplaintCubit() : super(const ComplaintState());

  final SupabaseClient _client = Supabase.instance.client;

  Future<void> fetchForUser() async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final data = await _client
          .from('complaints')
          .select()
          .order('created_at', ascending: false);
      final complaints =
          (data as List)
              .map((e) => Complaint.fromMap(Map<String, dynamic>.from(e)))
              .toList();
      emit(state.copyWith(loading: false, complaints: complaints));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> fetchAll() async => await fetchForUser();

  Future<void> createComplaint({
    required String title,
    required String description,
    File? imageFile,
  }) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final user = _client.auth.currentUser;
      if (user == null) throw Exception('Not authenticated');

      String? imagePath;
      if (imageFile != null) {
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
        final path = 'complaint-images/${user.id}/$fileName';
        await _client.storage.from('complaint-images').upload(path, imageFile);
        imagePath = path;
      }

      await _client.from('complaints').insert({
        'user_id': user.id,
        'title': title,
        'description': description,
        'image_path': imagePath,
        'status': 'pending',
      });
      await fetchForUser();
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> setSolution(String id, String solution) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await _client
          .from('complaints')
          .update({
            'solution': solution,
            'status': 'resolved',
            'resolved_at': DateTime.now().toIso8601String(),
          })
          .eq('id', id);
      await fetchForUser();
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

//   Future<String?> getSignedUrl(String path) async {
//     try {
//       final res = await _client.storage
//           .from('complaint-images')
//           .createSignedUrl(path, 3600);
//       if (res is Map)
//         return res['signedURL'] as String;
//       return res;
//     } catch (_) {
//       return null;
//     }
//   }
}
