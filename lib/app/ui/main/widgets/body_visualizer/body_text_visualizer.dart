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

  static const _fontSize = 14.0;
  static const _lineHeight = 1.2;
  static const _vPad = 16.0;

  @override
  void initState() {
    super.initState();
    _verticalScrollController = ScrollController();
    _horizontalScrollController = ScrollController();
    _lineNumberScrollController = ScrollController();

    _verticalScrollController.addListener(_onVerticalScroll);
  }

  void _onVerticalScroll() {
    if (!_lineNumberScrollController.hasClients) return;

    final max = _lineNumberScrollController.position.maxScrollExtent;
    final target = _verticalScrollController.offset.clamp(0.0, max);

    if ((_lineNumberScrollController.offset - target).abs() > 0.5) {
      _lineNumberScrollController.jumpTo(target);
    }
  }

  @override
  void dispose() {
    _verticalScrollController.removeListener(_onVerticalScroll);
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
      fontSize: _fontSize,
      height: _lineHeight,
    );

    final lineExtent = _fontSize * _lineHeight;

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
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                controller: _lineNumberScrollController,
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: _vPad,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(
                      lines.length,
                      (index) => SizedBox(
                        height: lineExtent,
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
              physics: const ClampingScrollPhysics(),
              child: SingleChildScrollView(
                controller: _verticalScrollController,
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(_vPad),
                  child: SelectableText(
                    widget.content,
                    style: textStyle,
                    strutStyle: const StrutStyle(
                      fontSize: _fontSize,
                      height: _lineHeight,
                      forceStrutHeight: true,
                    ),
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
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
