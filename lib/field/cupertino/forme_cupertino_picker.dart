import 'package:flutter/cupertino.dart';
import 'package:forme/forme.dart';
import 'base_picker.dart';

class FormeCupertinoPicker
    extends FormeCupertinoBasePicker<int, FormeCupertinoPickerState> {
  FormeCupertinoPicker({
    super.key,
    super.name,
    super.initialValue = 0,
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
    super.cancelWidget,
    super.confirmWidget,
    super.barrierColor,
    super.barrierDismissible,
    super.filter,
    super.height = 216,
    super.routeSettings,
    super.semanticsDismissible,
    super.useRootNavigator,
    super.anchorPoint,
    required super.triggerBuilder,
    this.backgroundColor,
    this.diameterRatio,
    required this.itemExtent,
    this.looping = true,
    this.magnification,
    this.offAxisFraction,
    this.selectionOverlay,
    this.squeeze,
    this.useMagnifier,
    required this.children,
  });

  @override
  FormeCupertinoPickerState createState() => FormeCupertinoPickerState();

  final double? diameterRatio;
  final Color? backgroundColor;
  final double? offAxisFraction;
  final bool? useMagnifier;
  final double? magnification;
  final double? squeeze;
  final bool looping;
  final Widget? selectionOverlay;
  final double itemExtent;
  final List<Widget> children;
}

class FormeCupertinoPickerState extends FormeCupertinoBasePickerState<int> {
  late FixedExtentScrollController _scrollController;

  @override
  FormeCupertinoPicker get widget => super.widget as FormeCupertinoPicker;

  late int _index;

  @override
  void onConfirmed() {
    didChange(_index);
    requestFocusOnUserInteraction();
  }

  @override
  Widget createPickWidget() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      _scrollController.jumpToItem(value);
    });
    return CupertinoPicker(
      scrollController: _scrollController,
      diameterRatio: widget.diameterRatio ?? 1.07,
      backgroundColor: widget.backgroundColor,
      offAxisFraction: widget.offAxisFraction ?? 0.0,
      useMagnifier: widget.useMagnifier ?? false,
      magnification: widget.magnification ?? 1.0,
      squeeze: widget.squeeze ?? 1.45,
      looping: widget.looping,
      selectionOverlay: widget.selectionOverlay ??
          const CupertinoPickerDefaultSelectionOverlay(),
      itemExtent: widget.itemExtent,
      onSelectedItemChanged: (index) => _index = index,
      children: widget.children,
    );
  }

  @override
  void initStatus() {
    super.initStatus();
    _index = initialValue;
    _scrollController = FixedExtentScrollController(initialItem: _index);
  }

  @override
  void onStatusChanged(FormeFieldChangedStatus<int> status) {
    super.onStatusChanged(status);
    if (status.isValueChanged) {
      _index = status.value;
      _scrollController.jumpToItem(_index);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
