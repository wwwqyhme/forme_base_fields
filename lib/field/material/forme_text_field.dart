import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forme/forme.dart';

class FormeTextField extends FormeField<String> {
  FormeTextField({
    super.key,
    super.name,
    super.initialValue = '',
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
    this.updateValueWhenComposing = false,
    this.selectAllOnFocus = false,
    this.decoration = const InputDecoration(),
    this.maxLines = 1,
    this.keyboardType,
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
            final FormeTextFieldState state = baseState as FormeTextFieldState;
            return TextField(
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
              maxLengthEnforcement: updateValueWhenComposing
                  ? maxLengthEnforcement
                  : MaxLengthEnforcement.truncateAfterCompositionEnds,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              maxLength: maxLength,
              scrollController: scrollController,
              selectionControls: textSelectionControls,
            );
          },
        );

  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  final bool selectAllOnFocus;

  /// whether update value when text input is composing
  ///
  /// **on web this will not worked**
  /// https://github.com/flutter/flutter/issues/65357
  ///
  ///
  /// default is false
  final bool updateValueWhenComposing;
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

  @override
  FormeTextFieldState createState() => FormeTextFieldState();
}

class FormeTextFieldState extends FormeFieldState<String> {
  late final TextEditingController textEditingController;

  @override
  FormeTextField get widget => super.widget as FormeTextField;

  @override
  void initStatus() {
    super.initStatus();
    textEditingController = TextEditingController(text: initialValue);
    textEditingController.addListener(_handleControllerChanged);
  }

  @override
  void onStatusChanged(FormeFieldChangedStatus<String> status) {
    super.onStatusChanged(status);
    if (status.isValueChanged) {
      if (textEditingController.text != status.value) {
        textEditingController.text = status.value;
      }
    }
    if (status.isFocusChanged) {
      if (status.hasFocus && widget.selectAllOnFocus) {
        textEditingController.selection =
            _selection(0, textEditingController.text.length);
      }
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void _handleControllerChanged() {
    if (textEditingController.text != value &&
        (widget.updateValueWhenComposing ||
            !textEditingController.value.isComposingRangeValid)) {
      didChange(textEditingController.text);
    }
  }

  TextSelection _selection(int start, int end) {
    final int extendsOffset = end;
    final int baseOffset = start < 0
        ? 0
        : start > extendsOffset
            ? extendsOffset
            : start;
    return TextSelection(baseOffset: baseOffset, extentOffset: extendsOffset);
  }
}
