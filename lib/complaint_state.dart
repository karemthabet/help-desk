import 'package:cloud_task/complaint_model.dart';
import 'package:flutter/foundation.dart';

class ComplaintState {
  final bool loading;
  final String? error;
  final List<Complaint> complaints;

  const ComplaintState({
    this.loading = false,
    this.error,
    this.complaints = const [],
  });

  ComplaintState copyWith({
    bool? loading,
    String? error,
    List<Complaint>? complaints,
  }) {
    return ComplaintState(
      loading: loading ?? this.loading,
      error: error,
      complaints: complaints ?? this.complaints,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ComplaintState &&
        other.loading == loading &&
        other.error == error &&
        listEquals(other.complaints, complaints);
  }

  @override
  int get hashCode => Object.hash(loading, error, Object.hashAll(complaints));
}
