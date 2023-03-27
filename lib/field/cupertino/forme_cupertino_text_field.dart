import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:forme/forme.dart';

// Value inspected from Xcode 11 & iOS 13.0 Simulator.
const BorderSide _kDefaultRoundedBorderSide = BorderSide(
  color: CupertinoDynamicColor.withBrightness(
    color: Color(0x33000000),
    darkColor: Color(0x33FFFFFF),
  ),
  width: 0.0,
);
const Border _kDefaultRoundedBorder = Border(
  top: _kDefaultRoundedBorderSide,
  bottom: _kDefaultRoundedBorderSide,
  left: _kDefaultRoundedBorderSide,
  right: _kDefaultRoundedBorderSide,
);

const BoxDecoration _kDefaultRoundedBorderDecoration = BoxDecoration(
  color: CupertinoDynamicColor.withBrightness(
    color: CupertinoColors.white,
    darkColor: CupertinoColors.black,
  ),
  border: _kDefaultRoundedBorder,
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
);

const TextStyle _kDefaultPlaceholderStyle = TextStyle(
  fontWeight: FontWeight.w400,
  color: CupertinoColors.placeholderText,
);

class FormeCupertinoTextField extends FormeField<String> {
  FormeCupertinoTextField({
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
    this.decoration = _kDefaultRoundedBorderDecoration,
    this.padding = const EdgeInsets.all(7.0),
    this.placeholder,
    this.placeholderStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      color: CupertinoColors.placeholderText,
    ),
    this.prefix,
    this.prefixMode = OverlayVisibilityMode.always,
    this.suffix,
    this.suffixMode = OverlayVisibilityMode.always,
    this.clearButtonMode = OverlayVisibilityMode.never,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius = const Radius.circular(2.0),
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollController,
    this.scrollPhysics,
    this.onTap,
    this.autofillHints,
    this.enableIMEPersonalizedLearning = true,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
    this.scribbleEnabled = true,
    this.onTapOutside,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.selectAllOnFocus = false,
    this.updateValueWhenComposing = false,
    this.maxLines = 1,
  }) : super.allFields(builder: (baseState) {
          final FormeCupertinoTextFieldState state =
              baseState as FormeCupertinoTextFieldState;

          return CupertinoTextField(
            controller: state.textEditingController,
            focusNode: state.focusNode,
            decoration: decoration,
            padding: padding,
            placeholder: placeholder,
            placeholderStyle: placeholderStyle,
            prefix: prefix,
            prefixMode: prefixMode,
            suffix: suffix,
            suffixMode: suffixMode,
            clearButtonMode: clearButtonMode,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            style: style,
            strutStyle: strutStyle,
            textAlign: textAlign,
            textAlignVertical: textAlignVertical,
            textDirection: textDirection,
            readOnly: state.readOnly,
            showCursor: showCursor,
            autofocus: autofocus,
            obscuringCharacter: obscuringCharacter,
            obscureText: obscureText,
            autocorrect: autocorrect,
            smartDashesType: smartDashesType,
            smartQuotesType: smartQuotesType,
            enableSuggestions: enableSuggestions,
            maxLines: maxLines,
            minLines: minLines,
            expands: expands,
            maxLength: maxLength,
            maxLengthEnforcement: updateValueWhenComposing
                ? maxLengthEnforcement
                : MaxLengthEnforcement.truncateAfterCompositionEnds,
            onEditingComplete: onEditingComplete,
            onSubmitted: onSubmitted,
            onTapOutside: onTapOutside,
            inputFormatters: inputFormatters,
            enabled: state.enabled,
            cursorWidth: cursorWidth,
            cursorHeight: cursorHeight,
            cursorRadius: cursorRadius,
            cursorColor: cursorColor,
            selectionHeightStyle: selectionHeightStyle,
            selectionWidthStyle: selectionWidthStyle,
            keyboardAppearance: keyboardAppearance,
            scrollPadding: scrollPadding,
            dragStartBehavior: dragStartBehavior,
            enableInteractiveSelection: enableInteractiveSelection,
            selectionControls: selectionControls,
            onTap: onTap,
            scrollController: scrollController,
            scrollPhysics: scrollPhysics,
            autofillHints: autofillHints,
            clipBehavior: clipBehavior,
            scribbleEnabled: scribbleEnabled,
            enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
            contextMenuBuilder: contextMenuBuilder,
            spellCheckConfiguration: spellCheckConfiguration,
            magnifierConfiguration: magnifierConfiguration,
          );
        });

  @override
  FormeCupertinoTextFieldState createState() => FormeCupertinoTextFieldState();

  FormeCupertinoTextField.borderless({
    bool selectAllOnFocus = false,
    String initialValue = '',
    String? name,
    bool readOnly = false,
    Key? key,
    int? maxLines = 1,
    int? order,
    BoxDecoration? decoration,
    EdgeInsetsGeometry padding = const EdgeInsets.all(7.0),
    String? placeholder,
    TextStyle placeholderStyle = _kDefaultPlaceholderStyle,
    Widget? prefix,
    OverlayVisibilityMode prefixMode = OverlayVisibilityMode.always,
    Widget? suffix,
    OverlayVisibilityMode suffixMode = OverlayVisibilityMode.always,
    OverlayVisibilityMode clearButtonMode = OverlayVisibilityMode.never,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool? showCursor,
    bool autofocus = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    int? minLines,
    bool expands = false,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius cursorRadius = const Radius.circular(2.0),
    Color? cursorColor,
    BoxHeightStyle selectionHeightStyle = BoxHeightStyle.tight,
    BoxWidthStyle selectionWidthStyle = BoxWidthStyle.tight,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollController? scrollController,
    ScrollPhysics? scrollPhysics,
    GestureTapCallback? onTap,
    Iterable<String>? autofillHints,
    bool quietlyValidate = false,
    Duration? asyncValidatorDebounce,
    AutovalidateMode? autovalidateMode,
    FormeFieldStatusChanged<String>? onStatusChanged,
    FormeFieldInitialized<String>? onInitialized,
    FormeFieldSetter<String>? onSaved,
    FormeValidator<String>? validator,
    FormeAsyncValidator<String>? asyncValidator,
    FormeFieldDecorator<String>? decorator,
    bool enableIMEPersonalizedLearning = true,
    bool updateValueWhenComposing = false,
    FormeFieldValidationFilter<String>? validationFilter,
    FocusNode? focusNode,
    TextDirection? textDirection,
    Clip clipBehavior = Clip.hardEdge,
    bool scribbleEnabled = true,
    TapRegionCallback? onTapOutside,
    EditableTextContextMenuBuilder? contextMenuBuilder =
        _defaultContextMenuBuilder,
    SpellCheckConfiguration? spellCheckConfiguration,
    TextMagnifierConfiguration? magnifierConfiguration,
    bool requestFocusOnUserInteraction = true,
  }) : this(
          asyncValidator: asyncValidator,
          asyncValidatorDebounce: asyncValidatorDebounce,
          autocorrect: autocorrect,
          autofillHints: autofillHints,
          autofocus: autofocus,
          autovalidateMode: autovalidateMode,
          clearButtonMode: clearButtonMode,
          clipBehavior: clipBehavior,
          contextMenuBuilder: contextMenuBuilder,
          cursorColor: cursorColor,
          cursorHeight: cursorHeight,
          cursorRadius: cursorRadius,
          cursorWidth: cursorWidth,
          decoration: decoration,
          decorator: decorator,
          dragStartBehavior: dragStartBehavior,
          enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
          enableInteractiveSelection: enableInteractiveSelection,
          enableSuggestions: enableSuggestions,
          enabled: enabled,
          expands: expands,
          focusNode: focusNode,
          initialValue: initialValue,
          inputFormatters: inputFormatters,
          key: key,
          keyboardAppearance: keyboardAppearance,
          keyboardType: keyboardType,
          magnifierConfiguration: magnifierConfiguration,
          maxLength: maxLength,
          maxLengthEnforcement: maxLengthEnforcement,
          maxLines: maxLines,
          minLines: minLines,
          name: name,
          obscureText: obscureText,
          obscuringCharacter: obscuringCharacter,
          onEditingComplete: onEditingComplete,
          onInitialized: onInitialized,
          onSaved: onSaved,
          onStatusChanged: onStatusChanged,
          onSubmitted: onSubmitted,
          onTap: onTap,
          onTapOutside: onTapOutside,
          order: order,
          padding: padding,
          placeholder: placeholder,
          placeholderStyle: placeholderStyle,
          prefix: prefix,
          prefixMode: prefixMode,
          quietlyValidate: quietlyValidate,
          readOnly: readOnly,
          requestFocusOnUserInteraction: requestFocusOnUserInteraction,
          scribbleEnabled: scribbleEnabled,
          scrollController: scrollController,
          scrollPadding: scrollPadding,
          scrollPhysics: scrollPhysics,
          selectAllOnFocus: selectAllOnFocus,
          selectionControls: selectionControls,
          selectionHeightStyle: selectionHeightStyle,
          selectionWidthStyle: selectionWidthStyle,
          spellCheckConfiguration: spellCheckConfiguration,
          showCursor: showCursor,
          smartDashesType: smartDashesType,
          smartQuotesType: smartQuotesType,
          strutStyle: strutStyle,
          style: style,
          suffix: suffix,
          suffixMode: suffixMode,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical,
          textCapitalization: textCapitalization,
          textDirection: textDirection,
          textInputAction: textInputAction,
          updateValueWhenComposing: updateValueWhenComposing,
          validationFilter: validationFilter,
          validator: validator,
        );

  /// whether update value when text input is composing
  ///
  /// **on web this will not worked**
  /// https://github.com/flutter/flutter/issues/65357
  ///
  ///
  /// default is false
  final bool updateValueWhenComposing;
  final bool selectAllOnFocus;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry padding;
  final String? placeholder;
  final TextStyle placeholderStyle;
  final Widget? prefix;
  final OverlayVisibilityMode prefixMode;
  final Widget? suffix;
  final OverlayVisibilityMode suffixMode;
  final OverlayVisibilityMode clearButtonMode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool? showCursor;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius cursorRadius;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final GestureTapCallback? onTap;
  final Iterable<String>? autofillHints;
  final bool enableIMEPersonalizedLearning;
  final TextDirection? textDirection;
  final Clip clipBehavior;
  final bool scribbleEnabled;
  final TapRegionCallback? onTapOutside;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final int? maxLines;

  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return CupertinoAdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }
}

class FormeCupertinoTextFieldState extends FormeFieldState<String> {
  late final TextEditingController textEditingController;

  @override
  FormeCupertinoTextField get widget => super.widget as FormeCupertinoTextField;

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
