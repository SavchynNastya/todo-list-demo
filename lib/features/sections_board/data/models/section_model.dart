import 'package:todolist/features/sections_board/domain/entities/section.dart';

class SectionModel extends Section {
  const SectionModel({
    required String id,
    required String projectId,
    required int order,
    required String name,
  }) : super(
    id: id,
    projectId: projectId,
    order: order,
    name: name,
  );

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'],
      projectId: json['project_id'],
      order: json['order'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'order': order,
      'name': name,
    };
  }
}
