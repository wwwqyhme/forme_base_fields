import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:forme/forme.dart';

typedef FormeAutocompleteOptionsViewBuilder<T extends Object> = Widget Function(
    BuildContext context,
    AutocompleteOnSelected<T> onSelected,
    Iterable<T> options,
    double? width);

class FormeAutocomplete<T extends Object> extends FormeField<T?> {
  FormeAutocomplete({
    super.key,
    super.name,
    super.initialValue,
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
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
    this.fieldViewBuilder,
    this.fieldViewDecoration = const InputDecoration(),
    this.fieldViewDecorator,
    required this.optionsBuilder,
    this.optionsMaxHeight = 200,
    this.optionsViewBuilder,
  }) : super.allFields(
          builder: (genericState) {
            final FormeAutocompleteState<T> state =
                genericState as FormeAutocompleteState<T>;
            final bool readOnly = state.readOnly;
            final bool enabled = genericState.enabled;
            return RawAutocomplete<T>(
              focusNode: state.focusNode,
              textEditingController: state.textEditingController,
              onSelected: state.didChange,
              optionsViewBuilder: (
                BuildContext context,
                AutocompleteOnSelected<T> onSelected,
                Iterable<T> options,
              ) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final Size? size = state._fieldSizeGetter?.call();
                    final double? width = size?.width;
                    return optionsViewBuilder?.call(
                            context, onSelected, options, width) ??
                        AutocompleteOptions(
                          displayStringForOption: displayStringForOption,
                          onSelected: onSelected,
                          options: options,
                          maxOptionsHeight: optionsMaxHeight,
                          width: width,
                        );
                  },
                );
              },
              optionsBuilder: readOnly
                  ? (TextEditingValue value) => const Iterable.empty()
                  : optionsBuilder,
              displayStringForOption: displayStringForOption,
              fieldViewBuilder:
                  (context, textEditingController, focusNode, onSubmitted) {
                Widget field;
                if (fieldViewBuilder != null) {
                  field = fieldViewBuilder(
                      context, textEditingController, focusNode, onSubmitted);
                } else {
                  field = TextField(
                    focusNode: focusNode,
                    controller: textEditingController,
                    decoration: fieldViewDecoration?.copyWith(
                        errorText: state.errorText),
                    enabled: enabled,
                    readOnly: readOnly,
                    onSubmitted: readOnly
                        ? null
                        : (v) {
                            onSubmitted();
                          },
                    onChanged: readOnly
                        ? null
                        : (String v) {
                            final T? value = state.value;
                            if (value != null &&
                                displayStringForOption(value) != v) {
                              state.didChange(null);
                            }
                          },
                  );
                }
                return _FieldView(
                    state: state,
                    child: fieldViewDecorator == null
                        ? field
                        : fieldViewDecorator.build(
                            context,
                            field,
                            state,
                          ));
              },
            );
          },
        );

  final AutocompleteFieldViewBuilder? fieldViewBuilder;
  final AutocompleteOptionsBuilder<T> optionsBuilder;
  final FormeAutocompleteOptionsViewBuilder<T>? optionsViewBuilder;
  final double optionsMaxHeight;
  final FormeFieldDecorator<T?>? fieldViewDecorator;
  final InputDecoration? fieldViewDecoration;
  final AutocompleteOptionToString<T> displayStringForOption;
  @override
  FormeFieldState<T?> createState() => FormeAutocompleteState();
}

class FormeAutocompleteState<T extends Object> extends FormeFieldState<T?> {
  late final TextEditingController textEditingController;

  Size? Function()? _fieldSizeGetter;

  @override
  FormeAutocomplete<T> get widget => super.widget as FormeAutocomplete<T>;

  @override
  void initStatus() {
    super.initStatus();
    textEditingController = TextEditingController(
        text: value == null ? '' : widget.displayStringForOption(value!));
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void onStatusChanged(FormeFieldChangedStatus<T?> status) {
    super.onStatusChanged(status);
    if (status.isValueChanged && status.value != null) {
      final String text = widget.displayStringForOption(status.value!);
      if (textEditingController.text != text) {
        textEditingController.text = text;
      }
    }
    if (status.isReadOnlyChanged && readOnly && hasFocusNode) {
      focusNode.unfocus();
    }
  }

  @override
  void reset() {
    super.reset();

    if (hasFocusNode) {
      focusNode.unfocus();
    }
    if (value != null) {
      textEditingController.text = widget.displayStringForOption(value!);
    } else {
      textEditingController.text = '';
    }
  }

  String? get displayStringForOption =>
      value == null ? null : widget.displayStringForOption(value!);
}

// The default Material-style Autocomplete options.
class AutocompleteOptions<T extends Object> extends StatelessWidget {
  const AutocompleteOptions({
    Key? key,
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
    required this.maxOptionsHeight,
    required this.width,
  }) : super(key: key);

  final AutocompleteOptionToString<T> displayStringForOption;

  final AutocompleteOnSelected<T> onSelected;

  final Iterable<T> options;
  final double maxOptionsHeight;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final BoxConstraints constraints = width == null
        ? BoxConstraints(maxHeight: maxOptionsHeight)
        : BoxConstraints(maxHeight: maxOptionsHeight, maxWidth: width!);
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: ConstrainedBox(
          constraints: constraints,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final T option = options.elementAt(index);
              return InkWell(
                onTap: () {
                  onSelected(option);
                },
                child: Builder(builder: (BuildContext context) {
                  final bool highlight =
                      AutocompleteHighlightedOption.of(context) == index;
                  if (highlight) {
                    SchedulerBinding.instance
                        .addPostFrameCallback((Duration timeStamp) {
                      Scrollable.ensureVisible(context, alignment: 0.5);
                    });
                  }
                  return Container(
                    color: highlight ? Theme.of(context).focusColor : null,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(displayStringForOption(option)),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FieldView extends StatefulWidget {
  final Widget child;
  final FormeAutocompleteState state;

  const _FieldView({Key? key, required this.child, required this.state})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _FieldViewState();
}

class _FieldViewState extends State<_FieldView> {
  @override
  void deactivate() {
    widget.state._fieldSizeGetter = null;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    widget.state._fieldSizeGetter =
        () => (context.findRenderObject()! as RenderBox).size;
    return widget.child;
  }
}
