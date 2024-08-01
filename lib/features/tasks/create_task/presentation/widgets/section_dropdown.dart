import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/features/sections_board/domain/entities/section.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_cubit.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_state.dart';

class SectionDropdown extends StatelessWidget {
  final SectionCubit sectionCubit;
  final ValueChanged<Section?> onSectionSelected;

  const SectionDropdown({
    Key? key,
    required this.sectionCubit,
    required this.onSectionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionCubit, SectionState>(
      bloc: sectionCubit,
      builder: (context, state) {
        if (state.sections != null &&
            state.getSectionsListStatus == SectionStatus.success) {
          return DropdownButtonHideUnderline(
            child: DropdownButton<Section?>(
              hint: Text(
                'Select Section',
                style: poppins.w500.darkGray(context),
              ),
              items: state.sections!
                  .map<DropdownMenuItem<Section>>((Section section) {
                return DropdownMenuItem<Section>(
                  value: section,
                  child: Text(section.name),
                );
              }).toList(),
              onChanged: onSectionSelected,
              isExpanded: true,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: Clr.of(context).mainLightPurple,
          ),
        );
      },
    );
  }
}
