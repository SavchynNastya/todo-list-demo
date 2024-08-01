import 'package:equatable/equatable.dart';

class TaskDuration extends Equatable {
  final int? amount;
  final String? unit;

  const TaskDuration({
    required this.amount,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'unit': unit,
    };
  }

  @override
  List<Object?> get props => [amount, unit];
}