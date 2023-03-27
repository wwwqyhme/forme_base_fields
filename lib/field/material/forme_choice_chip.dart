import 'package:flutter/material.dart';
import 'package:forme/forme.dart';

/// example
///
/// ``` dart
/// FormeChoiceChip<String>(
///      validator:
///         FormeValidates.notNull(errorText: 'choice required'),
///      items: "123456789"
///          .characters
///          .map((e) => FormeChipItem(label: Text(e), data: e))
///          .toList(),
///      name: 'choice',
///      decorator: FormeInputDecorationDecorator(
///        childBuilder: (context, child) {
///          return Padding(
///            padding: const EdgeInsets.symmetric(
///                vertical: 8, horizontal: 5),
///            child: child,
///          );
///        },
///        decorationBuilder: (context) {
///          return const InputDecoration(labelText: "Choice Chip");
///        },
///      ),
///   )
///
/// ```
///
///
///
class FormeChoiceChip<T extends Object> extends FormeField<T?> {
  FormeChoiceChip({
    super.key,
    super.name,
    super.initialValue,
    super.asyncValidator,
    super.asyncValidatorDebounce,
    super.autovalidateMode,
    FormeFieldDecorator<T?>? decorator,
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
    this.decoration,
    this.padding,
    this.chipThemeData,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.spacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    required this.items,
  }) : super.allFields(
          decorator: decorator ??
              (decoration == null
                  ? null
                  : FormeInputDecorationDecorator(
                      decorationBuilder: (context) => decoration,
                      childBuilder: (context, child) => Padding(
                        padding: padding ??
                            const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                        child: child,
                      ),
                    )),
          builder: (state) {
            final bool readOnly = state.readOnly;
            final List<Widget> chips = [];
            for (final FormeChipItem<T> item in items) {
              final bool isReadOnly = readOnly || item.readOnly;
              final ChoiceChip chip = ChoiceChip(
                selected: state.value == item.data,
                label: item.label,
                avatar: item.avatar,
                padding: item.padding,
                pressElevation: item.pressElevation,
                tooltip: item.tooltip ?? item.tooltip,
                materialTapTargetSize: item.materialTapTargetSize,
                avatarBorder: item.avatarBorder,
                backgroundColor: item.backgroundColor,
                shadowColor: item.shadowColor,
                disabledColor: item.disabledColor,
                selectedColor: item.selectedColor,
                selectedShadowColor: item.selectedShadowColor,
                visualDensity: item.visualDensity,
                elevation: item.elevation,
                labelPadding: item.labelPadding,
                labelStyle: item.labelStyle,
                shape: item.shape,
                side: item.side,
                clipBehavior: item.clipBehavior,
                surfaceTintColor: item.surfaceTintColor,
                iconTheme: item.iconTheme,
                onSelected: isReadOnly
                    ? null
                    : (bool selected) {
                        if (state.value == item.data) {
                          state.didChange(null);
                        } else {
                          state.didChange(item.data);
                        }
                        state.requestFocusOnUserInteraction();
                      },
              );
              chips.add(Visibility(
                  visible: item.visible,
                  child: Padding(
                    padding: item.padding,
                    child: chip,
                  )));
            }

            final Widget chipWidget = Wrap(
              spacing: spacing,
              runSpacing: runSpacing,
              textDirection: textDirection,
              crossAxisAlignment: crossAxisAlignment,
              verticalDirection: verticalDirection,
              alignment: alignment,
              direction: direction,
              runAlignment: runAlignment,
              children: chips,
            );

            return Focus(
              focusNode: state.focusNode,
              child: ChipTheme(
                data: chipThemeData ?? ChipTheme.of(state.context),
                child: chipWidget,
              ),
            );
          },
        );

  final List<FormeChipItem<T>> items;
  final ChipThemeData? chipThemeData;
  final Axis direction;
  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final double runSpacing;
  final double spacing;
  final WrapCrossAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final InputDecoration? decoration;
  final EdgeInsets? padding;
}

class FormeChipItem<T extends Object> {
  final Widget label;
  final Widget? avatar;
  final T data;
  final EdgeInsetsGeometry? labelPadding;
  final EdgeInsetsGeometry padding;
  final bool readOnly;
  final bool visible;
  final String? tooltip;
  final TextStyle? labelStyle;
  final double? pressElevation;
  final Color? disabledColor;
  final Color? selectedColor;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final Color? backgroundColor;
  final VisualDensity? visualDensity;
  final MaterialTapTargetSize? materialTapTargetSize;
  final double? elevation;
  final Color? shadowColor;
  final Color? selectedShadowColor;
  final bool? showCheckmark;
  final Color? checkmarkColor;
  final CircleBorder avatarBorder;
  final Clip clipBehavior;
  final Color? surfaceTintColor;
  final IconThemeData? iconTheme;

  FormeChipItem({
    required this.label,
    this.avatar,
    required this.data,
    EdgeInsetsGeometry? padding,
    this.readOnly = false,
    this.visible = true,
    this.labelPadding,
    this.tooltip,
    this.labelStyle,
    this.avatarBorder = const CircleBorder(),
    this.backgroundColor,
    this.checkmarkColor,
    this.showCheckmark,
    this.shadowColor,
    this.disabledColor,
    this.selectedColor,
    this.selectedShadowColor,
    this.visualDensity,
    this.elevation,
    this.pressElevation,
    this.materialTapTargetSize,
    this.shape,
    this.side,
    this.clipBehavior = Clip.none,
    this.surfaceTintColor,
    this.iconTheme,
  }) : padding = padding ?? const EdgeInsets.symmetric(horizontal: 10);
}
