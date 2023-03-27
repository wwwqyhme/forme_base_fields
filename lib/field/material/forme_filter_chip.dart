import 'package:flutter/material.dart';

import 'package:forme/forme.dart';
import 'forme_choice_chip.dart';

/// example
///
/// ``` dart
/// FormeFilterChip<String>(
///      maxSelectedCount: 3,
///      validator: FormeValidates.notEmpty(errorText: 'required'),
///      items: "123456789"
///          .characters
///         .map((e) => FormeChipItem(label: Text(e), data: e))
///          .toList(),
///      name: 'filterChip',
///      decoration: const InputDecoration(labelText: 'Filter Chip'),
///    )
/// ```
class FormeFilterChip<T extends Object> extends FormeField<List<T>> {
  FormeFilterChip({
    super.key,
    super.name,
    super.initialValue = const [],
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
    FormeFieldDecorator<List<T>>? decorator,
    required this.items,
    this.maxSelectedCount,
    this.alignment = WrapAlignment.start,
    this.chipThemeData,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.decoration,
    this.direction = Axis.horizontal,
    this.maxSelectedExceedCallback,
    this.padding,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.spacing = 0.0,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
  }) : super.allFields(
          decorator: decorator ??
              (decoration == null
                  ? null
                  : FormeInputDecorationDecorator(
                      decorationBuilder: (context) => decoration,
                      maxLength: maxSelectedCount,
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
              final FilterChip chip = FilterChip(
                iconTheme: item.iconTheme,
                surfaceTintColor: item.surfaceTintColor,
                clipBehavior: item.clipBehavior,
                selected: state.value.contains(item.data),
                label: item.label,
                avatar: item.avatar,
                padding: item.padding,
                pressElevation: item.pressElevation,
                tooltip: item.tooltip,
                materialTapTargetSize: item.materialTapTargetSize,
                avatarBorder: item.avatarBorder,
                backgroundColor: item.backgroundColor,
                checkmarkColor: item.checkmarkColor,
                showCheckmark: item.showCheckmark,
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
                onSelected: isReadOnly
                    ? null
                    : (bool selected) {
                        final List<T> value = List.of(state.value);
                        if (selected) {
                          if (maxSelectedCount != null &&
                              value.length >= maxSelectedCount) {
                            if (maxSelectedExceedCallback != null) {
                              maxSelectedExceedCallback();
                            }
                            return;
                          }
                          state.didChange(value..add(item.data));
                        } else {
                          state.didChange(value..remove(item.data));
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
  final int? maxSelectedCount;
  final ChipThemeData? chipThemeData;
  final VoidCallback? maxSelectedExceedCallback;
  final InputDecoration? decoration;
  final Axis direction;
  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final double runSpacing;
  final double spacing;
  final WrapCrossAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final EdgeInsets? padding;
}
