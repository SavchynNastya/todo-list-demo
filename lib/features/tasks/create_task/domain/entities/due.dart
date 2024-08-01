import 'package:equatable/equatable.dart';

class Due extends Equatable {
  final String date;
  final bool isRecurring;
  final String? datetime;
  final String? string;
  final String? timezone;

  const Due({
    required this.date,
    required this.isRecurring,
    required this.datetime,
    required this.string,
    required this.timezone,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'is_recurring': isRecurring,
      'datetime': datetime,
      'string': string,
      'timezone': timezone,
    };
  }

  @override
  List<Object?> get props => [
    date,
    isRecurring,
    datetime,
    string,
    timezone,
  ];
}