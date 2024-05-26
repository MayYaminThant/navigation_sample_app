library dropdown_search;

import 'dart:async';
import 'package:dh_mobile/src/presentations/views/searchable_dropdown/src/properties/icon_button_props.dart';
import 'package:dh_mobile/src/presentations/views/searchable_dropdown/src/properties/selection_list_view_props.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'src/modal_dialog.dart';
import 'src/popup_menu.dart';
import 'src/properties/popup_safearea_props.dart';
import 'src/properties/scrollbar_props.dart';
import 'src/properties/text_field_props.dart';
import 'src/selection_widget.dart';

export 'src/properties/icon_button_props.dart';
export 'src/properties/popup_safearea_props.dart';
export 'src/properties/scrollbar_props.dart';
export 'src/properties/selection_list_view_props.dart';
export 'src/properties/text_field_props.dart';

typedef DropdownSearchOnFind<T> = Future<List<T>> Function(String? text);
typedef DropdownSearchItemAsString<T> = String Function(T? item);
typedef DropdownSearchFilterFn<T> = bool Function(T? item, String? filter);
typedef DropdownSearchCompareFn<T> = bool Function(T? item, T? selectedItem);
typedef DropdownSearchBuilder<T> = Widget Function(
    BuildContext context, T? selectedItem);
typedef DropdownSearchBuilderMultiSelection<T> = Widget Function(
    BuildContext context, List<T> selectedItems);
typedef DropdownSearchPopupItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  bool isSelected,
);
typedef DropdownSearchPopupItemEnabled<T> = bool Function(T item);
typedef ErrorBuilder<T> = Widget Function(
    BuildContext context, String? searchEntry, dynamic exception);
typedef EmptyBuilder<T> = Widget Function(
    BuildContext context, String? searchEntry);
typedef LoadingBuilder<T> = Widget Function(
    BuildContext context, String? searchEntry);
typedef BeforeChange<T> = Future<bool?> Function(T? prevItem, T? nextItem);
typedef BeforeChangeMultiSelection<T> = Future<bool?> Function(
    List<T> prevItems, List<T> nextItems);
typedef FavoriteItemsBuilder<T> = Widget Function(
    BuildContext context, T item, bool isSelected);
typedef ValidationMultiSelectionBuilder<T> = Widget Function(
    BuildContext context, List<T> item);

typedef PositionCallback = RelativeRect Function(
    RenderBox popupButtonObject, RenderBox overlay);

typedef OnItemAdded<T> = void Function(List<T> selectedItems, T addedItem);
typedef OnItemRemoved<T> = void Function(List<T> selectedItems, T removedItem);
typedef FavoriteItems<T> = List<T> Function(List<T> items);

enum Mode { dialog, bottomSheet, menu }

