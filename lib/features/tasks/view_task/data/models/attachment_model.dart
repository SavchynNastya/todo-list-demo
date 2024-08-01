import 'package:todolist/features/tasks/view_task/domain/entities/attachment.dart';

class AttachmentModel extends Attachment {
  const AttachmentModel({
    required String fileName,
    required String fileType,
    required String fileUrl,
    required String resourceType,
  }) : super(
    fileName: fileName,
    fileType: fileType,
    fileUrl: fileUrl,
    resourceType: resourceType,
  );

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      fileName: json['file_name'],
      fileType: json['file_type'],
      fileUrl: json['file_url'],
      resourceType: json['resource_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file_name': fileName,
      'file_type': fileType,
      'file_url': fileUrl,
      'resource_type': resourceType,
    };
  }

  AttachmentModel copyWith({
    String? fileName,
    String? fileType,
    String? fileUrl,
    String? resourceType,
  }) {
    return AttachmentModel(
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      fileUrl: fileUrl ?? this.fileUrl,
      resourceType: resourceType ?? this.resourceType,
    );
  }

  @override
  List<Object?> get props => [fileName, fileType, fileUrl, resourceType];
}
