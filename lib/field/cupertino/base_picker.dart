import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:forme/forme.dart';

typedef FormeCupertinoBasePickerTriggerBuilder<
        T extends FormeCupertinoBasePickerState>
    = Widget Function(T state);

abstract class FormeCupertinoBasePicker<T,
    E extends FormeCupertinoBasePickerState<T>> extends FormeField<T> {
  FormeCupertinoBasePicker({
    super.key,
    super.name,
    required super.initialValue,
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
    required this.triggerBuilder,
    this.cancelWidget,
    this.confirmWidget,
    this.anchorPoint,
    this.barrierColor,
    this.barrierDismissible,
    this.filter,
    this.height,
    this.routeSettings,
    this.semanticsDismissible,
    this.useRootNavigator,
  }) : super.allFields(
          builder: (state) {
            return triggerBuilder.call(state as E);
          },
        );

  @override
  FormeCupertinoBasePickerState<T> createState();

  final Widget? cancelWidget;
  final Widget? confirmWidget;
  final double? height;
  final Offset? anchorPoint;
  final RouteSettings? routeSettings;
  final bool? semanticsDismissible;
  final bool? useRootNavigator;
  final bool? barrierDismissible;
  final ImageFilter? filter;
  final Color? barrierColor;
  final FormeCupertinoBasePickerTriggerBuilder<E> triggerBuilder;
}

abstract class FormeCupertinoBasePickerState<T> extends FormeFieldState<T> {
  @override
  FormeCupertinoBasePicker<T, FormeCupertinoBasePickerState<T>> get widget =>
      super.widget
          as FormeCupertinoBasePicker<T, FormeCupertinoBasePickerState<T>>;

  VoidCallback? get showPicker => readOnly ? null : _showPicker;

  @protected
  Widget createPickWidget();

  @protected
  void onConfirmed();

  void _showPicker() {
    showCupertinoModalPopup(
        context: context,
        barrierColor: widget.barrierColor ?? kCupertinoModalBarrierColor,
        filter: widget.filter,
        barrierDismissible: widget.barrierDismissible ?? true,
        useRootNavigator: widget.useRootNavigator ?? true,
        semanticsDismissible: widget.semanticsDismissible ?? false,
        routeSettings: widget.routeSettings,
        anchorPoint: widget.anchorPoint,
        builder: (context) {
          return CupertinoActionSheet(
            actions: [
              Container(
                height: widget.height ?? 216,
                padding: const EdgeInsets.only(top: 6.0),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                color: CupertinoColors.systemBackground.resolveFrom(context),
                child: SafeArea(
                  top: false,
                  child: createPickWidget(),
                ),
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: widget.confirmWidget ?? const Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirmed();
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              child: widget.cancelWidget ?? const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        });
  }
}