class DropdownSearch<T> extends StatefulWidget {
  final bool showSearchBox;
  final bool isFilteredOnline;
  final bool showClearButton;
  final List<T>? items;
  final T? selectedItem;
  final List<T> selectedItems;
  final DropdownSearchOnFind<T>? onFind;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<List<T>>? onChangedMultiSelection;
  final DropdownSearchBuilder<T>? dropdownBuilder;
  final DropdownSearchBuilderMultiSelection<T>? dropdownBuilderMultiSelection;
  final DropdownSearchPopupItemBuilder<T>? popupItemBuilder;
  final Color? popupBackgroundColor;
  final Widget? popupTitle;
  final DropdownSearchItemAsString<T>? itemAsString;
  final DropdownSearchFilterFn<T>? filterFn;
  final bool enabled;
  final Mode mode;
  final double? maxHeight;
  final double? dialogMaxWidth;
  final bool showSelectedItems;
  final DropdownSearchCompareFn<T>? compareFn;
  final InputDecoration? dropdownSearchDecoration;
  final TextStyle? dropdownSearchBaseStyle;
  final TextAlign? dropdownSearchTextAlign;
  final TextAlignVertical? dropdownSearchTextAlignVertical;
  final EmptyBuilder? emptyBuilder;
  final LoadingBuilder? loadingBuilder;
  final ErrorBuilder? errorBuilder;
  final ShapeBorder? popupShape;
  final AutovalidateMode? autoValidateMode;
  final FormFieldSetter<T>? onSaved;
  final FormFieldSetter<List<T>>? onSavedMultiSelection;
  final FormFieldValidator<T>? validator;
  final FormFieldValidator<List<T>>? validatorMultiSelection;
  final bool dropdownBuilderSupportsNullItem;
  final DropdownSearchPopupItemEnabled<T>? popupItemDisabled;
  final Color? popupBarrierColor;
  final VoidCallback? onPopupDismissed;
  final BeforeChange<T>? onBeforeChange;
  final BeforeChangeMultiSelection<T>? onBeforeChangeMultiSelection;
  final bool showFavoriteItems;
  final FavoriteItemsBuilder<T>? favoriteItemBuilder;
  final FavoriteItems<T>? favoriteItems;
  final MainAxisAlignment? favoriteItemsAlignment;
  final PopupSafeAreaProps popupSafeArea;
  final TextFieldProps? searchFieldProps;
  final ScrollbarProps? scrollbarProps;
  final bool popupBarrierDismissible;
  final bool isMultiSelectionMode;
  final OnItemAdded<T>? popupOnItemAdded;
  final OnItemRemoved<T>? popupOnItemRemoved;
  final DropdownSearchPopupItemBuilder<T>? popupSelectionWidget;
  final ValidationMultiSelectionBuilder<T>? popupValidationMultiSelectionWidget;
  final ValidationMultiSelectionBuilder<T>? popupCustomMultiSelectionWidget;
  final double popupElevation;
  final SelectionListViewProps selectionListViewProps;
  final FocusNode? focusNode;
  final PositionCallback? positionCallback;
  final IconButtonProps? clearButtonProps;
  final IconButtonProps? dropdownButtonProps;

  const DropdownSearch({
    Key? key,
    this.onSaved,
    this.validator,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.mode = Mode.dialog,
    this.isFilteredOnline = false,
    this.popupTitle,
    this.items,
    this.selectedItem,
    this.onFind,
    this.dropdownBuilder,
    this.popupItemBuilder,
    this.clearButtonProps,
    this.showSearchBox = false,
    this.showClearButton = false,
    this.popupBackgroundColor,
    this.enabled = true,
    this.maxHeight,
    this.filterFn,
    this.itemAsString,
    this.showSelectedItems = false,
    this.compareFn,
    this.dropdownSearchDecoration,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.dialogMaxWidth,
    this.dropdownBuilderSupportsNullItem = false,
    this.popupShape,
    this.popupItemDisabled,
    this.popupBarrierColor,
    this.onPopupDismissed,
    this.dropdownButtonProps,
    this.onBeforeChange,
    this.favoriteItemBuilder,
    this.favoriteItems,
    this.showFavoriteItems = false,
    this.favoriteItemsAlignment = MainAxisAlignment.start,
    this.popupSafeArea = const PopupSafeAreaProps(),
    TextFieldProps? searchFieldProps,
    this.scrollbarProps,
    this.popupBarrierDismissible = true,
    this.dropdownSearchBaseStyle,
    this.dropdownSearchTextAlign,
    this.dropdownSearchTextAlignVertical,
    this.popupElevation = 8,
    this.selectionListViewProps = const SelectionListViewProps(),
    this.focusNode,
    this.positionCallback,
  })  : assert(!showSelectedItems || T == String || compareFn != null),
        searchFieldProps = searchFieldProps ?? const TextFieldProps(),
        isMultiSelectionMode = false,
        dropdownBuilderMultiSelection = null,
        validatorMultiSelection = null,
        onBeforeChangeMultiSelection = null,
        selectedItems = const [],
        onSavedMultiSelection = null,
        onChangedMultiSelection = null,
        popupOnItemAdded = null,
        popupOnItemRemoved = null,
        popupSelectionWidget = null,
        popupValidationMultiSelectionWidget = null,
        popupCustomMultiSelectionWidget = null,
        super(key: key);

