part of "body_visualizer.dart";

class BodyHtmlVisualizer extends StatefulWidget {
  const BodyHtmlVisualizer({
    super.key,
    required this.content,
  });

  final String content;

  @override
  State<BodyHtmlVisualizer> createState() => _BodyHtmlVisualizerState();
}

class _BodyHtmlVisualizerState extends State<BodyHtmlVisualizer> {
  @override
  void initState() {
    super.initState();
  }

  String _buildHtmlContent() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? '#121212' : '#ffffff';
    final textColor = isDark ? '#ffffff' : '#000000';
    final codeBackgroundColor = isDark ? '#2d2d2d' : '#f5f5f5';

    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            font-size: 14px;
            line-height: 1.4;
            color: $textColor;
            background-color: $backgroundColor;
            margin: 16px;
            padding: 0;
        }
        p {
            margin: 0 0 8px 0;
        }
        h1, h2, h3, h4, h5, h6 {
            margin: 16px 0 8px 0;
            font-weight: bold;
        }
        pre {
            background-color: $codeBackgroundColor;
            padding: 12px;
            margin: 8px 0;
            border-radius: 4px;
            overflow-x: auto;
        }
        code {
            background-color: $codeBackgroundColor;
            padding: 2px 4px;
            border-radius: 2px;
            font-family: 'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, 'Courier New', monospace;
        }
        pre code {
            background-color: transparent;
            padding: 0;
        }
        blockquote {
            margin: 8px 0;
            padding-left: 16px;
            border-left: 4px solid #2196F3;
        }
        img {
            max-width: 100%;
            height: auto;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 8px 0;
        }
        th, td {
            border: 1px solid ${isDark ? '#444' : '#ddd'};
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: $codeBackgroundColor;
        }
    </style>
</head>
<body>
${widget.content}
</body>
</html>
''';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: InAppWebView(
          initialData: InAppWebViewInitialData(
            data: _buildHtmlContent(),
            mimeType: 'text/html',
            encoding: 'utf8',
          ),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            transparentBackground: true,
            supportZoom: false,
            disableHorizontalScroll: false,
            disableVerticalScroll: false,
          ),
          onWebViewCreated: (controller) {
            // WebView criada
          },
          onLoadStop: (controller, url) async {
            // WebView carregada
          },
        ),
      ),
    );
  }
}
