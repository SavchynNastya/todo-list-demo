import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/paddings.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/core/widgets/app_bars/app_bar.dart';
import 'package:todolist/core/widgets/constrained_content.dart';
import 'package:todolist/features/sections_board/domain/entities/section.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_cubit.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_state.dart';
import 'package:todolist/features/tasks/create_task/data/models/due_model.dart';
import 'package:todolist/features/tasks/create_task/presentation/cubit/task_create_cubit.dart';
import 'package:todolist/features/tasks/create_task/presentation/cubit/task_create_state.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/content_field.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/description_field.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/section_dropdown.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/time_picker.dart';
import 'package:todolist/injection_container.dart';

class TaskCreateScreen extends StatefulWidget {
  const TaskCreateScreen({Key? key}) : super(key: key);

  @override
  _TaskCreateScreenState createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskCubit = sl<CreateTaskCubit>();
  final _sectionCubit = sl<SectionCubit>();

  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _dueTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _sectionCubit.getSectionsList();
  }

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    _dueTimeController.dispose();
  }

  DueModel? _due;

  // TODO: labels adding
  late final List<String> _selectedLabels = [];
  Section? _selectedSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
          pageTitle: 'Create Task', onBackButtonTap: () => context.pop()),
      body: BlocConsumer<CreateTaskCubit, TaskCreateState>(
        bloc: _taskCubit,
        listener: (context, state) {
          if (state.createTaskStatus == TaskCreateStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Task created successfully!'),
                backgroundColor:
                    Clr.of(context).mainLightGreen.withOpacity(0.4),
              ),
            );
            context.go('/tasks-board/0');
          } else if (state.createTaskStatus == TaskCreateStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Failed to create task'),
                backgroundColor: Clr.of(context).salmon.withOpacity(0.4),
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Form(
              key: _formKey,
              child: ConstrainedContentWidget(
                child: Padding(
                  padding: CPaddings.all16,
                  child: ListView(
                    children: [
                      ContentField(
                        contentController: _contentController,
                      ),
                      const SizedBox(height: 16),
                      DescriptionField(
                        descriptionController: _descriptionController,
                      ),
                      const SizedBox(height: 16),
                      Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Clr.of(context).lightMilkyBaseColor,
                          buttonTheme: ButtonTheme.of(context).copyWith(
                            alignedDropdown: true,
                          ),
                        ),
                        child: BlocBuilder<SectionCubit, SectionState>(
                          bloc: _sectionCubit,
                          builder: (context, state) {
                            if (state.sections != null &&
                                state.getSectionsListStatus ==
                                    SectionStatus.success) {
                              return SectionDropdown(
                                selectedSection: _selectedSection,
                                onChanged: (Section? newValue) {
                                  setState(() {
                                    _selectedSection = newValue;
                                  });
                                },
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _dueDateController,
                        decoration: InputDecoration(
                          labelText: 'Due Date',
                          labelStyle: poppins.w500.lightPurple(context),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Clr.of(context).mainLightGreen,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Clr.of(context).mainLightPink,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor:
                          Clr.of(context).lighterLightYellow.withOpacity(0.2),
                        ),
                        readOnly: true,
                        onTap: () => _selectDueDate(context),
                      ),
                      const SizedBox(height: 16),
                      TimePicker(
                        dueTimeController: _dueTimeController,
                        onDateTimeChanged: (DateTime newDateTime) {
                          setState(() {
                            _dueTimeController.text =
                                DateFormat('HH:mm').format(newDateTime);
                            if (_due != null) {
                              _due = _due!.copyWith(
                                  datetime: _dueTimeController.text) as DueModel?;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Clr.of(context).lighterLightPink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final dueDateTime = _due != null
                                ? DateTime.parse(
                                '${_due!.date}T${_due!.datetime}')
                                .toUtc()
                                .toIso8601String()
                                : null;

                            _taskCubit.createTask(
                              _selectedSection!.id ??
                                  _sectionCubit.state.sections!.firstOrNull!.id!,
                              _contentController.text,
                              _descriptionController.text,
                              _selectedLabels,
                              4,
                              dueDateTime,
                              null,
                              null,
                            );
                          }
                        },
                        child: state.createTaskStatus == TaskCreateStatus.loading
                            ? CircularProgressIndicator(
                          color: Clr.of(context).mainLightPurple,
                        )
                            : const Text(
                          'Create Task',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectDueDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Clr.of(context).lighterLightPink.withOpacity(0.8),
              onPrimary: Clr.of(context).mainBlack,
              onSurface: Clr.of(context).mainBlack,
            ),
            dialogBackgroundColor: Clr.of(context).lightMilkyBaseColor,
            textTheme: TextTheme(
              headlineMedium: poppins.w500.mainBlack(context),
              titleMedium: poppins.w500.mainBlack(context),
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              colorScheme: ColorScheme.light(
                primary: Clr.of(context).mainLightGreen,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              filled: true,
              fillColor: Clr.of(context)
                  .lighterLightPurple
                  .withOpacity(0.3), // Light purple
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _dueDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        _due = DueModel(
          date: _dueDateController.text,
          datetime: '',
          timezone: DateTime.now().timeZoneName,
          isRecurring: false,
          string: '',
        );
      });
    }
  }
}
