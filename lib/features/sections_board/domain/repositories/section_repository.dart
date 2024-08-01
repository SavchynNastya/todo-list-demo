import 'package:todolist/core/helpers/types.dart';
import 'package:todolist/features/sections_board/domain/entities/section.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';

abstract class SectionRepository {
  FutureFailable<List<Section>> getSectionsList();
  FutureFailable<Section> createSection(String sectionName);
  FutureFailable<Section> getSection(String sectionId);
  FutureFailable<List<Task>> getTasksList(String? sectionId, String? label);
  FutureFailable<Section> updateSection(String sectionId, String sectionName);
  FutureFailable<bool> deleteSection(String section);
}
