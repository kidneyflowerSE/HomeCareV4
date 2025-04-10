import 'package:foodapp/data/model/request.dart'; // Assuming you have a Comment model

class RequestDetail {
  Comment comment;
  String id;
  String workingDate; // Changed to DateTime
  String helperID;
  String status;
  num helperCost;
  DateTime startTime; // Changed to DateTime
  DateTime endTime; // Changed to DateTime
  num? totalCost;

  RequestDetail(
      {required this.id,
      required this.workingDate,
      required this.helperID,
      required this.status,
      required this.helperCost,
      required this.comment,
      required this.startTime,
      required this.endTime,
      required this.totalCost});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestDetail &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          workingDate == other.workingDate &&
          helperID == other.helperID &&
          status == other.status &&
          helperCost == other.helperCost &&
          totalCost == other.totalCost;

  @override
  int get hashCode =>
      id.hashCode ^
      workingDate.hashCode ^
      helperID.hashCode ^
      status.hashCode ^
      helperCost.hashCode ^
      totalCost.hashCode;

  factory RequestDetail.fromJson(Map<String, dynamic> map) {
    return RequestDetail(
        id: map['_id'],
        helperCost: map['helper_cost'],
        helperID: map['helper_id'],
        status: map['status'],
        workingDate: map['workingDate'],
        // Parsing to DateTime
        comment: Comment.fromJson(map['comment']),
        startTime: DateTime.parse(map['startTime']),
        // Parsing to DateTime
        endTime: DateTime.parse(map['endTime']),
        // Parsing to DateTime
        totalCost: map['totalCost']);
  }

  @override
  String toString() {
    return 'RequestDetail{comment: $comment, id: $id, workingDate: $workingDate, helperID: $helperID, status: $status, helperCost: $helperCost, startTime: $startTime, endTime: $endTime, totalCost: $totalCost}';
  }
}
