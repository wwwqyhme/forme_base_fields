import 'package:flutter/material.dart';

import 'package:forme/forme.dart';

class FormeCheckbox extends FormeField<bool?> {
  FormeCheckbox({
    super.key,
    super.name,
    bool? initialValue = false,
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
    this.tristate = false,
    this.activeColor,
    this.autofocus = false,
    this.checkColor,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.materialTapTargetSize,
    this.mouseCursor,
    this.overlayColor,
    this.shape,
    this.side,
    this.splashRadius,
    this.visualDensity,
  }) : super.allFields(
          initialValue: tristate ? initialValue : initialValue ?? false,
          builder: (state) {
            final bool readOnly = state.readOnly;
            final bool? value = state.value;
            return Checkbox(
              autofocus: autofocus,
              focusNode: state.focusNode,
              side: side,
              tristate: tristate,
              mouseCursor: mouseCursor,
              shape: shape,
              activeColor: activeColor,
              fillColor: fillColor,
              checkColor: checkColor,
              materialTapTargetSize: materialTapTargetSize,
              focusColor: focusColor,
              hoverColor: hoverColor,
              overlayColor: overlayColor,
              splashRadius: splashRadius,
              visualDensity: visualDensity,
              value: value,
              isError: state.errorText != null,
              onChanged: readOnly
                  ? null
                  : (value) {
                      state.didChange(value);
                      state.requestFocusOnUserInteraction();
                    },
            );
          },
        );

  final bool tristate;
  final Color? activeColor;
  final MouseCursor? mouseCursor;
  final MaterialStateProperty<Color?>? fillColor;
  final Color? checkColor;
  final Color? focusColor;
  final Color? hoverColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final VisualDensity? visualDensity;
  final MaterialTapTargetSize? materialTapTargetSize;
  final OutlinedBorder? shape;
  final bool autofocus;
  final BorderSide? side;

  @override
  FormeFieldState<bool?> createState() => _FormeCheckboxState();
}

class _FormeCheckboxState extends FormeFieldState<bool?> {
  @override
  FormeCheckbox get widget => super.widget as FormeCheckbox;

  @override
  void didChange(bool? newValue) {
    if (newValue == null && !widget.tristate) {
      throw Exception(
          'current value can not be null, set tristate to true if you want to support nullable');
    }
    super.didChange(newValue);
  }
}
