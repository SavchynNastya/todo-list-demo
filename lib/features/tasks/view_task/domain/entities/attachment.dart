
import 'package:equatable/equatable.dart';

class Attachment extends Equatable {
  final String fileName;
  final String fileType;
  final String fileUrl;
  final String resourceType;

  const Attachment({
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
    required this.resourceType,
  });

  Map<String, dynamic> toJson() {
    return {
      'file_name': fileName,
      'file_type': fileType,
      'file_url': fileUrl,
      'resource_type': resourceType,
    };
  }

  @override
  List<Object?> get props => [
    fileName,
    fileType,
    fileUrl,
    resourceType,
  ];
}