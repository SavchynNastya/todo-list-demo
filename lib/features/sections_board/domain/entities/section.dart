import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final String? id;
  final String? projectId;
  final int? order;
  final String name;

  const Section({
    this.id,
    this.projectId,
    this.order,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'order': order,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [
    id,
    projectId,
    order,
    name,
  ];
}