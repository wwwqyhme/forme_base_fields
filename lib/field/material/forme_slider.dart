import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

typedef FormeLabelRender = String Function(double value);

class FormeSlider extends FormeField<double> {
  FormeSlider({
    super.key,
    super.name,
    double? initialValue,
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
    FormeFieldDecorator<double>? decorator,
    required this.min,
    required this.max,
    this.activeColor,
    this.autofocus = false,
    this.divisions,
    this.inactiveColor,
    this.labelRender,
    this.mouseCursor,
    this.onChangeEnd,
    this.onChangeStart,
    this.onChanged,
    this.overlayColor,
    this.secondaryActiveColor,
    this.secondaryTrackValue,
    this.semanticFormatterCallback,
    this.sliderThemeData,
    this.thumbColor,
    this.decoration,
  }) : super.allFields(
          initialValue: initialValue ?? min,
          decorator: decorator ??
              (decoration == null
                  ? null
                  : FormeInputDecorationDecorator(
                      decorationBuilder: (context) => decoration)),
          builder: (baseState) {
            final _FormeSliderState state = baseState as _FormeSliderState;
            final bool readOnly = state.readOnly;

            final Widget slider = ValueListenableBuilder<double?>(
              valueListenable: state.notifier,
              builder: (context, value, child) {
                final String? sliderLabel =
                    labelRender == null ? null : labelRender(state.value);
                SliderThemeData themeData =
                    sliderThemeData ?? SliderTheme.of(state.context);
                if (themeData.thumbShape == null) {
                  themeData = themeData.copyWith(
                      thumbShape: CustomSliderThumbCircle(value: state.value));
                }
                return SliderTheme(
                  data: themeData,
                  child: Slider(
                    secondaryTrackValue: secondaryTrackValue,
                    secondaryActiveColor: secondaryActiveColor,
                    autofocus: autofocus,
                    overlayColor: overlayColor,
                    thumbColor: thumbColor,
                    value: state.value,
                    min: min,
                    max: max,
                    focusNode: state.focusNode,
                    label: sliderLabel,
                    divisions: divisions ?? (max - min).floor(),
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    onChangeStart: (v) {
                      state.focusNode.requestFocus();
                      onChangeStart?.call(v);
                    },
                    onChangeEnd: (v) {
                      state.didChange(v);
                      onChangeEnd?.call(v);
                    },
                    semanticFormatterCallback: semanticFormatterCallback,
                    mouseCursor: mouseCursor,
                    onChanged: readOnly
                        ? null
                        : (double value) {
                            state.updateValue(value);
                            onChanged?.call(value);
                          },
                  ),
                );
              },
            );

            return slider;
          },
        );

  final double min;
  final double max;
  final SemanticFormatterCallback? semanticFormatterCallback;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final ValueChanged<double>? onChanged;
  final int? divisions;
  final Color? activeColor;
  final Color? inactiveColor;
  final SliderThemeData? sliderThemeData;
  final MouseCursor? mouseCursor;
  final FormeLabelRender? labelRender;
  final Color? thumbColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final bool autofocus;
  final double? secondaryTrackValue;
  final Color? secondaryActiveColor;
  final InputDecoration? decoration;
  @override
  FormeFieldState<double> createState() => _FormeSliderState();
}

class _FormeSliderState extends FormeFieldState<double> {
  final ValueNotifier<double?> notifier = FormeMountedValueNotifier(null);

  @override
  FormeSlider get widget => super.widget as FormeSlider;

  void updateValue(double value) {
    notifier.value = value;
  }

  @override
  double get initialValue {
    final double defaultInitialValue = widget.initialValue;
    if (defaultInitialValue < widget.min) {
      return widget.min;
    }
    if (defaultInitialValue > widget.max) {
      return widget.max;
    }
    return defaultInitialValue;
  }

  @override
  double get value => notifier.value ?? super.value;

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  void onStatusChanged(FormeFieldChangedStatus<double> status) {
    super.onStatusChanged(status);
    if (status.isValueChanged) {
      notifier.value = null;
    }
  }
}

// copied from https://medium.com/flutter-community/flutter-sliders-demystified-4b3ea65879c
class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final double value;

  const CustomSliderThumbCircle({
    this.thumbRadius = 12,
    required this.value,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    final Color color = colorTween.evaluate(enableAnimation)!;

    final Paint paint = Paint()
      ..color = color //Thumb Background Color
      ..style = PaintingStyle.fill;

    final TextSpan span = TextSpan(
        style: TextStyle(
          fontSize: thumbRadius * .8,
          fontWeight: FontWeight.w700,
          color: Colors.white, //Text Color of Value on Thumb
        ),
        text: this.value.round().toString());
    final TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    final Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }
}
