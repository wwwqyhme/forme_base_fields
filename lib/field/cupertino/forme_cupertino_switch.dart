import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:forme/forme.dart';

class FormeCupertinoSwitch extends FormeField<bool> {
  FormeCupertinoSwitch({
    super.key,
    super.name,
    super.initialValue = false,
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
    this.activeColor,
    this.dragStartBehavior = DragStartBehavior.start,
    this.thumbColor,
    this.trackColor,
  }) : super.allFields(
          builder: (state) {
            final bool readOnly = state.readOnly;
            final bool value = state.value;
            return CupertinoSwitch(
              thumbColor: thumbColor,
              value: value,
              onChanged: readOnly
                  ? null
                  : (v) {
                      state.didChange(v);
                      state.requestFocusOnUserInteraction();
                    },
              activeColor: activeColor,
              trackColor: trackColor,
              dragStartBehavior: dragStartBehavior,
            );
          },
        );

  final Color? activeColor;
  final Color? trackColor;
  final DragStartBehavior dragStartBehavior;
  final Color? thumbColor;
}
