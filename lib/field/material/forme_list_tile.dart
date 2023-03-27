import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:forme/forme.dart';

class FormeListTileItem<T extends Object> {
  final Widget title;
  final bool readOnly;
  final bool visible;
  final EdgeInsetsGeometry padding;

  /// only work when split = 1
  final Widget? secondary;
  final ListTileControlAffinity controlAffinity;

  /// only work when split = 1
  final Widget? subtitle;
  final bool dense;
  final T data;
  final bool ignoreSplit;

  /// worked when split = 1
  final bool? enableFeedback;

  /// worked when split = 1
  final VisualDensity? visualDensity;

  /// worked when split = 1 && type == checkbox
  final BorderSide? side;

  /// worked when split = 1
  final bool? isThreeLine;

  /// worked when split = 1
  final ShapeBorder? shape;

  /// worked when split = 1
  final Color? tileColor;

  /// worked when split = 1
  final Color? selectedTileColor;

  final Color? activeColor;

  /// worked when type == checkbox
  final Color? checkColor;

  /// type == checkbox
  final OutlinedBorder? checkboxShape;

  /// worked when type == switch
  final Color? hoverColor;

  /// worked type == switch
  final Color? activeTrackColor;

  /// worked when type == switch
  final Color? inactiveThumbColor;

  /// worked when type == switch
  final Color? inactiveTrackColor;

  /// worked when type == switch
  final ImageProvider<Object>? activeThumbImage;

  /// worked when type == switch
  final ImageProvider<Object>? inactiveThumbImage;

  /// worked when split != 1;
  final MouseCursor? mouseCursor;

  /// worked when split != 1 && type == checkbox;
  final MaterialStateProperty<Color?>? fillColor;

  /// worked when split != 1;
  final MaterialTapTargetSize? materialTapTargetSize;

  /// worked when split != 1;
  final Color? focusColor;

  /// worked when split != 1;
  final MaterialStateProperty<Color?>? overlayColor;

  /// worked when split != 1;
  final double? splashRadius;

  /// worked when split != 1 && type == switch;
  final MaterialStateProperty<Color?>? thumbColor;

  /// worked when split != 1 && type == switch;
  final MaterialStateProperty<Color?>? trackColor;

  /// worked when split != 1 && type == switch;
  final DragStartBehavior? dragStartBehavior;

  /// worked when split != 1 && type == switch;
  final ImageErrorListener? onActiveThumbImageError;

  /// worked when split != 1 && type == switch;
  final ImageErrorListener? onInactiveThumbImageError;

  /// worked when split != 1 && type == switch;
  final MaterialStateProperty<Icon?>? thumbIcon;

  /// worked when type == Radio
  final bool toggleable;

  FormeListTileItem({
    required this.title,
    this.subtitle,
    this.secondary,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.readOnly = false,
    this.visible = true,
    this.dense = false,
    this.padding = EdgeInsets.zero,
    required this.data,
    this.ignoreSplit = false,
    this.enableFeedback,
    this.visualDensity,
    this.side,
    this.isThreeLine,
    this.shape,
    this.tileColor,
    this.selectedTileColor,
    this.activeColor,
    this.checkColor,
    this.checkboxShape,
    this.activeThumbImage,
    this.activeTrackColor,
    this.fillColor,
    this.hoverColor,
    this.inactiveThumbColor,
    this.inactiveThumbImage,
    this.inactiveTrackColor,
    this.materialTapTargetSize,
    this.mouseCursor,
    this.dragStartBehavior,
    this.focusColor,
    this.onActiveThumbImageError,
    this.onInactiveThumbImageError,
    this.overlayColor,
    this.splashRadius,
    this.thumbColor,
    this.thumbIcon,
    this.trackColor,
    this.toggleable = true,
  });
}

enum FormeListTileType { checkbox, switchs }

