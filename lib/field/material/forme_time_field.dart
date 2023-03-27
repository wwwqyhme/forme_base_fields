import 'package:flutter/material.dart';

import 'package:forme/forme.dart';

typedef FormeTimeTriggerBuilder = Widget Function(FormeTimeFieldState state);

/// example
///
/// ``` dart
/// FormeTimeField(
///      validator: FormeValidates.notNull(errorText: 'required'),
///      triggerBuilder: (state) {
///        return InkWell(
///          focusNode: state.focusNode,
///          onTap: state.showPicker,
///          child: InputDecorator(
///            isFocused: state.hasFocus,
///            isEmpty: state.value == null,
///            decoration: InputDecoration(
///                errorText: state.errorText,
///                labelText: 'Time Picker'),
///            child: Text(state.value?.toString() ?? ''),
///          ),
///        );
///      },
///      name: 'time',
///    )
/// ```
class FormeTimeField extends FormeField<TimeOfDay?> {
  FormeTimeField({
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
    required this.triggerBuilder,
    this.anchorPoint,
    this.cancelText,
    this.confirmText,
    this.errorInvalidText,
    this.helpText,
    this.hourLabelText,
    this.initialEntryMode,
    this.minuteLabelText,
    this.onEntryModeChanged,
    this.routeSettings,
    this.transitionBuilder,
    this.useRootNavigator = true,
  }) : super.allFields(
          builder: (baseState) {
            return triggerBuilder.call(baseState as FormeTimeFieldState);
          },
        );

  @override
  FormeTimeFieldState createState() => FormeTimeFieldState();

  final TransitionBuilder? transitionBuilder;
  final RouteSettings? routeSettings;
  final TimePickerEntryMode? initialEntryMode;
  final String? cancelText;
  final String? confirmText;
  final String? helpText;
  final bool useRootNavigator;
  final String? errorInvalidText;
  final String? hourLabelText;
  final String? minuteLabelText;
  final EntryModeChangeCallback? onEntryModeChanged;
  final Offset? anchorPoint;
  final FormeTimeTriggerBuilder triggerBuilder;

  static Widget defaultTriggerBuilder(
    FormeTimeFieldState state, {
    InputDecoration? decoration,
    String Function(TimeOfDay? time)? formatter,
    bool clearButton = true,
  }) {
    return InkWell(
      focusNode: state.focusNode,
      onTap: state.showPicker,
      child: InputDecorator(
        isFocused: state.hasFocus,
        isEmpty: state.value == null,
        decoration: (decoration ?? const InputDecoration()).copyWith(
          errorText: state.errorText,
          suffixIconConstraints:
              !clearButton ? null : const BoxConstraints.tightFor(),
          suffixIcon: !clearButton
              ? null
              : FormeFieldStatusListener<TimeOfDay?>(
                  builder: (context, status, child) {
                    if (status != null && status.value != null) {
                      return IconButton(
                        onPressed: () {
                          FormeField.of(context)!.value = null;
                        },
                        icon: const Icon(Icons.clear),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
        ),
        child: Text(formatter?.call(state.value) ?? '${state.value ?? ''}'),
      ),
    );
  }
}

class FormeTimeFieldState extends FormeFieldState<TimeOfDay?> {
  @override
  FormeTimeField get widget => super.widget as FormeTimeField;

  VoidCallback? get showPicker => readOnly ? null : _pickTime;

  void _pickTime() {
    showTimePicker(
      context: context,
      initialTime: value ?? TimeOfDay.now(),
      builder: widget.transitionBuilder,
      routeSettings: widget.routeSettings,
      initialEntryMode: widget.initialEntryMode ?? TimePickerEntryMode.dial,
      cancelText: widget.cancelText,
      confirmText: widget.confirmText,
      helpText: widget.helpText,
      useRootNavigator: widget.useRootNavigator,
      errorInvalidText: widget.errorInvalidText,
      hourLabelText: widget.hourLabelText,
      minuteLabelText: widget.minuteLabelText,
      onEntryModeChanged: widget.onEntryModeChanged,
      anchorPoint: widget.anchorPoint,
    ).then((value) {
      if (value != null) {
        didChange(value);
        requestFocusOnUserInteraction();
      }
    });
  }
}
