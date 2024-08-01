import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/core/widgets/app_bars/app_bar.dart';
import 'package:todolist/features/sections_board/domain/entities/section.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_cubit.dart';
import 'package:todolist/features/tasks/create_task/domain/entities/task.dart';
import 'package:todolist/features/tasks/create_task/presentation/cubit/task_create_cubit.dart';
import 'package:todolist/features/tasks/create_task/presentation/cubit/task_create_state.dart';
import 'package:todolist/features/tasks/view_task/presentation/cubit/view_task_cubit.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/collapsed_comments_panel.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/comments_section.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/content_field.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/description_field.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/elevated_button_widget.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/section_dropdown.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/time_picker.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/timer_widget.dart';
import 'package:todolist/injection_container.dart';

class TaskDetailsPage extends StatefulWidget {
  final String taskId;

  const TaskDetailsPage({Key? key, required this.taskId}) : super(key: key);

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late Task? task;

  final _taskCubit = sl<CreateTaskCubit>();
  final _taskDetailsCubit = sl<TaskDetailsCubit>();
  final _sectionCubit = sl<SectionCubit>();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _contentController;
  late TextEditingController _descriptionController;
  late TextEditingController _dueDateController;
  late TextEditingController _dueTimeController;
  Section? _selectedSection;

  Duration _elapsedTime = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    task = _sectionCubit.state.tasks
        ?.firstWhereOrNull((task) => task.id == widget.taskId)!;

    _taskDetailsCubit.getTaskComments(task!.id);

    final String? datetimeString = task?.due?.datetime;

    DateTime? dateTime;
    if (datetimeString != null) {
      dateTime = DateTime.parse(datetimeString);
    }

    _contentController = TextEditingController(text: task?.content ?? '');
    _descriptionController =
        TextEditingController(text: task?.description ?? '');
    _dueDateController = TextEditingController(text: task?.due?.date ?? '');
    _dueTimeController = TextEditingController(
        text: dateTime != null ? DateFormat.Hm().format(dateTime) : '');

    _selectedSection = _sectionCubit.state.sections
        ?.firstWhereOrNull((e) => e.id == task?.sectionId);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime += const Duration(seconds: 1);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    _dueTimeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        pageTitle: 'Task Details',
        onBackButtonTap: () => context.pop(),
      ),
      body: BlocConsumer<CreateTaskCubit, TaskCreateState>(
        bloc: _taskCubit,
        listener: (context, state) {
          if (state.createTaskStatus == TaskCreateStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Task updated successfully!'),
                backgroundColor: Colors.green.withOpacity(0.4),
              ),
            );
            context.pop();
          } else if (state.createTaskStatus == TaskCreateStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Failed to update task'),
                backgroundColor: Colors.red.withOpacity(0.4),
              ),
            );
          }
        },
        builder: (context, state) {
          return SlidingUpPanel(
            panel: CommentsSection(
              taskId: task!.id,
            ),
            collapsed: const CollapsedCommentsPanel(),
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(24.0)),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    ContentField(
                      contentController: _contentController,
                    ),
                    const SizedBox(height: 16),
                    // _buildDescriptionField(context),
                    DescriptionField(
                      descriptionController: _descriptionController,
                    ),
                    const SizedBox(height: 16),
                    // _buildSectionDropdown(context),
                    SectionDropdown(
                        selectedSection: _selectedSection,
                        onChanged: (Section? newValue) {
                          setState(() {
                            _selectedSection = newValue;
                          });
                        }),
                    const SizedBox(height: 16),
                    _buildDueDateField(context),
                    const SizedBox(height: 16),
                    TimePicker(
                      onDateTimeChanged: (DateTime newDateTime) {
                        setState(() {
                          _dueTimeController.text =
                              DateFormat('HH:mm').format(newDateTime);
                        });
                      },
                      dueTimeController: _dueTimeController,
                    ),
                    const SizedBox(height: 16),
                    TimerWidget(
                      elapsedTime: _elapsedTime,
                      startTimer: _startTimer,
                      stopTimer: _stopTimer,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButtonWidget(
                      onPressed: () {
                        final dueDateTime = DateTime.parse(
                            '${_dueDateController.text}T${_dueTimeController
                                .text}')
                            .toUtc()
                            .toIso8601String();

                        if (_formKey.currentState!.validate()) {
                          _taskDetailsCubit.updateTask(
                            task!.id,
                            _contentController.text,
                            _descriptionController.text,
                            task?.labels,
                            task?.priority,
                            dueDateTime,
                            _elapsedTime.inSeconds != 0
                                ? _elapsedTime.inSeconds ~/ 60
                                : task?.duration?.amount,
                            _elapsedTime.inSeconds > 0 ? 'minute' : null,
                          );
                        }
                      },
                      child: const Text('Save Changes'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButtonWidget(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _taskDetailsCubit.closeTask(task!.id);
                        }
                      },
                      child: const Text('Complete task'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDueDateField(BuildContext context) {
    return TextFormField(
      controller: _dueDateController,
      decoration: InputDecoration(
        labelText: 'Due Date',
        labelStyle: poppins.w500.lightPurple(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Clr
                .of(context)
                .mainLightGreen,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Clr
                .of(context)
                .mainLightPink,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Clr
            .of(context)
            .lighterLightYellow
            .withOpacity(0.2),
      ),
      readOnly: true,
      onTap: () => _selectDueDate(context),
    );
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Clr
                  .of(context)
                  .lighterLightPink
                  .withOpacity(0.8),
              onPrimary: Clr
                  .of(context)
                  .mainBlack,
              onSurface: Clr
                  .of(context)
                  .mainBlack,
            ),
            dialogBackgroundColor: Clr
                .of(context)
                .lightMilkyBaseColor,
            textTheme: TextTheme(
              headlineMedium: poppins.w500.mainBlack(context),
              titleMedium: poppins.w500.mainBlack(context),
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              colorScheme: ColorScheme.light(
                primary: Clr
                    .of(context)
                    .mainLightGreen,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              filled: true,
              fillColor: Clr
                  .of(context)
                  .lighterLightPurple
                  .withOpacity(0.3), // Light purple
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dueDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}