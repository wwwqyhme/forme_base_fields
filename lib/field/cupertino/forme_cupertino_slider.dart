import 'package:flutter/cupertino.dart';
import 'package:forme/forme.dart';

class FormeCupertinoSlider extends FormeField<double> {
  FormeCupertinoSlider({
    super.key,
    super.name,
    double? initialValue,
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
    required this.min,
    required this.max,
    this.activeColor,
    this.divisions,
    this.onChangeEnd,
    this.onChangeStart,
    this.onChanged,
    this.thumbColor = CupertinoColors.white,
  }) : super.allFields(
          initialValue: initialValue == null
              ? min
              : initialValue < min || initialValue > max
                  ? min
                  : initialValue,
          builder: (baseState) {
            final _FormeCupertinoSliderState state =
                baseState as _FormeCupertinoSliderState;
            return ValueListenableBuilder<double?>(
                valueListenable: state.notifier,
                builder: (context, _, __) {
                  return Focus(
                    focusNode: state.focusNode,
                    child: CupertinoSlider(
                        value: state.value,
                        min: min,
                        max: max,
                        onChangeStart: (v) {
                          state.focusNode.requestFocus();
                          onChangeStart?.call(v);
                        },
                        onChangeEnd: (v) {
                          state.didChange(v);
                          onChangeEnd?.call(v);
                        },
                        activeColor: activeColor,
                        thumbColor: thumbColor,
                        divisions: divisions ?? (max - min).floor(),
                        onChanged: state.readOnly
                            ? null
                            : (v) {
                                state.updateValue(v);
                                onChanged?.call(v);
                              }),
                  );
                });
          },
        );

  final double min;
  final double max;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final ValueChanged<double>? onChanged;
  final Color? activeColor;
  final Color thumbColor;
  final int? divisions;

  @override
  FormeFieldState<double> createState() => _FormeCupertinoSliderState();
}

class _FormeCupertinoSliderState extends FormeFieldState<double> {
  @override
  FormeCupertinoSlider get widget => super.widget as FormeCupertinoSlider;

  late final ValueNotifier<double?> notifier;

  void updateValue(double value) {
    notifier.value = value;
  }

  @override
  void initStatus() {
    super.initStatus();
    notifier = FormeMountedValueNotifier(null);
  }

  @override
  double get initialValue {
    final double defaultInitialValue = widget.initialValue;
    if (defaultInitialValue < widget.min) {
      return widget.min;
    }
    if (defaultInitialValue > widget.max) {
      return widget.max;
    }
    return defaultInitialValue;
  }

  @override
  double get value => notifier.value ?? super.value;

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  void onStatusChanged(FormeFieldChangedStatus<double> status) {
    super.onStatusChanged(status);
    if (status.isValueChanged) {
      notifier.value = null;
    }
  }
}
