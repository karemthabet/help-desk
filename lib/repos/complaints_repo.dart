import 'dart:developer';
import 'dart:io';
import 'package:cloud_task/models/complaint_model.dart';
import 'package:cloud_task/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ComplaintsRepo {
  final SupabaseClient _supabase = SupabaseService.client;

  Future<bool> addComplaint({
    required String title,
    required String description,
    File? imageFile,
  }) async {
    try {
      String? imageUrl;

      if (imageFile != null) {
        final path =
            '${SupabaseService.userId}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        await _supabase.storage
            .from('complaint-images')
            .upload(path, imageFile);
        imageUrl = _supabase.storage
            .from('complaint-images')
            .getPublicUrl(path);
      }

      await _supabase.from('complaints').insert({
        'user_id': SupabaseService.userId,
        'title': title,
        'description': description,
        'image_url': imageUrl,
      });

      return true;
    } catch (e) {
      log('❌ Add Complaint Error: $e');
      return false;
    }
  }

  Future<List<ComplaintModel>> getMyComplaints() async {
    try {
      final res = await _supabase
          .from('complaints')
          .select()
          .eq('user_id', SupabaseService.userId!)
          .order('created_at', ascending: false);

      final data = List<Map<String, dynamic>>.from(res);
      return data.map((e) => ComplaintModel.fromJson(e)).toList();
    } catch (e) {
      log('❌ Get Complaints Error: $e');
      return [];
    }
  }

  Future<bool> updateStatus(String complaintId, String newStatus) async {
    try {
      await _supabase
          .from('complaints')
          .update({'status': newStatus})
          .eq('id', complaintId);
      return true;
    } catch (e) {
      log('❌ Update Status Error: $e');
      return false;
    }
  }
}
