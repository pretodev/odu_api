part of "body_visualizer.dart";

class BodyTextVisualizer extends StatefulWidget {
  const BodyTextVisualizer({
    super.key,
    required this.content,
  });

  final String content;

  @override
  State<BodyTextVisualizer> createState() => _BodyTextVisualizerState();
}

class _BodyTextVisualizerState extends State<BodyTextVisualizer> {
  late final ScrollController _verticalScrollController;
  late final ScrollController _horizontalScrollController;
  late final ScrollController _lineNumberScrollController;

  @override
  void initState() {
    super.initState();
    _verticalScrollController = ScrollController();
    _horizontalScrollController = ScrollController();
    _lineNumberScrollController = ScrollController();

    _verticalScrollController.addListener(() {
      if (_lineNumberScrollController.hasClients) {
        _lineNumberScrollController.jumpTo(_verticalScrollController.offset);
      }
    });
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    _lineNumberScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lines = widget.content.split('\n');
    const textStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 14,
      height: 1.2,
    );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
              ),
              child: SingleChildScrollView(
                controller: _lineNumberScrollController,
                physics: const NeverScrollableScrollPhysics(),

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(
                      lines.length,
                      (index) => SizedBox(
                        height: textStyle.fontSize! * (textStyle.height ?? 1.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontFamily: textStyle.fontFamily,
                              fontSize: 12,
                              height: textStyle.height,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              controller: _horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                controller: _verticalScrollController,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    widget.content,
                    style: textStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
