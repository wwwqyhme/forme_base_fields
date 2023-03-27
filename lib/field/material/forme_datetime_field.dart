import 'package:flutter/material.dart';

import 'package:forme/forme.dart';

import '../forme_datetime_type.dart';

typedef FormeDateTimeTriggerBuilder = Widget Function(
    FormeDateTimeFieldState state);

/// ``` dart
///
///example :
///
///FormeDateTimeField(
///      type: FormeDateTimeType.dateTime,
///      validator: (field, value) {
///        if (value == null) {
///          return 'datetime required';
///        }
///        return null;
///      },
///      triggerBuilder: (state) {
///        return InkWell(
///          focusNode: state.focusNode,
///         onTap: state.showDateTimePicker,
///         child: InputDecorator(
///           isFocused: state.hasFocus,
///            isEmpty: state.value == null,
///            decoration: InputDecoration(
///                errorText: state.errorText,
///                labelText: 'Date Time Picker'),
///            child: Text(state.formattedValue ?? ''),
///          ),
///        );
///      },
///      name: 'datetime',
///    ),
/// ```
///
///
class FormeDateTimeField extends FormeField<DateTime?> {
  FormeDateTimeField({
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
    this.dateInitialEntryMode,
    this.errorFormatText,
    this.errorInvalidText,
    this.fieldHintText,
    this.fieldLabelText,
    this.helpText,
    this.initialDatePickerMode,
    this.initialEntryMode,
    this.routeSettings,
    this.selectableDayPredicate,
    this.timeCancelText,
    this.timeConfirmText,
    this.timeHelpText,
    this.timeRouteSettings,
    this.dateTransitionBuilder,
    this.use24hFormat = false,
    this.timeTransitionBuilder,
    this.textDirection,
    this.locale,
    this.useRootNavigator = true,
    this.anchorPoint,
    this.keyboardType,
    this.hourLabelText,
    this.minuteLabelText,
    this.onEntryModeChanged,
    this.timeAnchorPoint,
    this.timeErrorInvalidText,
    this.type = FormeDateTimeType.date,
    this.firstDate,
    this.lastDate,
    required this.triggerBuilder,
  }) : super.allFields(
          builder: (baseState) {
            return triggerBuilder.call(baseState as FormeDateTimeFieldState);
          },
        );

  @override
  FormeDateTimeFieldState createState() => FormeDateTimeFieldState();

  final FormeDateTimeType type;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? helpText;
  final String? cancelText;
  final String? confirmText;
  final RouteSettings? routeSettings;
  final DatePickerMode? initialDatePickerMode;
  final String? errorFormatText;
  final String? errorInvalidText;
  final String? fieldHintText;
  final String? fieldLabelText;
  final TimePickerEntryMode? initialEntryMode;
  final DatePickerEntryMode? dateInitialEntryMode;
  final String? timeCancelText;
  final String? timeConfirmText;
  final String? timeHelpText;
  final RouteSettings? timeRouteSettings;
  final SelectableDayPredicate? selectableDayPredicate;
  final TransitionBuilder? dateTransitionBuilder;
  final bool use24hFormat;
  final TransitionBuilder? timeTransitionBuilder;
  final TextDirection? textDirection;
  final FormeDateTimeTriggerBuilder triggerBuilder;
  final Locale? locale;
  final bool useRootNavigator;
  final Offset? anchorPoint;
  final TextInputType? keyboardType;
  final EntryModeChangeCallback? onEntryModeChanged;
  final String? hourLabelText;
  final String? minuteLabelText;
  final String? timeErrorInvalidText;
  final Offset? timeAnchorPoint;
}

class FormeDateTimeFieldState extends FormeFieldState<DateTime?> {
  @override
  FormeDateTimeField get widget => super.widget as FormeDateTimeField;

  VoidCallback? get showPicker => readOnly ? null : _pickTime;

  void _pickTime() {
    final value = _initialDateTime;
    final timeOfDay = this.value == null
        ? null
        : TimeOfDay(hour: value.hour, minute: value.minute);

    showDatePicker(
      useRootNavigator: widget.useRootNavigator,
      context: context,
      initialDate: value,
      firstDate: widget.firstDate ?? DateTime(1970),
      lastDate: widget.lastDate ?? DateTime(2099),
      helpText: widget.helpText,
      cancelText: widget.cancelText,
      confirmText: widget.confirmText,
      routeSettings: widget.routeSettings,
      textDirection: widget.textDirection,
      initialDatePickerMode: widget.initialDatePickerMode ?? DatePickerMode.day,
      errorFormatText: widget.errorFormatText,
      errorInvalidText: widget.errorInvalidText,
      fieldHintText: widget.fieldHintText,
      fieldLabelText: widget.fieldLabelText,
      initialEntryMode:
          widget.dateInitialEntryMode ?? DatePickerEntryMode.calendar,
      selectableDayPredicate: widget.selectableDayPredicate,
      builder: widget.dateTransitionBuilder,
      locale: widget.locale,
      anchorPoint: widget.anchorPoint,
      keyboardType: widget.keyboardType,
    ).then((date) {
      if (date != null) {
        if (widget.type == FormeDateTimeType.dateTime) {
          showTimePicker(
                  onEntryModeChanged: widget.onEntryModeChanged,
                  hourLabelText: widget.hourLabelText,
                  minuteLabelText: widget.minuteLabelText,
                  errorInvalidText: widget.timeErrorInvalidText,
                  anchorPoint: widget.timeAnchorPoint,
                  useRootNavigator: widget.useRootNavigator,
                  initialEntryMode:
                      widget.initialEntryMode ?? TimePickerEntryMode.dial,
                  cancelText: widget.timeCancelText,
                  confirmText: widget.timeConfirmText,
                  helpText: widget.timeHelpText,
                  routeSettings: widget.timeRouteSettings,
                  context: context,
                  initialTime: timeOfDay ??
                      TimeOfDay(hour: value.hour, minute: value.minute),
                  builder: widget.timeTransitionBuilder ??
                      (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                              alwaysUse24HourFormat: widget.use24hFormat),
                          child: child!,
                        );
                      })
              .then((value) {
            if (value != null) {
              final dateTime = DateTime(
                  date.year, date.month, date.day, value.hour, value.minute);
              didChange(dateTime);
              requestFocusOnUserInteraction();
            }
          });
        } else {
          didChange(date);
          requestFocusOnUserInteraction();
        }
      }
    });
  }

  @override
  DateTime? get value {
    final value = super.value;
    if (value == null) {
      return null;
    }
    return _simple(value);
  }

  DateTime get _initialDateTime {
    if (value != null) {
      return value!;
    }
    final DateTime now = DateTime.now();
    DateTime date =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
    if (widget.lastDate != null && widget.lastDate!.isBefore(date)) {
      date = widget.lastDate!;
    }
    if (widget.firstDate != null && widget.firstDate!.isAfter(date)) {
      date = widget.firstDate!;
    }
    switch (widget.type) {
      case FormeDateTimeType.date:
        return DateTime(date.year, date.month, date.day);
      case FormeDateTimeType.dateTime:
        return date;
    }
  }

  DateTime _simple(DateTime time) {
    switch (widget.type) {
      case FormeDateTimeType.date:
        return DateTime(time.year, time.month, time.day);
      case FormeDateTimeType.dateTime:
        return DateTime(
            time.year, time.month, time.day, time.hour, time.minute);
    }
  }
}
