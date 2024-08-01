import 'package:todolist/features/tasks/create_task/domain/entities/duration.dart';

class TaskDurationModel extends TaskDuration {
  const TaskDurationModel({
    required int? amount,
    required String? unit,
  }) : super(
    amount: amount,
    unit: unit,
  );

  factory TaskDurationModel.fromJson(Map<String, dynamic> json) {
    return TaskDurationModel(
      amount: json['amount'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'unit': unit,
    };
  }

  TaskDuration copyWith({
    int? amount,
    String? unit,
  }) {
    return TaskDurationModel(
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
    );
  }

  @override
  List<Object?> get props => [amount, unit];
}
