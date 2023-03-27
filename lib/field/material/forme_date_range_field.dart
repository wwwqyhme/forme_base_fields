import 'package:flutter/material.dart';

import 'package:forme/forme.dart';

typedef FormeDateRangeTriggerBuilder = Widget Function(
    FormeDateRangeFieldState state);

/// example
///
/// ``` dart
///  FormeDateRangeField(
///     validator:
///          FormeValidates.notNull(errorText: 'range date required'),
///      triggerBuilder: (state) {
///        return InkWell(
///          focusNode: state.focusNode,
///          onTap: state.showPicker,
///         child: InputDecorator(
///           isFocused: state.hasFocus,
///           isEmpty: state.value == null,
///           decoration: InputDecoration(
///               errorText: state.errorText,
///               labelText: 'DateRange Picker'),
///           child: Text(state.value?.toString() ?? ''),
///         ),
///       );
///     },
///     name: 'dateRange',
///  )
///
class FormeDateRangeField extends FormeField<DateTimeRange?> {
  FormeDateRangeField({
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
    this.cancelText,
    this.confirmText,
    this.errorFormatText,
    this.errorInvalidText,
    this.helpText,
    this.initialEntryMode,
    this.routeSettings,
    this.use24hFormat = false,
    this.textDirection,
    this.locale,
    this.useRootNavigator = true,
    this.anchorPoint,
    this.errorInvalidRangeText,
    this.fieldEndHintText,
    this.fieldEndLabelText,
    this.fieldStartHintText,
    this.fieldStartLabelText,
    this.saveText,
    this.transitionBuilder,
    this.firstDate,
    this.lastDate,
    required this.triggerBuilder,
  }) : super.allFields(
          builder: (baseState) {
            return triggerBuilder.call(baseState as FormeDateRangeFieldState);
          },
        );

  final DateTime? firstDate;
  final DateTime? lastDate;
  final FormeDateRangeTriggerBuilder triggerBuilder;
  final String? helpText;
  final String? cancelText;
  final String? confirmText;
  final RouteSettings? routeSettings;
  final String? errorFormatText;
  final String? errorInvalidText;
  final DatePickerEntryMode? initialEntryMode;
  final TransitionBuilder? transitionBuilder;
  final bool use24hFormat;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool useRootNavigator;
  final Offset? anchorPoint;
  final String? errorInvalidRangeText;
  final String? saveText;
  final String? fieldStartHintText;
  final String? fieldEndHintText;
  final String? fieldStartLabelText;
  final String? fieldEndLabelText;

  static Widget defaultTriggerBuilder(
    FormeDateRangeFieldState state, {
    InputDecoration? decoration,
    String Function(DateTimeRange? time)? formatter,
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
              : FormeFieldStatusListener<DateTimeRange?>(
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

  @override
  FormeDateRangeFieldState createState() => FormeDateRangeFieldState();
}

class FormeDateRangeFieldState extends FormeFieldState<DateTimeRange?> {
  @override
  FormeDateRangeField get widget => super.widget as FormeDateRangeField;

  VoidCallback? get showPicker => readOnly ? null : _pickRange;

  @override
  DateTimeRange? get value {
    final DateTimeRange? value = super.value;
    if (value == null) {
      return null;
    }
    return DateTimeRange(start: _simple(value.start), end: _simple(value.end));
  }

  void _pickRange() {
    showDateRangePicker(
      useRootNavigator: widget.useRootNavigator,
      anchorPoint: widget.anchorPoint,
      locale: widget.locale,
      initialDateRange: value,
      context: context,
      firstDate: widget.firstDate ?? DateTime(1970),
      lastDate: widget.lastDate ?? DateTime(2099),
      builder: widget.transitionBuilder,
      initialEntryMode: widget.initialEntryMode ?? DatePickerEntryMode.calendar,
      helpText: widget.helpText,
      cancelText: widget.cancelText,
      confirmText: widget.confirmText,
      saveText: widget.saveText,
      errorFormatText: widget.errorFormatText,
      errorInvalidText: widget.errorInvalidText,
      errorInvalidRangeText: widget.errorInvalidRangeText,
      fieldStartHintText: widget.fieldStartHintText,
      fieldEndHintText: widget.fieldEndHintText,
      fieldStartLabelText: widget.fieldStartLabelText,
      fieldEndLabelText: widget.fieldEndLabelText,
      routeSettings: widget.routeSettings,
      textDirection: widget.textDirection,
    ).then((value) {
      if (value != null) {
        didChange(value);
      }
      requestFocusOnUserInteraction();
    });
  }

  DateTime _simple(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
}
