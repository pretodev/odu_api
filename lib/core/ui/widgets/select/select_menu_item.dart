part of 'select.dart';

class SelectOption<T extends Object> {
  final T value;
  final String label;
  final Color? color;

  SelectOption({
    required this.value,
    required this.label,
    this.color,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectOption<T> &&
        other.value == value &&
        other.label == label &&
        other.color == color;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode ^ color.hashCode;
}

class SelectOptionItem<T extends Object> extends StatefulWidget {
  const SelectOptionItem({
    super.key,
    required this.entry,
    this.onClicked,
    this.selected = false,
  });

  final SelectOption<T> entry;
  final VoidCallback? onClicked;
  final bool selected;

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
            color: widget.selected
                ? Colors.grey.withValues(alpha: 0.2)
                : _isHovered
                ? Colors.grey.withValues(alpha: 0.1)
                : null,
          ),
          child: Text(
            widget.entry.label,
            style: TextStyle(
              color: widget.entry.color,
            ),
          ),
        ),
      ),
    );
  }
}
