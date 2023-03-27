import 'package:flutter/cupertino.dart';
import 'package:forme/forme.dart';

class FormeCupertinoSegmentedControl<T extends Object> extends FormeField<T?> {
  FormeCupertinoSegmentedControl({
    super.key,
    super.name,
    super.initialValue,
    super.asyncValidator,
    super.asyncValidatorDebounce,
    super.autovalidateMode,
    super.decorator,
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
    required this.children,
    this.borderColor,
    this.disableBorderColor,
    this.disableSelectedColor,
    this.disableUnselectedColor,
    this.padding,
    this.pressedColor,
    this.selectedColor,
    this.unselectedColor,
  }) : super.allFields(builder: (state) {
          final bool readOnly = state.readOnly;
          return Focus(
            focusNode: state.focusNode,
            //still now way to disable CupertinoSegmentedControl officially after 3 years....
            child: IgnorePointer(
              ignoring: readOnly,
              child: CupertinoSegmentedControl<T>(
                  groupValue: state.value,
                  children: children,
                  unselectedColor:
                      readOnly ? disableUnselectedColor : unselectedColor,
                  selectedColor:
                      readOnly ? disableSelectedColor : selectedColor,
                  borderColor: readOnly ? disableBorderColor : borderColor,
                  pressedColor: pressedColor,
                  padding: padding,
                  onValueChanged: (v) {
                    state.didChange(v);
                    state.requestFocusOnUserInteraction();
                  }),
            ),
          );
        });

  final Map<T, Widget> children;
  final Color? unselectedColor;
  final Color? selectedColor;
  final Color? borderColor;
  final Color? pressedColor;
  final EdgeInsetsGeometry? padding;
  final Color? disableUnselectedColor;
  final Color? disableSelectedColor;
  final Color? disableBorderColor;
}
