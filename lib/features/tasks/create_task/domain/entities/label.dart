import 'package:equatable/equatable.dart';

class Label extends Equatable {
  final String id;
  final String name;
  final String color;
  final int order;
  final bool isFavorite;

  const Label({
    required this.id,
    required this.name,
    required this.color,
    required this.order,
    required this.isFavorite,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color,
      'order': order,
      'is_favorite': isFavorite,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    color,
    order,
    isFavorite,
  ];
}