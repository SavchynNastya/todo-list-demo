import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/core/widgets/app_bars/app_bar.dart';
import 'package:todolist/core/widgets/skeletons/default_skeleton_list.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_cubit.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_state.dart';
import 'package:todolist/injection_container.dart';

class SectionCreateScreen extends StatefulWidget {
  const SectionCreateScreen({Key? key}) : super(key: key);

  @override
  State<SectionCreateScreen> createState() => _SectionCreateScreenState();
}

class _SectionCreateScreenState extends State<SectionCreateScreen> {
  final TextEditingController _controller = TextEditingController();
  final SectionCubit _sectionCubit = sl<SectionCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Clr.of(context).lightMilkyBaseColor,
      appBar: DefaultAppBar(
        pageTitle: 'Create Section',
        onBackButtonTap: () => context.pop(),
      ),
      body: BlocConsumer<SectionCubit, SectionState>(
        bloc: _sectionCubit,
        listener: (context, state) {
          if (state.createSectionStatus == SectionStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Section created successfully!',
                  style: poppins.w500.s16.copyWith(color: Colors.white),
                ),
                backgroundColor: Clr.of(context).mainLightGreen,
              ),
            );
            Navigator.pop(context); // Navigate back after success
          } else if (state.createSectionStatus == SectionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Failed to create section. Please try again.',
                  style: poppins.w500.s16.copyWith(color: Colors.white),
                ),
                backgroundColor: Clr.of(context).salmon,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Section Name',
                    labelStyle: poppins.w400.s16.copyWith(
                      color: Clr.of(context).grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Clr.of(context).mainLightPink,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Clr.of(context).mainLightPink,
                        width: 2.0,
                      ),
                    ),
                  ),
                  style: poppins.w400.s16
                      .copyWith(color: Clr.of(context).mainBlack),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sectionCubit.createSection(_controller.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Section name cannot be empty.',
                            style:
                                poppins.w500.s16.copyWith(color: Colors.white),
                          ),
                          backgroundColor: Clr.of(context).salmon,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Clr.of(context).mainLightPink,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: poppins.w700.s16.copyWith(color: Colors.white),
                  ),
                  child: state.createSectionStatus == SectionStatus.loading
                      ? const DefaultSkeletonList()
                      : Text('Create Section',
                          style: poppins.w500.darkGray(context)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