  const DropdownSearch.multiSelection({
    Key? key,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.mode = Mode.dialog,
    this.isFilteredOnline = false,
    this.popupTitle,
    this.items,
    this.onFind,
    this.popupItemBuilder,
    this.showSearchBox = false,
    this.showClearButton = false,
    this.popupBackgroundColor,
    this.clearButtonProps,
    this.enabled = true,
    this.maxHeight,
    this.filterFn,
    this.itemAsString,
    this.showSelectedItems = false,
    this.compareFn,
    this.dropdownSearchDecoration,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.dropdownButtonProps,
    this.dialogMaxWidth,
    this.dropdownBuilderSupportsNullItem = false,
    this.popupShape,
    this.popupItemDisabled,
    this.popupBarrierColor,
    this.onPopupDismissed,
    this.favoriteItemBuilder,
    this.favoriteItems,
    this.showFavoriteItems = false,
    this.favoriteItemsAlignment = MainAxisAlignment.start,
    this.popupSafeArea = const PopupSafeAreaProps(),
    TextFieldProps? searchFieldProps,
    this.scrollbarProps,
    this.popupBarrierDismissible = true,
    this.dropdownSearchBaseStyle,
    this.dropdownSearchTextAlign,
    this.dropdownSearchTextAlignVertical,
    this.selectedItems = const [],
    FormFieldSetter<List<T>>? onSaved,
    ValueChanged<List<T>>? onChanged,
    BeforeChangeMultiSelection<T>? onBeforeChange,
    FormFieldValidator<List<T>>? validator,
    DropdownSearchBuilderMultiSelection<T>? dropdownBuilder,
    this.popupOnItemAdded,
    this.popupOnItemRemoved,
    this.popupSelectionWidget,
    this.popupValidationMultiSelectionWidget,
    this.popupCustomMultiSelectionWidget,
    this.popupElevation = 8,
    this.selectionListViewProps = const SelectionListViewProps(),
    this.focusNode,
    this.positionCallback,
  })  : assert(!showSelectedItems || T == String || compareFn != null),
        searchFieldProps = searchFieldProps ?? const TextFieldProps(),
        onChangedMultiSelection = onChanged,
        onSavedMultiSelection = onSaved,
        onBeforeChangeMultiSelection = onBeforeChange,
        validatorMultiSelection = validator,
        dropdownBuilderMultiSelection = dropdownBuilder,
        isMultiSelectionMode = true,
        dropdownBuilder = null,
        validator = null,
        onBeforeChange = null,
        selectedItem = null,
        onSaved = null,
        onChanged = null,
        super(key: key);

  @override
  DropdownSearchState<T> createState() => DropdownSearchState<T>();
}

class DropdownSearchState<T> extends State<DropdownSearch<T>> {
  final ValueNotifier<List<T>> _selectedItemsNotifier = ValueNotifier([]);
  final ValueNotifier<bool> _isFocused = ValueNotifier(false);
  final GlobalKey<SelectionWidgetState<T>> _popupStateKey =
      GlobalKey<SelectionWidgetState<T>>();

  @override
  void initState() {
    super.initState();
    _selectedItemsNotifier.value = isMultiSelectionMode
        ? List.from(widget.selectedItems)
        : _itemToList(widget.selectedItem);
  }

