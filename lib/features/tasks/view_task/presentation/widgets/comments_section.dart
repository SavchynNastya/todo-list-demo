import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/paddings.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/features/tasks/create_task/presentation/widgets/comment_tile.dart';
import 'package:todolist/features/tasks/view_task/presentation/cubit/view_task_cubit.dart';
import 'package:todolist/features/tasks/view_task/presentation/cubit/view_task_state.dart';
import 'package:todolist/injection_container.dart';


class CommentsSection extends StatefulWidget {
  final String taskId;

  const CommentsSection({super.key, required this.taskId});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final _taskDetailsCubit = sl<TaskDetailsCubit>();
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailsCubit, TaskDetailsState>(
      bloc: _taskDetailsCubit,
      builder: (context, state) {
        if (state.getTaskCommentsStatus == TaskDetailsStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: Clr.of(context).mainLightPurple,
            ),
          );
        } else if (state.getTaskCommentsStatus == TaskDetailsStatus.failure) {
          return Center(
              child: Text(
                'Failed to load comments',
                style: poppins.w400.lightPink(context),
              ));
        } else if (state.getTaskCommentsStatus == TaskDetailsStatus.success) {
          return Column(
            children: [
              Padding(
                padding: CPaddings.all16,
                child: Text(
                  'Comments',
                  style: poppins.w500.s16.darkGray(context),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.comments?.length,
                  itemBuilder: (context, index) {
                    final comment = state.comments?[index];
                    return CommentTile(
                      comment: comment!,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          labelText: 'Add a comment...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        _taskDetailsCubit.createComment(
                            widget.taskId, _commentController.text, null);
                        _commentController.clear();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink(); // In case there's no state to display
        }
      },
    );
  }
}
