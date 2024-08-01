import 'package:dartz/dartz.dart' as dartz;
import 'package:fimber/fimber.dart';
import 'package:todolist/core/errors/failures.dart';
import 'package:todolist/core/helpers/types.dart';
import 'package:todolist/features/sections_board/domain/entities/section.dart';
import 'package:todolist/features/sections_board/domain/repositories/section_repository.dart';
import 'package:todolist/features/sections_board/data/datasource/section_datasource.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';


class SectionRepositoryImpl extends SectionRepository {
  final SectionDatasource datasource;

  SectionRepositoryImpl({
    required this.datasource,
  });

  @override
  FutureFailable<List<Section>> getSectionsList() async {
    try {
      final sections = await datasource.getSectionsList();
      return dartz.Right(sections);
    } catch (e, st) {
      Fimber.e('Error getting sections list: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }

  @override
  FutureFailable<Section> createSection(String sectionName) async {
    try {
      final createdSection = await datasource.createSection(sectionName);
      return dartz.Right(createdSection);
    } catch (e, st) {
      Fimber.e('Error creating section: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }

  @override
  FutureFailable<Section> getSection(String sectionId) async {
    try {
      final section = await datasource.getSection(sectionId);
      return dartz.Right(section);
    } catch (e, st) {
      Fimber.e('Error getting section: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }

  @override
  FutureFailable<List<Task>> getTasksList(String? sectionId, String? label) async {
    try {
      final tasksList = await datasource.getTasksList(sectionId, label);
      return dartz.Right(tasksList);
    } catch (e, st) {
      Fimber.e('Error getting section: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }

  @override
  FutureFailable<Section> updateSection(String sectionId, String sectionName) async {
    try {
      final updatedSection = await datasource.updateSection(sectionId, sectionName);
      return dartz.Right(updatedSection);
    } catch (e, st) {
      Fimber.e('Error updating section: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }

  @override
  FutureFailable<bool> deleteSection(String sectionId) async {
    try {
      final result = await datasource.deleteSection(sectionId);
      return dartz.Right(result);
    } catch (e, st) {
      Fimber.e('Error deleting section: $e', stacktrace: st);
      return dartz.Left(Failure());
    }
  }
}
