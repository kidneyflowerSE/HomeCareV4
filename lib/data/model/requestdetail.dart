import 'package:foodapp/data/model/request.dart';

class RequestDetail {
  Comment comment;
  String id;
  String workingDate;
  String helperID;
  String status;
  num helperCost;
  String startTime;
  String endTime;

  RequestDetail(
      {required this.id,
      required this.workingDate,
      required this.helperID,
      required this.status,
      required this.helperCost,
      required this.comment,
      required this.startTime,
      required this.endTime});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestDetail &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          workingDate == other.workingDate &&
          helperID == other.helperID &&
          status == other.status &&
          helperCost == other.helperCost;

  @override
  int get hashCode =>
      id.hashCode ^
      workingDate.hashCode ^
      helperID.hashCode ^
      status.hashCode ^
      helperCost.hashCode;

  factory RequestDetail.fromJson(Map<String, dynamic> map) {
    return RequestDetail(
        id: map['_id'],
        helperCost: map['helper_cost'],
        helperID: map['helper_id'],
        status: map['status'],
        workingDate: map['workingDate'],
        comment: Comment.fromJson(map['comment']),
        startTime: 'startTime',
        endTime: 'endTime');
  }

  @override
  String toString() {
    return 'RequestDetail{comment: $comment, id: $id, workingDate: $workingDate, helperID: $helperID, status: $status, helperCost: $helperCost, startTime: $startTime, endTime: $endTime}';
  }
}
