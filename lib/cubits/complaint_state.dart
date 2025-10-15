import 'package:cloud_task/models/complaint_model.dart';

abstract class ComplaintsState {}

class ComplaintsInitial extends ComplaintsState {}

class ComplaintsLoading extends ComplaintsState {}

class ComplaintsLoaded extends ComplaintsState {
  final List<ComplaintModel> complaints;
  ComplaintsLoaded(this.complaints);
}

class ComplaintsError extends ComplaintsState {
  final String message;
  ComplaintsError(this.message);
}
