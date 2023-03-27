import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:forme/forme.dart';

class FormeSwitch extends FormeField<bool> {
  FormeSwitch({
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
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.thumbColor,
    this.trackColor,
    this.dragStartBehavior,
    this.materialTapTargetSize,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.onActiveThumbImageError,
    this.onInactiveThumbImageError,
    this.autofocus = false,
    this.thumbIcon,
    this.mouseCursor,
  }) : super.allFields(
          builder: (state) {
            final bool readOnly = state.readOnly;
            final bool value = state.value;
            return Switch(
              mouseCursor: mouseCursor,
              thumbIcon: thumbIcon,
              value: value,
              onChanged: readOnly
                  ? null
                  : (_) {
                      state.didChange(!value);
                      state.requestFocusOnUserInteraction();
                    },
              activeColor: activeColor,
              activeTrackColor: activeTrackColor,
              inactiveThumbColor: inactiveThumbColor,
              inactiveTrackColor: inactiveTrackColor,
              activeThumbImage: activeThumbImage,
              inactiveThumbImage: inactiveThumbImage,
              materialTapTargetSize: materialTapTargetSize,
              thumbColor: thumbColor,
              trackColor: trackColor,
              dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
              focusColor: focusColor,
              hoverColor: hoverColor,
              overlayColor: overlayColor,
              splashRadius: splashRadius,
              onActiveThumbImageError: onActiveThumbImageError,
              onInactiveThumbImageError: onInactiveThumbImageError,
              focusNode: state.focusNode,
              autofocus: autofocus,
            );
          },
        );

  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final ImageProvider? activeThumbImage;
  final ImageProvider? inactiveThumbImage;
  final MaterialStateProperty<Color?>? thumbColor;
  final MaterialStateProperty<Color?>? trackColor;
  final DragStartBehavior? dragStartBehavior;
  final MaterialTapTargetSize? materialTapTargetSize;
  final Color? focusColor;
  final Color? hoverColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final ImageErrorListener? onActiveThumbImageError;
  final ImageErrorListener? onInactiveThumbImageError;
  final bool autofocus;
  final MaterialStateProperty<Icon?>? thumbIcon;
  final MouseCursor? mouseCursor;
}
