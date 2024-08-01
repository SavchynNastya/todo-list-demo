import 'package:flutter/material.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/style/texts/text_styles.dart';

class SettingsItemTile extends StatelessWidget {
  final String actionName;
  final Function()? onTapAction;
  final String? value;
  final int flexValueName;
  final int flexValueValue;

  const SettingsItemTile({
    Key? key,
    required this.actionName,
    required this.onTapAction,
    this.value,
    this.flexValueName = 1,
    this.flexValueValue = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Clr.of(context).lightGray,
        onTap: onTapAction,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: flexValueName,
                child: Text(
                  actionName,
                  style: poppins.w400.s15
                      .copyWith(color: Clr.of(context).darkGray),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: flexValueValue,
                child: value != null
                    ? Text(
                  actionName,
                  style: poppins.w400.s12.darkGray(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                )
                    : Text(
                  actionName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: poppins.w400.s12.darkGray(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
