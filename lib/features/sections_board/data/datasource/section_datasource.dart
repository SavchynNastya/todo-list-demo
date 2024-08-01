import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';
import 'package:todolist/features/sections_board/data/models/section_model.dart';
import 'package:todolist/features/sections_board/domain/entities/section.dart';
import 'package:todolist/features/tasks/create_task/data/models/task_model.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';

abstract class SectionDatasource {
  Future<List<Section>> getSectionsList();
  Future<Section> createSection(String sectionName);
  Future<Section> getSection(String sectionId);
  Future<List<Task>> getTasksList(String? sectionId, String? label);
  Future<Section> updateSection(String sectionId, String sectionName);
  Future<bool> deleteSection(String sectionId);
}


class SectionDatasourceImpl extends SectionDatasource {
  SectionDatasourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<Section>> getSectionsList() async {
    try {
      final response = await dio.get('/rest/v2/sections');
      final List<dynamic> sectionsJson = response.data;
      return sectionsJson.map((json) => SectionModel.fromJson(json)).toList();
    } catch (e, st) {
      Fimber.e('Error getting sections list: $e', stacktrace: st);
      throw Exception('Failed to load sections');
    }
  }

  @override
  Future<Section> createSection(String sectionName) async {
    FormData formData = FormData.fromMap({
      'project_id': '2337041362',
      'name': sectionName,
    });
    try {
      final response = await dio.post(
        '/rest/v2/sections',
        data: formData,
      );
      return SectionModel.fromJson(response.data);
    } catch (e, st) {
      Fimber.e('Error creating section: $e', stacktrace: st);
      throw Exception('Failed to create section');
    }
  }

  @override
  Future<Section> getSection(String sectionId) async {
    try {
      final response = await dio.get('/rest/v2/sections/$sectionId');
      return SectionModel.fromJson(response.data);
    } catch (e, st) {
      Fimber.e('Error getting section: $e', stacktrace: st);
      throw Exception('Failed to load section');
    }
  }

  @override
  Future<List<Task>> getTasksList(String? sectionId, String? label) async {
    Map<String, String> queryParameters = {};

    if (sectionId != null) {
      queryParameters['section_id'] = sectionId;
    }
    if (label != null) {
      queryParameters['label'] = label;
    }

    try {
      final response = await dio.get('/rest/v2/tasks', queryParameters: queryParameters);
      final List<dynamic> tasksJson = response.data;
      return tasksJson.map((json) => TaskModel.fromJson(json)).toList();
    } catch (e, st) {
      Fimber.e('Error getting section: $e', stacktrace: st);
      throw Exception('Failed to load section');
    }
  }

  @override
  Future<Section> updateSection(String sectionId, String sectionName) async {
    FormData formData = FormData.fromMap({
      'name': sectionName,
    });
    try {
      final response = await dio.post(
        '/rest/v2/sections/${sectionId}',
        data: formData,
      );
      return SectionModel.fromJson(response.data);
    } catch (e, st) {
      Fimber.e('Error updating section: $e', stacktrace: st);
      throw Exception('Failed to update section');
    }
  }

  @override
  Future<bool> deleteSection(String sectionId) async {
    try {
      await dio.delete('/rest/v2/sections/$sectionId');
      return true;
    } catch (e, st) {
      Fimber.e('Error deleting section: $e', stacktrace: st);
      throw Exception('Failed to delete section');
    }
  }
}
