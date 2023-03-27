import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

class FormeDropdownButton<T extends Object> extends FormeField<T?> {
  FormeDropdownButton({
    super.key,
    super.name,
    super.initialValue,
    super.asyncValidator,
    super.asyncValidatorDebounce,
    super.autovalidateMode,
    super.enabled = true,
    super.focusNode,
    super.onInitialized,
    super.onSaved,
    super.onStatusChanged,
    super.order,
    super.quietlyValidate = false,
    super.readOnly = false,
    super.requestFocusOnUserInteraction = true,
    super.validationFilter,
    super.validator,
    super.decorator,
    this.items,
    this.alignment,
    this.autofocus = false,
    this.borderRadius,
    this.decoration,
    this.disabledHint,
    this.dropdownColor,
    this.elevation = 8,
    this.enableFeedback,
    this.focusColor,
    this.hint,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24,
    this.isDense = true,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    this.menuMaxHeight,
    this.onTap,
    this.selectedItemBuilder,
    this.style,
  }) : super.allFields(
          builder: (state) {
            final bool readOnly = state.readOnly;
            // we add [Form] here to avoid register to user's [Form]
            return Form(
              child: DropdownButtonFormField(
                autofocus: autofocus,
                selectedItemBuilder: selectedItemBuilder,
                hint: hint,
                disabledHint: disabledHint,
                onTap: onTap,
                elevation: 8,
                style: style,
                items: items,
                icon: icon,
                iconDisabledColor: iconDisabledColor,
                iconEnabledColor: iconEnabledColor,
                iconSize: iconSize,
                isDense: isDense,
                isExpanded: isExpanded,
                itemHeight: itemHeight,
                focusColor: focusColor,
                dropdownColor: dropdownColor,
                menuMaxHeight: menuMaxHeight,
                enableFeedback: enableFeedback,
                alignment: alignment ?? AlignmentDirectional.centerStart,
                borderRadius: borderRadius,
                onChanged: readOnly ? null : state.didChange,
                decoration:
                    (decoration ?? InputDecoration(focusColor: focusColor))
                        .copyWith(errorText: state.errorText),
                value: state.value,
                focusNode: state.focusNode,
              ),
            );
          },
        );

  final List<DropdownMenuItem<T>>? items;
  final DropdownButtonBuilder? selectedItemBuilder;
  final VoidCallback? onTap;
  final bool autofocus;
  final int elevation;
  final TextStyle? style;
  final bool isDense;
  final bool isExpanded;
  final double itemHeight;
  final Color? focusColor;
  final Color? dropdownColor;
  final double iconSize;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double? menuMaxHeight;
  final bool? enableFeedback;
  final AlignmentGeometry? alignment;
  final BorderRadius? borderRadius;
  final Widget? hint;
  final Widget? disabledHint;
  final InputDecoration? decoration;
}
