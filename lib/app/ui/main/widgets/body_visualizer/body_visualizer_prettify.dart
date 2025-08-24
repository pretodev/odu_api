part of "body_visualizer.dart";

void formatBody() {}

abstract class BodyPrettifier {
  const BodyPrettifier(this.rawContent);

  final String rawContent;

  String prettify();
}

class BodyTextPrettifier extends BodyPrettifier {
  BodyTextPrettifier(super.rawContent);

  @override
  String prettify() {
    return rawContent;
  }
}

class BodyXmlHtmlVisualizerFormatter extends BodyPrettifier {
  BodyXmlHtmlVisualizerFormatter(super.rawContent);

  @override
  String prettify() {
    final lines = rawContent.replaceAll('><', '>\n<').split('\n');
    final buffer = StringBuffer();
    int indentLevel = 0;

    for (String line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;
      if (trimmed.startsWith('</')) {
        indentLevel = (indentLevel - 1).clamp(0, double.infinity).toInt();
      }
      buffer.writeln('${'  ' * indentLevel}$trimmed');
      if (trimmed.startsWith('<') &&
          !trimmed.startsWith('</') &&
          !trimmed.endsWith('/>')) {
        indentLevel++;
      }
    }
    return buffer.toString();
  }
}

class BodyJsonVisualizerFormatter extends BodyPrettifier {
  BodyJsonVisualizerFormatter(super.rawContent);

  @override
  String prettify() {
    try {
      final decoded = jsonDecode(rawContent);
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(decoded);
    } catch (e) {
      return rawContent;
    }
  }
}

extension ApiRequestExtension on ApiResponse {
  String get prettifiedBody {
    if (body == null) return '';
    final prettifier = switch (contentType) {
      ContentType.json => BodyJsonVisualizerFormatter(body!),
      ContentType.html => BodyXmlHtmlVisualizerFormatter(body!),
      ContentType.xml => BodyXmlHtmlVisualizerFormatter(body!),
      ContentType.text => BodyTextPrettifier(body!),
    };
    return prettifier.prettify();
  }
}
