import 'package:flutter/cupertino.dart';
import 'package:forme/forme.dart';

class FormeCupertinoSlidingSegmentedControl<T extends Object>
    extends FormeField<T?> {
  FormeCupertinoSlidingSegmentedControl({
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
    this.backgroundColor,
    this.disableBackgroundColor,
    this.disableThumbColor,
    this.padding,
    this.thumbColor,
  }) : super.allFields(builder: (state) {
          final bool readOnly = state.readOnly;
          return Focus(
            focusNode: state.focusNode,
            child: IgnorePointer(
              ignoring: readOnly,
              child: CupertinoSlidingSegmentedControl<T>(
                  groupValue: state.value,
                  children: children,
                  thumbColor: (readOnly ? disableThumbColor : thumbColor) ??
                      const CupertinoDynamicColor.withBrightness(
                        color: Color(0xFFFFFFFF),
                        darkColor: Color(0xFF636366),
                      ),
                  backgroundColor:
                      (readOnly ? disableBackgroundColor : backgroundColor) ??
                          CupertinoColors.tertiarySystemFill,
                  padding: padding ??
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                  onValueChanged: (v) {
                    state.didChange(v);
                    state.requestFocusOnUserInteraction();
                  }),
            ),
          );
        });

  final Map<T, Widget> children;
  final Color? thumbColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Color? disableThumbColor;
  final Color? disableBackgroundColor;
}
