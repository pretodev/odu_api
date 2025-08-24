part of 'select.dart';

class SelectOptionItem<T extends Object> extends StatefulWidget {
  const SelectOptionItem({
    super.key,
    required this.entry,
    this.onClicked,
  });

  final SelectOption<T> entry;
  final VoidCallback? onClicked;

  @override
  State<SelectOptionItem<T>> createState() => _SelectOptionItemState<T>();
}

class _SelectOptionItemState<T extends Object>
    extends State<SelectOptionItem<T>> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onClicked,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: _isHovered ? Colors.grey.withValues(alpha: 0.1) : null,
          ),
          child: Text(
            widget.entry.label,
          ),
        ),
      ),
    );
  }
}
