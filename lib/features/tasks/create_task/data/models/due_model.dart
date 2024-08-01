import 'package:equatable/equatable.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/due.dart';

class DueModel extends Due {
  const DueModel({
    required String date,
    required bool isRecurring,
    required String? datetime,
    required String? string,
    required String? timezone,
  }) : super(
    date: date,
    isRecurring: isRecurring,
    datetime: datetime,
    string: string,
    timezone: timezone,
  );

  factory DueModel.fromJson(Map<String, dynamic> json) {
    return DueModel(
      date: json['date'],
      isRecurring: json['is_recurring'],
      datetime: json['datetime'],
      string: json['string'],
      timezone: json['timezone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'is_recurring': isRecurring,
      'datetime': datetime,
      'string': string,
      'timezone': timezone,
    };
  }

  Due copyWith({
    String? date,
    bool? isRecurring,
    String? datetime,
    String? string,
    String? timezone,
  }) {
    return DueModel(
      date: date ?? this.date,
      isRecurring: isRecurring ?? this.isRecurring,
      datetime: datetime ?? this.datetime,
      string: string ?? this.string,
      timezone: timezone ?? this.timezone,
    );
  }

  @override
  List<Object?> get props => [date, isRecurring, datetime, string, timezone];
}
