import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

import 'forme_slider.dart';

class FormRangeLabelRender {
  final FormeLabelRender startRender;
  final FormeLabelRender endRender;

  FormRangeLabelRender(this.startRender, this.endRender);
}

typedef RangeSliderThumbShapeBuilder = RangeSliderThumbShape Function(
    BuildContext context, RangeValues values);

class FormeRangeSlider extends FormeField<RangeValues> {
  FormeRangeSlider({
    super.key,
    super.name,
    RangeValues? initialValue,
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
    FormeFieldDecorator<RangeValues>? decorator,
    required this.min,
    required this.max,
    this.activeColor,
    this.decoration,
    this.divisions,
    this.inactiveColor,
    this.onChangeEnd,
    this.onChangeStart,
    this.onChanged,
    this.rangeLabelRender,
    this.semanticFormatterCallback,
    this.sliderThemeData,
    this.shapeBuilder,
  }) : super.allFields(
            decorator: decorator ??
                (decoration == null
                    ? null
                    : FormeInputDecorationDecorator(
                        decorationBuilder: (context) => decoration)),
            initialValue: initialValue ?? RangeValues(min, max),
            builder: (baseState) {
              final _FormeRangeSliderState state =
                  baseState as _FormeRangeSliderState;
              final bool readOnly = state.readOnly;

              final Widget slider = ValueListenableBuilder(
                  valueListenable: state.notifier,
                  builder: (context, _, __) {
                    RangeLabels? sliderLabels;

                    if (rangeLabelRender != null) {
                      final String start =
                          rangeLabelRender.startRender(state.value.start);
                      final String end =
                          rangeLabelRender.endRender(state.value.end);
                      sliderLabels = RangeLabels(start, end);
                    }

                    SliderThemeData themeData =
                        sliderThemeData ?? SliderTheme.of(state.context);
                    if (themeData.thumbShape == null) {
                      themeData = themeData.copyWith(
                          rangeThumbShape:
                              shapeBuilder?.call(state.context, state.value));
                    }
                    return SliderTheme(
                      data: themeData,
                      child: RangeSlider(
                        values: state.value,
                        min: min,
                        max: max,
                        divisions: divisions ?? (max - min).floor(),
                        labels: sliderLabels,
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
                        onChanged: readOnly
                            ? null
                            : (RangeValues values) {
                                state.updateValue(values);
                                onChanged?.call(values);
                              },
                      ),
                    );
                  });

              return Focus(
                focusNode: state.focusNode,
                child: slider,
              );
            });

  final double min;
  final double max;
  final InputDecoration? decoration;
  final SemanticFormatterCallback? semanticFormatterCallback;
  final ValueChanged<RangeValues>? onChangeStart;
  final ValueChanged<RangeValues>? onChangeEnd;
  final ValueChanged<RangeValues>? onChanged;
  final int? divisions;
  final Color? activeColor;
  final Color? inactiveColor;
  final SliderThemeData? sliderThemeData;
  final FormRangeLabelRender? rangeLabelRender;
  final RangeSliderThumbShapeBuilder? shapeBuilder;
  @override
  FormeFieldState<RangeValues> createState() => _FormeRangeSliderState();
}

class _FormeRangeSliderState extends FormeFieldState<RangeValues> {
  final ValueNotifier<RangeValues?> notifier = FormeMountedValueNotifier(null);

  @override
  FormeRangeSlider get widget => super.widget as FormeRangeSlider;

  void updateValue(RangeValues value) {
    notifier.value = value;
  }

  @override
  RangeValues get initialValue {
    final RangeValues defaultInitialValue = super.initialValue;
    RangeValues currentInitialValue = defaultInitialValue;
    if (defaultInitialValue.start < widget.min) {
      currentInitialValue = RangeValues(widget.min, defaultInitialValue.end);
    } else if (defaultInitialValue.end < widget.min) {
      currentInitialValue = RangeValues(defaultInitialValue.start, widget.min);
    }
    if (defaultInitialValue.end > widget.max) {
      currentInitialValue = RangeValues(defaultInitialValue.start, widget.max);
    } else if (defaultInitialValue.start > widget.max) {
      currentInitialValue = RangeValues(widget.max, defaultInitialValue.end);
    }
    return currentInitialValue;
  }

  @override
  RangeValues get value => notifier.value ?? super.value;

  @override
  void onStatusChanged(FormeFieldChangedStatus<RangeValues> status) {
    super.onStatusChanged(status);
    if (status.isValueChanged) {
      notifier.value = null;
    }
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }
}

class CustomRangeSliderThumbCircle extends RangeSliderThumbShape {
  final double enabledThumbRadius;
  final double elevation;
  final double pressedElevation;
  final RangeValues value;

  CustomRangeSliderThumbCircle(
      {this.enabledThumbRadius = 12,
      this.elevation = 1,
      this.pressedElevation = 6,
      required this.value});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    String value;
    switch (thumb ?? Thumb.start) {
      case Thumb.start:
        value = this.value.start.round().toString();
        break;
      case Thumb.end:
        value = this.value.end.round().toString();
        break;
    }

    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    final Color color = colorTween.evaluate(enableAnimation)!;

    final paint = Paint()
      ..color = color //Thumb Background Color
      ..style = PaintingStyle.fill;

    final TextSpan span = TextSpan(
        style: TextStyle(
          fontSize: enabledThumbRadius * .8,
          fontWeight: FontWeight.w700,
          color: Colors.white, //Text Color of Value on Thumb
        ),
        text: value);

    final TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    final Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, enabledThumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }
}
