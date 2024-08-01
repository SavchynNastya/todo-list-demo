import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/core/style/border_radiuses.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/widgets/constrained_content.dart';
import 'package:todolist/core/widgets/empty_states/default_empty_state.dart';
import 'package:todolist/core/widgets/skeletons/default_skeleton_list.dart';
import 'package:todolist/features/sections_board/domain/entities/section.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_cubit.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_state.dart';
import 'package:todolist/features/sections_board/presentation/widgets/task_tile.dart';
import 'package:todolist/injection_container.dart';

class TasksPage extends StatefulWidget {
  final Section section;

  const TasksPage({super.key, required this.section});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final SectionCubit _sectionCubit = sl<SectionCubit>();
  bool _isInitialized = false;

  // @override
  // void initState() {
  //   _sectionCubit.getTasksList(widget.section.id, null);
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _sectionCubit.getTasksList(widget.section.id, null);
      _isInitialized = true;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionCubit, SectionState>(
      bloc: _sectionCubit,
      builder: (context, state) {
        if (state.getTasksListStatus == SectionStatus.loading) {
          return const DefaultSkeletonList();
        } else {
          return Center(
            child: ConstrainedContentWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _sectionCubit.getTasksList(widget.section.id, null);
                      },
                      child: state.tasks != null && state.tasks!.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: false,
                              physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              // itemCount: 15,
                              itemCount: state.tasks!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8, top: index == 0 ? 16 : 0),
                                  child: TaskTile(
                                    taskItem: state.tasks![index],
                                    color: Clr.of(context).lighterLightYellow,
                                    borderRadius: CBorderRadius.all8,
                                  ),
                                );
                              },
                            )
                          : const CustomScrollView(
                              physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              slivers: [
                                SliverFillRemaining(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      DefaultEmptyState(
                                        emptyText:
                                            'No tasks in the section yet!',
                                        navigateTo: '/create-task',
                                        routeName: 'Create a task',
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
