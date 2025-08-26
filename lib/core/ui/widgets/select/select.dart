import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'select_menu_item.dart';

class Select<T extends Object> extends StatefulWidget {
  Select({
    super.key,
    this.value,
    this.onChanged,
    required this.options,
  }) : assert(
         value == null ||
             options == null ||
             options.isEmpty ||
             options.where((e) => e.value == value).isNotEmpty,
         "Select value must be null or one of the options values",
       );

  final List<SelectOption<T>>? options;
  final T? value;
  final ValueChanged<T>? onChanged;

  @override
  State<Select<T>> createState() => _SelectState<T>();
}

class _SelectState<T extends Object> extends State<Select<T>> {
  bool _isHovered = false;

  final _buttonKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  late SelectOption<T>? _currentValue;

  List<SelectOption<T>> get _options => widget.options ?? [];

  void _showOverlay() {
    final renderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final screenSize = MediaQuery.of(context).size;

    var dx = offset.dx;
    var dy = offset.dy + size.height;

    var alignment = Alignment.topLeft;

    if (dx + 100 > screenSize.width) {
      dy = offset.dy - size.height;
      alignment = Alignment.bottomLeft;
    }

    if (dx + 200 > screenSize.width) {
      dx = screenSize.width - 200;
      alignment = (alignment == Alignment.topLeft)
          ? Alignment.topRight
          : Alignment.bottomRight;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final options = _options
            .map(
              (entry) => SelectOptionItem<T>(
                entry: entry,
                selected: entry.value == _currentValue?.value,
                onClicked: () {
                  _hideOverlay();
                  widget.onChanged?.call(entry.value);
                },
              ),
            )
            .toList();

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _hideOverlay,
                behavior: HitTestBehavior.translucent,
                child: Container(),
              ),
            ),

            Positioned(
              left: dx,
              top: dy,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: alignment,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [...options],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void initState() {
    super.initState();
    _currentValue = _options.firstWhere(
      (element) => element.value == widget.value,
      orElse: () => _options.first,
    );
  }

  @override
  void didUpdateWidget(covariant Select<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _currentValue = _options.firstWhere(
        (element) => element.value == widget.value,
        orElse: () => _options.first,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        key: _buttonKey,
        onTap: _showOverlay,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: _isHovered ? Colors.grey.withValues(alpha: 0.1) : null,
          ),
          child: Row(
            spacing: 4.0,
            children: [
              Text(
                _currentValue?.label ?? '',
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _currentValue?.color,
                ),
              ),
              Icon(
                Symbols.expand_all_rounded,
                size: 14,
                color: _currentValue?.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
