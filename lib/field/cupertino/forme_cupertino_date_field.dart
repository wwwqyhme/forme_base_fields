import 'package:flutter/cupertino.dart';
import '../forme_datetime_type.dart';
import 'base_picker.dart';

class FormeCupertinoDateField
    extends FormeCupertinoBasePicker<DateTime?, FormeCupertinoDateFieldState> {
  FormeCupertinoDateField({
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
    required super.triggerBuilder,
    super.anchorPoint,
    super.barrierColor,
    super.barrierDismissible,
    super.filter,
    super.height = 216,
    super.routeSettings,
    super.semanticsDismissible,
    super.useRootNavigator,
    super.cancelWidget,
    super.confirmWidget,
    this.dateOrder,
    this.maximumDate,
    this.maximumYear,
    this.minimumDate,
    this.minimumYear,
    this.type = FormeDateTimeType.date,
    this.use24hFormat,
    this.minuteInterval = 1,
    this.backgroundColor,
  });

  @override
  FormeCupertinoDateFieldState createState() => FormeCupertinoDateFieldState();
  final int minuteInterval;
  final FormeDateTimeType type;
  final Color? backgroundColor;
  final int? maximumYear;
  final int? minimumYear;
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  final bool? use24hFormat;
  final DatePickerDateOrder? dateOrder;
}

class FormeCupertinoDateFieldState
    extends FormeCupertinoBasePickerState<DateTime?> {
  DateTime? _time;

  @override
  FormeCupertinoDateField get widget => super.widget as FormeCupertinoDateField;

  CupertinoDatePickerMode get _mode => widget.type == FormeDateTimeType.date
      ? CupertinoDatePickerMode.date
      : CupertinoDatePickerMode.dateAndTime;

  @override
  void onConfirmed() {
    if (_time != null) {
      didChange(_time);
      requestFocusOnUserInteraction();
    }
  }

  @override
  Widget createPickWidget() {
    _time = null;
    return CupertinoDatePicker(
        mode: _mode,
        maximumDate: widget.maximumDate,
        maximumYear: widget.maximumYear,
        minimumDate: widget.minimumDate,
        minimumYear: widget.minimumYear ?? 1,
        minuteInterval: widget.minuteInterval,
        use24hFormat: widget.use24hFormat ?? false,
        dateOrder: widget.dateOrder,
        backgroundColor: widget.backgroundColor,
        initialDateTime: value,
        onDateTimeChanged: (time) {
          _time = time;
        });
  }

  @override
  DateTime? get value {
    final DateTime? value = super.value;
    if (value == null) {
      return null;
    }
    return _simple(value);
  }

  DateTime _simple(DateTime dateTime) {
    switch (widget.type) {
      case FormeDateTimeType.date:
        return DateTime(dateTime.year, dateTime.month, dateTime.day);
      case FormeDateTimeType.dateTime:
        return DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour, dateTime.minute);
    }
  }
}
