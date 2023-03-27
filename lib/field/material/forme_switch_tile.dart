import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

class FormeSwitchTile extends FormeField<bool> {
  FormeSwitchTile({
    super.key,
    super.name,
    super.initialValue = false,
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
    this.tristate = false,
    this.activeColor,
    this.activeThumbImage,
    this.activeTrackColor,
    this.autofocus = false,
    this.contentPadding,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.dense = false,
    this.enableFeedback,
    this.hoverColor,
    this.inactiveThumbColor,
    this.inactiveThumbImage,
    this.inactiveTrackColor,
    this.isThreeLine = false,
    this.secondary,
    this.selected = false,
    this.selectedTileColor,
    this.shape,
    this.subtitle,
    this.tileColor,
    this.title,
    this.visualDensity,
  }) : super.allFields(
          builder: (state) {
            final bool readOnly = state.readOnly;
            final bool value = state.value;
            return SwitchListTile(
              visualDensity: visualDensity,
              enableFeedback: enableFeedback,
              hoverColor: hoverColor,
              focusNode: state.focusNode,
              selected: selected,
              value: value,
              activeColor: activeColor,
              activeTrackColor: activeTrackColor,
              inactiveThumbColor: inactiveThumbColor,
              inactiveTrackColor: inactiveTrackColor,
              activeThumbImage: activeThumbImage,
              inactiveThumbImage: inactiveThumbImage,
              tileColor: tileColor,
              title: title,
              subtitle: subtitle,
              isThreeLine: isThreeLine,
              dense: dense,
              secondary: secondary,
              controlAffinity: controlAffinity,
              autofocus: autofocus,
              contentPadding: contentPadding,
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
  final Color? activeColor;
  final Color? tileColor;
  final Color? selectedTileColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final ImageProvider<Object>? activeThumbImage;
  final ImageProvider<Object>? inactiveThumbImage;
  final ShapeBorder? shape;
  final bool autofocus;
  final Widget? title;
  final Widget? subtitle;
  final bool isThreeLine;
  final bool dense;
  final Widget? secondary;
  final ListTileControlAffinity controlAffinity;
  final EdgeInsets? contentPadding;
  final bool selected;
  final Color? hoverColor;
  final bool? enableFeedback;
  final VisualDensity? visualDensity;
}
