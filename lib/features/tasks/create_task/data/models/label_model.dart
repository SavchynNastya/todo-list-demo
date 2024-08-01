

import 'package:todolist/features/tasks/create_task/domain/entities/label.dart';

class LabelModel extends Label {
  const LabelModel({
    required String id,
    required String name,
    required String color,
    required int order,
    required bool isFavorite,
  }) : super(
    id: id,
    name: name,
    color: color,
    order: order,
    isFavorite: isFavorite,
  );

  factory LabelModel.fromJson(Map<String, dynamic> json) {
    return LabelModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      order: json['order'],
      isFavorite: json['is_favorite'],
    );
  }
}