  @override
  void didUpdateWidget(DropdownSearch<T> oldWidget) {
    List<T> oldSelectedItems = isMultiSelectionMode
        ? oldWidget.selectedItems
        : _itemToList(oldWidget.selectedItem);

    List<T> newSelectedItems = isMultiSelectionMode
        ? widget.selectedItems
        : _itemToList(widget.selectedItem);

    if (!listEquals(oldSelectedItems, newSelectedItems)) {
      _selectedItemsNotifier.value = List.from(newSelectedItems);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T?>>(
      valueListenable: _selectedItemsNotifier,
      builder: (context, data, wt) {
        return IgnorePointer(
          ignoring: !widget.enabled,
          child: InkWell(
            onTap: () => _selectSearchMode(),
            child: _formField(),
          ),
        );
      },
    );
  }

  List<T> _itemToList(T? item) {
    List<T?> nullableList = List.filled(1, item);
    return nullableList.whereType<T>().toList();
  }

  Widget _defaultSelectedItemWidget() {
    Widget defaultItemMultiSelectionMode(T item) {
      return Container(
        height: 40,
        padding: const EdgeInsets.only(left: 8, bottom: 3, top: 3),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColorLight,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedItemAsString(item),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            MaterialButton(
              height: 20,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(0),
              minWidth: 20,
              onPressed: () {
                removeItem(item);
              },
              child: const Icon(
                Icons.close_outlined,
                size: 20,
              ),
            )
          ],
        ),
      );
    }

    Widget selectedItemWidget() {
      if (widget.dropdownBuilder != null) {
        return widget.dropdownBuilder!(
          context,
          getSelectedItem,
        );
      } else if (widget.dropdownBuilderMultiSelection != null) {
        return widget.dropdownBuilderMultiSelection!(
          context,
          getSelectedItems,
        );
      } else if (isMultiSelectionMode) {
        return Wrap(
          children: getSelectedItems
              .map((e) => defaultItemMultiSelectionMode(e))
              .toList(),
        );
      }
      return Text(_selectedItemAsString(getSelectedItem),
          style: Theme.of(context).textTheme.titleMedium);
    }

