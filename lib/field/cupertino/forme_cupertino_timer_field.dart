import 'package:flutter/cupertino.dart';
import 'base_picker.dart';

class FormeCupertinoTimerField
    extends FormeCupertinoBasePicker<Duration?, FormeCupertinoTimerFieldState> {
  FormeCupertinoTimerField({
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
    super.anchorPoint,
    super.barrierColor,
    super.barrierDismissible,
    super.filter,
    required super.triggerBuilder,
    super.height = 216,
    super.routeSettings,
    super.semanticsDismissible,
    super.useRootNavigator,
    this.minuteInterval = 1,
    this.secondInterval = 1,
    this.mode = CupertinoTimerPickerMode.hms,
    this.alignment,
    this.backgroundColor,
  });

  @override
  FormeCupertinoTimerFieldState createState() =>
      FormeCupertinoTimerFieldState();

  final int minuteInterval;
  final int secondInterval;
  final CupertinoTimerPickerMode mode;
  final Color? backgroundColor;
  final AlignmentGeometry? alignment;
}

class FormeCupertinoTimerFieldState
    extends FormeCupertinoBasePickerState<Duration?> {
  Duration? _duration;

  @override
  FormeCupertinoTimerField get widget =>
      super.widget as FormeCupertinoTimerField;

  @override
  void onConfirmed() {
    if (_duration == null) {
      if (value == null) {
        didChange(Duration.zero);
        requestFocusOnUserInteraction();
      }
    } else {
      didChange(_duration);
      requestFocusOnUserInteraction();
    }
    _duration = null;
  }

  @override
  Widget createPickWidget() {
    _duration = null;
    return CupertinoTimerPicker(
      minuteInterval: widget.minuteInterval,
      secondInterval: widget.secondInterval,
      backgroundColor: widget.backgroundColor,
      alignment: widget.alignment ?? Alignment.center,
      initialTimerDuration: value ?? Duration.zero,
      mode: widget.mode,
      onTimerDurationChanged: (Duration timer) {
        _duration = timer;
      },
    );
  }
}
