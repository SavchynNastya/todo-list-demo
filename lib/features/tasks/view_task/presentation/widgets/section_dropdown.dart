import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/core/style/border_radiuses.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';
import 'package:todolist/core/widgets/constrained_content.dart';
import 'package:todolist/features/sections_board/domain/entities/section.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_cubit.dart';
import 'package:todolist/injection_container.dart';

class SectionDropdown extends StatefulWidget {
  final Section? selectedSection;
  final void Function(Section?) onChanged;


  const SectionDropdown({super.key, required this.selectedSection, required this.onChanged});

  @override
  State<SectionDropdown> createState() => _SectionDropdownState();
}

class _SectionDropdownState extends State<SectionDropdown> {
  final SectionCubit _sectionCubit = sl<SectionCubit>();

  @override
  Widget build(BuildContext context) {
    return ConstrainedContentWidget(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Section?>(
          value: widget.selectedSection,
          hint: Text(
            'Select Section',
            style: poppins.w500.lightPurple(context),
          ),
          items: _sectionCubit.state.sections!
              .map<DropdownMenuItem<Section>>((Section section) {
            return DropdownMenuItem<Section>(
              value: section,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                child: Text(
                  section.name,
                  style: poppins.w500.lightPurple(context),
                ),
              ),
            );
          }).toList(),
          onChanged: widget.onChanged,
          borderRadius: CBorderRadius.all12,
          style: poppins.w500.lightPurple(context),
          icon:
          Icon(Icons.arrow_drop_down, color: Clr.of(context).mainLightGreen),
          isExpanded: true,
        ),
      ),
    );
  }
}
