import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forme/forme.dart';

class FormeNumberField extends FormeField<double?> {
  FormeNumberField({
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
    this.allowNegative = false,
    this.decimal = 0,
    this.max,
    this.decoration = const InputDecoration(),
    this.maxLines = 1,
    this.keyboardType = TextInputType.number,
    this.autofocus = false,
    this.minLines,
    this.maxLength,
    this.style,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.expands = false,
    this.maxLengthEnforcement,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20),
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.scrollPhysics,
    this.autofillHints,
    this.enableInteractiveSelection = true,
    this.onEditingComplete,
    this.inputFormatters,
    this.appPrivateCommandCallback,
    this.buildCounter,
    this.onTap,
    this.onSubmitted,
    this.scrollController,
    this.textSelectionControls,
    this.enableIMEPersonalizedLearning = true,
    this.onTapOutside,
    this.clipBehavior,
    this.scribbleEnabled,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
  }) : super.allFields(
          builder: (baseState) {
            final bool readOnly = baseState.readOnly;
            final bool enabled = baseState.enabled;
            final _FormeNumberFieldState state =
                baseState as _FormeNumberFieldState;
            final List<TextInputFormatter> formatters = numberFormatters(
                decimal: decimal, allowNegative: allowNegative, max: max);
            if (inputFormatters != null) {
              formatters.addAll(inputFormatters);
            }

            void onChanged(String value) {
              final double? parsed = double.tryParse(value);
              if (parsed != null && parsed != state.value) {
                state.updateController = false;
                state.didChange(parsed);
              } else {
                if (value.isEmpty && state.value != null) {
                  state.didChange(null);
                }
              }
            }

            return TextField(
              onChanged: onChanged,
              onTapOutside: onTapOutside,
              clipBehavior: clipBehavior ?? Clip.hardEdge,
              scribbleEnabled: scribbleEnabled ?? true,
              contextMenuBuilder: contextMenuBuilder,
              spellCheckConfiguration: spellCheckConfiguration,
              magnifierConfiguration: magnifierConfiguration ??
                  TextMagnifier.adaptiveMagnifierConfiguration,
              enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
              focusNode: state.focusNode,
              controller: state.textEditingController,
              decoration: decoration?.copyWith(errorText: state.errorText),
              obscureText: obscureText,
              maxLines: maxLines,
              minLines: minLines,
              enabled: enabled,
              readOnly: readOnly,
              onTap: onTap,
              onEditingComplete: onEditingComplete,
              onSubmitted: onSubmitted,
              onAppPrivateCommand: appPrivateCommandCallback,
              textInputAction: textInputAction,
              textCapitalization: textCapitalization,
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              textDirection: textDirection,
              showCursor: showCursor,
              obscuringCharacter: obscuringCharacter,
              autocorrect: autocorrect,
              smartDashesType: smartDashesType,
              smartQuotesType: smartQuotesType,
              enableSuggestions: enableSuggestions,
              expands: expands,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              selectionHeightStyle: selectionHeightStyle,
              selectionWidthStyle: selectionWidthStyle,
              keyboardAppearance: keyboardAppearance,
              scrollPadding: scrollPadding,
              dragStartBehavior: dragStartBehavior,
              mouseCursor: mouseCursor,
              scrollPhysics: scrollPhysics,
              autofillHints: readOnly ? null : autofillHints,
              autofocus: autofocus,
              enableInteractiveSelection: enableInteractiveSelection,
              buildCounter: buildCounter,
              maxLengthEnforcement: maxLengthEnforcement,
              inputFormatters: formatters,
              keyboardType: keyboardType,
              maxLength: maxLength,
              scrollController: scrollController,
              selectionControls: textSelectionControls,
            );
          },
        );

  final int decimal;
  final bool allowNegative;
  final double? max;
  final InputDecoration? decoration;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool autofocus;
  final int? minLines;
  final int? maxLength;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final bool expands;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final MouseCursor? mouseCursor;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final bool enableInteractiveSelection;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final AppPrivateCommandCallback? appPrivateCommandCallback;
  final InputCounterWidgetBuilder? buildCounter;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final ScrollController? scrollController;
  final TextSelectionControls? textSelectionControls;
  final bool enableIMEPersonalizedLearning;
  final TapRegionCallback? onTapOutside;
  final Clip? clipBehavior;
  final bool? scribbleEnabled;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;

  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  FormeFieldState<double?> createState() => _FormeNumberFieldState();

  static List<TextInputFormatter> numberFormatters(
      {required int decimal,
      required bool allowNegative,
      required double? max}) {
    final RegExp regex =
        RegExp('[0-9${decimal > 0 ? '.' : ''}${allowNegative ? '-' : ''}]');
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        if (newValue.text == '') {
          return newValue;
        }
        if (allowNegative && newValue.text == '-') {
          return newValue;
        }
        final double? parsed = double.tryParse(newValue.text);
        if (parsed == null) {
          return oldValue;
        }
        final int indexOfPoint = newValue.text.indexOf('.');
        if (indexOfPoint != -1) {
          final int decimalNum = newValue.text.length - (indexOfPoint + 1);
          if (decimalNum > decimal) {
            return oldValue;
          }
        }

        final double? oldParsed = double.tryParse(oldValue.text);

        if (max != null && parsed > max) {
          if (oldParsed != null && oldParsed > parsed) {
            return newValue;
          }
          return oldValue;
        }
        return newValue;
      }),
      FilteringTextInputFormatter.allow(regex)
    ];
  }
}

class _FormeNumberFieldState extends FormeFieldState<double?> {
  late final TextEditingController textEditingController;

  @override
  FormeNumberField get widget => super.widget as FormeNumberField;

  bool updateController = true;

  @override
  double? get value {
    if (super.value == null) {
      return null;
    }
    return double.parse(super.value!.toStringAsFixed(widget.decimal));
  }

  @override
  void initStatus() {
    super.initStatus();
    textEditingController = TextEditingController(
        text: initialValue == null ? '' : initialValue.toString());
  }

  @override
  void onStatusChanged(FormeFieldChangedStatus<double?> status) {
    super.onStatusChanged(status);
    if (status.isValueChanged) {
      if (updateController) {
        final String str = status.value == null ? '' : status.value.toString();
        if (textEditingController.text != str) {
          textEditingController.text = str;
        }
      } else {
        updateController = true;
      }
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