/// example
/// ``` dart
/// FormeListTile(
///      validator: FormeValidates.notEmpty(errorText: 'required'),
///      items: "123456789"
///          .characters
///          .map((e) => FormeListTileItem(
///                title: Text(e),
///               data: e,
///             ))
///         .toList(),
///     name: 'checkBoxListTile',
///     maxSelectedCount: 5,
///      decoration: const InputDecoration(labelText: 'ListTile'),
///    )
/// ```
class FormeListTile<T extends Object> extends FormeField<List<T>> {
  FormeListTile({
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
    this.maxSelectedCount,
    this.alignment = WrapAlignment.start,
    this.clipBehavior,
    this.contentPadding,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.decoration,
    this.dense = true,
    this.direction = Axis.horizontal,
    this.enableFeedback,
    this.horizontalTitleGap,
    this.iconColor,
    this.maxSelectedExceedCallback,
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
    this.type = FormeListTileType.checkbox,
    this.verticalDirection = VerticalDirection.down,
    required this.items,
  }) : super.allFields(
            decorator: decorator ??
                (decoration == null
                    ? null
                    : FormeInputDecorationDecorator(
                        maxLength: maxSelectedCount,
                        decorationBuilder: (context) => decoration)),
            builder: (state) {
              final bool readOnly = state.readOnly;

              final List<Widget> wrapWidgets = [];

              void changeValue(T value) {
                final List<T> values = List.of(state.value);
                if (!values.remove(value)) {
                  if (maxSelectedCount != null &&
                      values.length >= maxSelectedCount) {
                    if (maxSelectedExceedCallback != null) {
                      maxSelectedExceedCallback();
                    }
                    return;
                  }
                  values.add(value);
                }
                state.didChange(values);
                state.requestFocusOnUserInteraction();
              }

              Widget createFormeListTileItem(
                  FormeListTileItem<T> item, bool selected, bool readOnly) {
                switch (type) {
                  case FormeListTileType.checkbox:
                    return CheckboxListTile(
                      enableFeedback: item.enableFeedback,
                      visualDensity: item.visualDensity,
                      side: item.side,
                      tristate: false,
                      isThreeLine: item.isThreeLine ?? false,
                      shape: item.shape,
                      tileColor: item.tileColor,
                      selectedTileColor: item.selectedTileColor,
                      activeColor: item.activeColor,
                      checkColor: item.checkColor,
                      secondary: item.secondary,
                      subtitle: item.subtitle,
                      controlAffinity: item.controlAffinity,
                      contentPadding: item.padding,
                      dense: item.dense,
                      title: item.title,
                      checkboxShape: item.checkboxShape,
                      value: selected,
                      onChanged:
                          readOnly ? null : (v) => changeValue(item.data),
                    );
                  case FormeListTileType.switchs:
                    return SwitchListTile(
                      enableFeedback: item.enableFeedback,
                      visualDensity: item.visualDensity,
                      isThreeLine: item.isThreeLine ?? false,
                      tileColor: item.tileColor,
                      activeColor: item.activeColor,
                      shape: item.shape,
                      selectedTileColor: item.selectedTileColor,
                      secondary: item.secondary,
                      subtitle: item.subtitle,
                      controlAffinity: item.controlAffinity,
                      contentPadding: item.padding,
                      dense: item.dense,
                      title: item.title,
                      hoverColor: item.hoverColor,
                      activeTrackColor: item.activeTrackColor,
                      inactiveThumbColor: item.inactiveThumbColor,
                      inactiveTrackColor: item.inactiveTrackColor,
                      activeThumbImage: item.activeThumbImage,
                      inactiveThumbImage: item.inactiveThumbImage,
                      value: selected,
                      onChanged:
                          readOnly ? null : (v) => changeValue(item.data),
                    );
                }
              }

              Widget createCommonItem(
                  FormeListTileItem<T> item, bool selected, bool readOnly) {
                switch (type) {
                  case FormeListTileType.checkbox:
                    return Checkbox(
                      tristate: false,
                      side: item.side,
                      activeColor: item.activeColor,
                      checkColor: item.checkColor,
                      mouseCursor: item.mouseCursor,
                      shape: item.checkboxShape,
                      fillColor: item.fillColor,
                      materialTapTargetSize: item.materialTapTargetSize,
                      focusColor: item.focusColor,
                      hoverColor: item.hoverColor,
                      overlayColor: item.overlayColor,
                      splashRadius: item.splashRadius,
                      visualDensity: item.visualDensity,
                      value: selected,
                      onChanged: readOnly || item.readOnly
                          ? null
                          : (v) => changeValue(item.data),
                    );
                  case FormeListTileType.switchs:
                    return Switch(
                      value: selected,
                      onChanged: readOnly || item.readOnly
                          ? null
                          : (v) => changeValue(item.data),
                      activeColor: item.activeColor,
                      activeTrackColor: item.activeTrackColor,
                      inactiveThumbColor: item.inactiveThumbColor,
                      inactiveTrackColor: item.inactiveTrackColor,
                      activeThumbImage: item.activeThumbImage,
                      inactiveThumbImage: item.inactiveThumbImage,
                      materialTapTargetSize: item.materialTapTargetSize,
                      focusColor: item.focusColor,
                      hoverColor: item.hoverColor,
                      overlayColor: item.overlayColor,
                      splashRadius: item.splashRadius,
                      thumbColor: item.thumbColor,
                      trackColor: item.trackColor,
                      dragStartBehavior:
                          item.dragStartBehavior ?? DragStartBehavior.start,
                      onActiveThumbImageError: item.onActiveThumbImageError,
                      onInactiveThumbImageError: item.onInactiveThumbImageError,
                      thumbIcon: item.thumbIcon,
                      mouseCursor: item.mouseCursor,
                    );
                }
              }

              for (int i = 0; i < items.length; i++) {
                final FormeListTileItem<T> item = items[i];
                final bool isReadOnly = readOnly || item.readOnly;
                final bool selected = state.value.contains(item.data);
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
                              changeValue(item.data);
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

  final List<FormeListTileItem<T>> items;
  final int? maxSelectedCount;
  final FormeListTileType type;
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
  final VoidCallback? maxSelectedExceedCallback;
  final Clip? clipBehavior;
}