    return selectedItemWidget();
  }

  Widget _formField() {
    return isMultiSelectionMode
        ? _formFieldMultiSelection()
        : _formFieldSingleSelection();
  }

  Widget _formFieldSingleSelection() {
    return FormField<T>(
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode,
      initialValue: widget.selectedItem,
      builder: (FormFieldState<T> state) {
        if (state.value != getSelectedItem) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.didChange(getSelectedItem);
          });
        }
        return ValueListenableBuilder<bool>(
            valueListenable: _isFocused,
            builder: (context, isFocused, w) {
              return InputDecorator(
                baseStyle: widget.dropdownSearchBaseStyle,
                textAlign: widget.dropdownSearchTextAlign,
                textAlignVertical: widget.dropdownSearchTextAlignVertical,
                isEmpty: getSelectedItem == null &&
                    (widget.dropdownBuilder == null ||
                        widget.dropdownBuilderSupportsNullItem),
                isFocused: isFocused,
                decoration: _manageDropdownDecoration(state),
                child: _defaultSelectedItemWidget(),
              );
            });
      },
    );
  }

  Widget _formFieldMultiSelection() {
    return FormField<List<T>>(
      enabled: widget.enabled,
      onSaved: widget.onSavedMultiSelection,
      validator: widget.validatorMultiSelection,
      autovalidateMode: widget.autoValidateMode,
      initialValue: widget.selectedItems,
      builder: (FormFieldState<List<T>> state) {
        if (state.value != getSelectedItems) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.didChange(getSelectedItems);
          });
        }
        return ValueListenableBuilder<bool>(
            valueListenable: _isFocused,
            builder: (context, isFocused, w) {
              return InputDecorator(
                baseStyle: widget.dropdownSearchBaseStyle,
                textAlign: widget.dropdownSearchTextAlign,
                textAlignVertical: widget.dropdownSearchTextAlignVertical,
                isEmpty: getSelectedItems.isEmpty &&
                    (widget.dropdownBuilderMultiSelection == null ||
                        widget.dropdownBuilderSupportsNullItem),
                isFocused: isFocused,
                decoration: _manageDropdownDecoration(state),
                child: _defaultSelectedItemWidget(),
              );
            });
      },
    );
  }

  InputDecoration _manageDropdownDecoration(FormFieldState state) {
    return (widget.dropdownSearchDecoration ??
            const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
              border: OutlineInputBorder(),
            ))
        .applyDefaults(Theme.of(state.context).inputDecorationTheme)
        .copyWith(
          enabled: widget.enabled,
          suffixIcon:
              widget.dropdownButtonProps == null ? null : _manageSuffixIcons(),
          errorText: state.errorText,
        );
  }

  String _selectedItemAsString(T? data) {
    if (data == null) {
      return "";
    } else if (widget.itemAsString != null) {
      return widget.itemAsString!(data);
    } else {
      return data.toString();
    }
  }

  Widget _manageSuffixIcons() {
    clearButtonPressed() => clear();
    dropdownButtonPressed() => _selectSearchMode();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        if (widget.showClearButton == true && getSelectedItems.isNotEmpty)
          IconButton(
            icon: widget.clearButtonProps?.icon ??
                const Icon(Icons.clear, size: 24),
            onPressed: clearButtonPressed,
            constraints: widget.clearButtonProps?.constraints,
            hoverColor: widget.clearButtonProps?.hoverColor,
            highlightColor: widget.clearButtonProps?.highlightColor,
            splashColor: widget.clearButtonProps?.splashColor,
            color: widget.clearButtonProps?.color,
            focusColor: widget.clearButtonProps?.focusColor,
            iconSize: widget.clearButtonProps?.iconSize ?? 24.0,
            padding:
                widget.clearButtonProps?.padding ?? const EdgeInsets.all(8.0),
            splashRadius: widget.clearButtonProps?.splashRadius,
            alignment: widget.clearButtonProps?.alignment ?? Alignment.center,
            autofocus: widget.clearButtonProps?.autofocus ?? false,
            disabledColor: widget.clearButtonProps?.disabledColor,
            enableFeedback: widget.clearButtonProps?.enableFeedback ?? false,
            focusNode: widget.clearButtonProps?.focusNode,
            mouseCursor: widget.clearButtonProps?.mouseCursor ??
                SystemMouseCursors.click,
            tooltip: widget.clearButtonProps?.tooltip,
            visualDensity: widget.clearButtonProps?.visualDensity,
          ),
        IconButton(
          icon: widget.dropdownButtonProps?.icon ??
              const Icon(Icons.arrow_drop_down, size: 24),
          onPressed: dropdownButtonPressed,
          constraints: widget.dropdownButtonProps?.constraints,
          hoverColor: widget.dropdownButtonProps?.hoverColor,
          highlightColor: widget.dropdownButtonProps?.highlightColor,
          splashColor: widget.dropdownButtonProps?.splashColor,
          color: widget.dropdownButtonProps?.color,
          focusColor: widget.dropdownButtonProps?.focusColor,
          iconSize: widget.dropdownButtonProps?.iconSize ?? 24.0,
          padding:
              widget.dropdownButtonProps?.padding ?? const EdgeInsets.all(8.0),
          splashRadius: widget.dropdownButtonProps?.splashRadius,
          alignment: widget.dropdownButtonProps?.alignment ?? Alignment.center,
          autofocus: widget.dropdownButtonProps?.autofocus ?? false,
          disabledColor: widget.dropdownButtonProps?.disabledColor,
          enableFeedback: widget.dropdownButtonProps?.enableFeedback ?? false,
          focusNode: widget.dropdownButtonProps?.focusNode,
          mouseCursor: widget.dropdownButtonProps?.mouseCursor ??
              SystemMouseCursors.click,
          tooltip: widget.dropdownButtonProps?.tooltip,
          visualDensity: widget.dropdownButtonProps?.visualDensity,
        ),
      ],
    );
  }

  Future _openSelectDialog() {
    return showGeneralDialog(
      barrierDismissible: widget.popupBarrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 400),
      barrierColor: widget.popupBarrierColor ?? const Color(0x80000000),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          top: widget.popupSafeArea.top,
          bottom: widget.popupSafeArea.bottom,
          left: widget.popupSafeArea.left,
          right: widget.popupSafeArea.right,
          child: AlertDialog(
            elevation: widget.popupElevation,
            contentPadding: const EdgeInsets.all(0),
            shape: widget.popupShape,
            backgroundColor: widget.popupBackgroundColor,
            content: _selectDialogInstance(),
          ),
        );
      },
    );
  }

  Future _openBottomSheet() {
    return showModalBottomSheetCustom<T>(
        barrierColor: widget.popupBarrierColor,
        backgroundColor: Colors.transparent,
        isDismissible: widget.popupBarrierDismissible,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          final MediaQueryData mediaQueryData = MediaQuery.of(ctx);
          EdgeInsets padding = mediaQueryData.padding;
          if (mediaQueryData.padding.bottom == 0.0 &&
              mediaQueryData.viewInsets.bottom != 0.0) {
            padding =
                padding.copyWith(bottom: mediaQueryData.viewPadding.bottom);
          }

          return AnimatedPadding(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
            ),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: widget.popupSafeArea.top ? padding.top : 0,
                  ),
                  child: Material(
                    color: widget.popupBackgroundColor ??
                        Theme.of(ctx).canvasColor,
                    shape: widget.popupShape,
                    clipBehavior: Clip.antiAlias,
                    elevation: widget.popupElevation,
                    child: SafeArea(
                      top: false,
                      bottom: widget.popupSafeArea.bottom,
                      left: widget.popupSafeArea.left,
                      right: widget.popupSafeArea.right,
                      child: _selectDialogInstance(defaultHeight: 350),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  behavior: HitTestBehavior.translucent,
                  child: SizedBox(
                    height: widget.popupSafeArea.top ? padding.top : 0,
                    width: double.infinity,
                  ),
                )
              ],
            ),
          );
        });
  }

  RelativeRect _position(RenderBox popupButtonObject, RenderBox overlay) {
    return RelativeRect.fromSize(
      Rect.fromPoints(
        popupButtonObject.localToGlobal(
            popupButtonObject.size.bottomLeft(Offset.zero),
            ancestor: overlay),
        popupButtonObject.localToGlobal(
            popupButtonObject.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Size(overlay.size.width, overlay.size.height),
    );
  }

  Future _openMenu() {
    final popupButtonObject = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    return customShowMenu<T>(
        popupSafeArea: widget.popupSafeArea,
        barrierColor: widget.popupBarrierColor,
        shape: widget.popupShape,
        color: widget.popupBackgroundColor,
        context: context,
        position:
            (widget.positionCallback ?? _position)(popupButtonObject, overlay),
        elevation: widget.popupElevation,
        barrierDismissible: widget.popupBarrierDismissible,
        items: [
          CustomPopupMenuItem(
            child: SizedBox(
              width: popupButtonObject.size.width,
              child: _selectDialogInstance(defaultHeight: 224),
            ),
          ),
        ]);
  }

  Widget _selectDialogInstance({double? defaultHeight}) {
    return SelectionWidget<T>(
      key: Key("$defaultHeight"),
      popupTitle: widget.popupTitle,
      maxHeight: widget.maxHeight ?? defaultHeight,
      isFilteredOnline: widget.isFilteredOnline,
      itemAsString: widget.itemAsString,
      filterFn: widget.filterFn,
      items: widget.items,
      onFind: widget.onFind,
      showSearchBox: widget.showSearchBox,
      itemBuilder: widget.popupItemBuilder,
      selectedValues: List.from(getSelectedItems),
      onChanged: _handleOnChangeSelectedItems,
      showSelectedItems: widget.showSelectedItems,
      compareFn: widget.compareFn,
      emptyBuilder: widget.emptyBuilder,
      loadingBuilder: widget.loadingBuilder,
      errorBuilder: widget.errorBuilder,
      dialogMaxWidth: widget.dialogMaxWidth,
      itemDisabled: widget.popupItemDisabled,
      showFavoriteItems: widget.showFavoriteItems,
      favoriteItems: widget.favoriteItems,
      favoriteItemBuilder: widget.favoriteItemBuilder,
      favoriteItemsAlignment: widget.favoriteItemsAlignment,
      searchFieldProps: widget.searchFieldProps,
      scrollbarProps: widget.scrollbarProps,
      onBeforeChangeMultiSelection: widget.onBeforeChangeMultiSelection,
      popupOnItemAdded: widget.popupOnItemAdded,
      popupOnItemRemoved: widget.popupOnItemRemoved,
      popupSelectionWidget: widget.popupSelectionWidget,
      popupValidationMultiSelectionWidget:
          widget.popupValidationMultiSelectionWidget,
      popupCustomMultiSelectionWidget: widget.popupCustomMultiSelectionWidget,
      isMultiSelectionMode: isMultiSelectionMode,
      selectionListViewProps: widget.selectionListViewProps,
      focusNode: widget.focusNode ?? FocusNode(),
    );
  }

  void _handleFocus(bool isFocused) {
    if (isFocused && !_isFocused.value) {
      FocusScope.of(context).unfocus();
      _isFocused.value = true;
    } else if (!isFocused && _isFocused.value) {
      _isFocused.value = false;
    }
  }

  void _handleOnChangeSelectedItems(List<T> selectedItems) {
    changeItem() {
      _selectedItemsNotifier.value = List.from(selectedItems);
      if (widget.onChanged != null) {
        widget.onChanged!(getSelectedItem);
      } else if (widget.onChangedMultiSelection != null) {
        widget.onChangedMultiSelection!(selectedItems);
      }
    }

    if (widget.onBeforeChange != null) {
      widget.onBeforeChange!(getSelectedItem,
              selectedItems.isEmpty ? null : selectedItems.first)
          .then((value) {
        if (value == true) {
          changeItem();
        }
      });
    } else if (widget.onBeforeChangeMultiSelection != null) {
      widget.onBeforeChangeMultiSelection!(getSelectedItems, selectedItems)
          .then((value) {
        if (value == true) {
          changeItem();
        }
      });
    } else {
      changeItem();
    }

    _handleFocus(false);
  }

  bool _isEqual(T i1, T i2) {
    if (widget.compareFn != null) {
      return widget.compareFn!(i1, i2);
    } else {
      return i1 == i2;
    }
  }

  Future _selectSearchMode() async {
    _handleFocus(true);
    if (widget.mode == Mode.menu) {
      await _openMenu();
    } else if (widget.mode == Mode.bottomSheet) {
      await _openBottomSheet();
    } else {
      await _openSelectDialog();
    }
    _handleFocus(false);
    widget.onPopupDismissed?.call();
  }

  void changeSelectedItem(T? selectedItem) =>
      _handleOnChangeSelectedItems(_itemToList(selectedItem));
  void changeSelectedItems(List<T> selectedItems) =>
      _handleOnChangeSelectedItems(selectedItems);
  void removeItem(T itemToRemove) => _handleOnChangeSelectedItems(
      getSelectedItems..removeWhere((i) => _isEqual(itemToRemove, i)));
  void clear() => _handleOnChangeSelectedItems([]);
  T? get getSelectedItem =>
      getSelectedItems.isEmpty ? null : getSelectedItems.first;
  List<T> get getSelectedItems => _selectedItemsNotifier.value;
  bool get isFocused => _isFocused.value;
  bool get isMultiSelectionMode => widget.isMultiSelectionMode;
  void popupDeselectItems(List<T> itemsToDeselect) {
    _popupStateKey.currentState?.deselectItems(itemsToDeselect);
  }

  void popupDeselectAllItems() {
    _popupStateKey.currentState?.deselectAllItems();
  }

  void popupSelectAllItems() {
    _popupStateKey.currentState?.selectAllItems();
  }

  void popupSelectItems(List<T> itemsToSelect) {
    _popupStateKey.currentState?.deselectItems(itemsToSelect);
  }

  void popupOnValidate() {
    _popupStateKey.currentState?.onValidate();
  }

  void openDropDownSearch() => _selectSearchMode();
  void closeDropDownSearch() => _popupStateKey.currentState?.closePopup();
}
