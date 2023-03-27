import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

class FormeCheckboxTile extends FormeField<bool?> {
  FormeCheckboxTile({
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
    this.checkBoxShape,
    this.checkColor,
    this.contentPadding,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.dense = false,
    this.enableFeedback,
    this.isThreeLine = false,
    this.secondary,
    this.selected = false,
    this.selectedTileColor,
    this.shape,
    this.side,
    this.subtitle,
    this.tileColor,
    this.title,
    this.visualDensity,
  }) : super.allFields(
          initialValue: tristate ? initialValue : initialValue ?? false,
          builder: (state) {
            final bool readOnly = state.readOnly;
            final bool? value = state.value;
            return CheckboxListTile(
              enableFeedback: enableFeedback,
              focusNode: state.focusNode,
              visualDensity: visualDensity,
              side: side,
              checkboxShape: checkBoxShape,
              enabled: state.enabled,
              selected: selected,
              value: value,
              activeColor: activeColor,
              checkColor: checkColor,
              tileColor: tileColor,
              title: title,
              subtitle: subtitle,
              isThreeLine: isThreeLine,
              dense: dense,
              secondary: secondary,
              controlAffinity: controlAffinity,
              autofocus: autofocus,
              contentPadding: contentPadding,
              tristate: tristate,
              shape: shape,
              selectedTileColor: selectedTileColor,
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
  final Widget? title;
  final Widget? subtitle;
  final bool isThreeLine;
  final bool dense;
  final Widget? secondary;
  final ListTileControlAffinity controlAffinity;
  final EdgeInsets? contentPadding;
  final bool selected;
  final OutlinedBorder? checkBoxShape;
  final BorderSide? side;
  final VisualDensity? visualDensity;
  final bool? enableFeedback;
  final Color? activeColor;
  final Color? checkColor;
  final Color? tileColor;
  final Color? selectedTileColor;
  final OutlinedBorder? shape;
  final bool autofocus;
  @override
  FormeFieldState<bool?> createState() => _FormeCheckboxTileState();
}

class _FormeCheckboxTileState extends FormeFieldState<bool?> {
  @override
  FormeCheckboxTile get widget => super.widget as FormeCheckboxTile;

  @override
  void didChange(bool? newValue) {
    if (newValue == null && !widget.tristate) {
      throw Exception(
          'current value can not be null, set tristate to true if you want to support nullable');
    }
    super.didChange(newValue);
  }
}
