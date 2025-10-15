import 'dart:io';
import 'package:cloud_task/auth_repository.dart';
import 'package:cloud_task/complaint_model.dart';
import 'package:cloud_task/complaint_state.dart';
import 'package:cloud_task/complaints_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  final ComplaintsRepo repo;
  final AuthRepository authRepository;

  ComplaintsCubit({
    required this.repo,
    required this.authRepository,
  }) : super(ComplaintsInitial());

  List<ComplaintModel> complaints = [];

  Future<void> fetchComplaints() async {
    emit(ComplaintsLoading());
    try {
      complaints = await repo.getMyComplaints();
      emit(ComplaintsLoaded(complaints));
    } catch (e) {
      emit(ComplaintsError('حدث خطأ أثناء تحميل الشكاوى: $e'));
    }
  }

  Future<void> addComplaint({
    required String title,
    required String description,
    File? imageFile,
  }) async {
    emit(ComplaintsLoading());
    try {
      final success = await repo.addComplaint(
        title: title,
        description: description,
        imageFile: imageFile,
      );
      if (success) {
        await fetchComplaints();
      } else {
        emit(ComplaintsError('فشل في إرسال الشكوى'));
      }
    } catch (e) {
      emit(ComplaintsError('حدث خطأ أثناء إرسال الشكوى: $e'));
    }
  }

  Future<void> updateStatus(String id, String status) async {
    try {
      final success = await repo.updateStatus(id, status);
      if (success) await fetchComplaints();
    } catch (e) {
      emit(ComplaintsError('حدث خطأ أثناء تحديث الحالة: $e'));
    }
  }
}
