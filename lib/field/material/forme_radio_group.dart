import 'package:flutter/material.dart';

import 'package:forme/forme.dart';
import 'forme_list_tile.dart';

class FormeRadioGroup<T extends Object> extends FormeField<T?> {
  FormeRadioGroup({
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
    FormeFieldDecorator<T?>? decorator,
    this.alignment = WrapAlignment.start,
    this.clipBehavior,
    this.contentPadding,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.dense = true,
    this.direction = Axis.horizontal,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.iconColor,
    this.minLeadingWidth,
    this.minVerticalPadding,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.selectedColor,
    this.selectedTileColor,
    this.shape,
    this.spacing = 0.0,
    this.split = 2,
    this.style,
    this.textColor,
    this.textDirection,
    this.tileColor,
    this.verticalDirection = VerticalDirection.down,
    required this.items,
    this.decoration,
  }) : super.allFields(
            decorator: decorator ??
                (decoration == null
                    ? null
                    : FormeInputDecorationDecorator(
                        decorationBuilder: (context) => decoration)),
            builder: (state) {
              final bool readOnly = state.readOnly;
              final List<Widget> wrapWidgets = [];

              void changeValue(FormeListTileItem<T> item) {
                if (item.toggleable) {
                  if (item.data == state.value) {
                    state.didChange(null);
                  } else {
                    state.didChange(item.data);
                  }
                }
                state.requestFocusOnUserInteraction();
              }

              Widget createFormeListTileItem(
                  FormeListTileItem<T> item, bool selected, bool readOnly) {
                return RadioListTile<T>(
                  toggleable: item.toggleable,
                  shape: item.shape,
                  tileColor: item.tileColor,
                  selectedTileColor: item.selectedTileColor,
                  activeColor: item.activeColor,
                  secondary: item.secondary,
                  subtitle: item.subtitle,
                  groupValue: state.value,
                  controlAffinity: item.controlAffinity,
                  contentPadding: item.padding,
                  dense: item.dense,
                  title: item.title,
                  value: item.data,
                  visualDensity: item.visualDensity,
                  enableFeedback: item.enableFeedback,
                  onChanged: readOnly ? null : (v) => changeValue(item),
                );
              }

              Widget createCommonItem(
                  FormeListTileItem<T> item, bool selected, bool readOnly) {
                return Radio<T>(
                  toggleable: item.toggleable,
                  mouseCursor: item.mouseCursor,
                  activeColor: item.activeColor,
                  fillColor: item.fillColor,
                  materialTapTargetSize: item.materialTapTargetSize,
                  focusColor: item.focusColor,
                  hoverColor: item.hoverColor,
                  overlayColor: item.overlayColor,
                  splashRadius: item.splashRadius,
                  visualDensity: item.visualDensity,
                  value: item.data,
                  groupValue: state.value,
                  onChanged: readOnly || item.readOnly
                      ? null
                      : (v) => changeValue(item),
                );
              }

              for (int i = 0; i < items.length; i++) {
                final FormeListTileItem<T> item = items[i];
                final bool isReadOnly = readOnly || item.readOnly;
                final bool selected = state.value == item.data;
                if (split > 0) {
                  final double factor = 1 / split;
                  if (factor == 1) {
                    wrapWidgets.add(
                        createFormeListTileItem(item, selected, isReadOnly));
                    continue;
                  }
                }

                final Widget tileItem =
                    createCommonItem(item, selected, readOnly);

                final Widget title = split == 0
                    ? item.title
                    : Flexible(
                        child: item.title,
                      );

                List<Widget> children;
                switch (item.controlAffinity) {
                  case ListTileControlAffinity.leading:
                    children = [tileItem, title];
                    break;
                  default:
                    children = [title, tileItem];
                    break;
                }

                final Row tileItemRow = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                );

                final Widget groupItemWidget = Padding(
                  padding: item.padding,
                  child: InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      onTap: isReadOnly
                          ? null
                          : () {
                              changeValue(item);
                            },
                      child: tileItemRow),
                );

                final bool visible = item.visible;
                if (split <= 0) {
                  wrapWidgets.add(Visibility(
                    visible: visible,
                    child: groupItemWidget,
                  ));
                  if (visible && i < items.length - 1) {
                    wrapWidgets.add(const SizedBox(
                      width: 8.0,
                    ));
                  }
                } else {
                  final double factor = item.ignoreSplit ? 1 : 1 / split;
                  wrapWidgets.add(Visibility(
                    visible: visible,
                    child: FractionallySizedBox(
                      widthFactor: factor,
                      child: groupItemWidget,
                    ),
                  ));
                }
              }

              Widget child = Wrap(
                spacing: spacing,
                runSpacing: runSpacing,
                textDirection: textDirection,
                crossAxisAlignment: crossAxisAlignment,
                verticalDirection: verticalDirection,
                alignment: alignment,
                direction: direction,
                runAlignment: runAlignment,
                clipBehavior: clipBehavior ?? Clip.none,
                children: wrapWidgets,
              );
              if (split == 1) {
                child = ListTileTheme.merge(
                  child: child,
                  dense: dense,
                  shape: shape,
                  style: style,
                  selectedColor: selectedColor,
                  iconColor: iconColor,
                  textColor: textColor,
                  contentPadding: contentPadding,
                  tileColor: tileColor,
                  selectedTileColor: selectedTileColor,
                  enableFeedback: enableFeedback,
                  horizontalTitleGap: horizontalTitleGap,
                  minVerticalPadding: minVerticalPadding,
                  minLeadingWidth: minLeadingWidth,
                );
              }

              return Focus(
                focusNode: state.focusNode,
                child: child,
              );
            });

  final Clip? clipBehavior;
  final List<FormeListTileItem<T>> items;
  final int split;
  final bool dense;
  final ShapeBorder? shape;
  final ListTileStyle? style;
  final Color? selectedColor;
  final Color? iconColor;
  final Color? textColor;
  final EdgeInsetsGeometry? contentPadding;
  final Color? tileColor;
  final Color? selectedTileColor;
  final bool? enableFeedback;
  final double? horizontalTitleGap;
  final double? minVerticalPadding;
  final double? minLeadingWidth;
  final Axis direction;
  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final double runSpacing;
  final double spacing;
  final WrapCrossAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final InputDecoration? decoration;
}
