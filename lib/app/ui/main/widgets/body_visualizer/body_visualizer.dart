import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:odu_api/app/data/api/api_response.dart';

part 'body_html_visualizer.dart';
part 'body_text_visualizer.dart';

enum ViewMode { pretty, raw, preview }

class BodyVisualizer extends StatefulWidget {
  const BodyVisualizer({super.key, required this.response});

  final ApiResponse? response;

  @override
  State<BodyVisualizer> createState() => _BodyVisualizerState();
}

class _BodyVisualizerState extends State<BodyVisualizer> {
  ViewMode _currentViewMode = ViewMode.pretty;
  ContentType _currentContentType = ContentType.json;

  String _formatContent(String? content) {
    if (content == null || content.isEmpty) return '';

    if (_currentViewMode == ViewMode.raw) {
      return content;
    }

    if (_currentViewMode == ViewMode.pretty) {
      switch (_currentContentType) {
        case ContentType.json:
          try {
            final decoded = jsonDecode(content);
            const encoder = JsonEncoder.withIndent('  ');
            return encoder.convert(decoded);
          } catch (e) {
            return content;
          }
        case ContentType.html:
        case ContentType.xml:
          return _formatXmlHtml(content);
        case ContentType.text:
          return content;
      }
    }

    return content;
  }

  String _formatXmlHtml(String content) {
    // Formatação básica para XML/HTML
    String formatted = content;
    formatted = formatted.replaceAll('><', '>\n<');

    final lines = formatted.split('\n');
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

  Widget _buildContentViewer() {
    if (widget.response?.body == null) {
      return const Center(
        child: Text(
          'Nenhum conteúdo disponível',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    if (_currentViewMode == ViewMode.preview &&
        _currentContentType == ContentType.html) {
      return BodyHtmlVisualizer(
        content: widget.response?.body ?? "",
      );
    }

    final formattedContent = _formatContent(widget.response!.body);

    if (_currentViewMode == ViewMode.raw ||
        _currentViewMode == ViewMode.pretty) {
      return BodyTextVisualizer(content: formattedContent);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SelectableText(
          formattedContent,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _currentContentType = widget.response?.contentType ?? ContentType.text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.0,
          children: [
            SegmentedButton<ViewMode>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: ViewMode.pretty,
                  label: Text('Pretty'),
                ),
                ButtonSegment(
                  value: ViewMode.raw,
                  label: Text('Raw'),
                ),
                ButtonSegment(
                  value: ViewMode.preview,
                  label: Text('Preview'),
                ),
              ],
              selected: {_currentViewMode},
              onSelectionChanged: (selection) {
                setState(() => _currentViewMode = selection.first);
              },
            ),
            DropdownButton<ContentType>(
              value: _currentContentType,
              items: const [
                DropdownMenuItem(
                  value: ContentType.json,
                  child: Text('JSON'),
                ),
                DropdownMenuItem(
                  value: ContentType.html,
                  child: Text('HTML'),
                ),
                DropdownMenuItem(
                  value: ContentType.xml,
                  child: Text('XML'),
                ),
                DropdownMenuItem(
                  value: ContentType.text,
                  child: Text('Text'),
                ),
              ],
              onChanged: (value) {
                setState(() => _currentContentType = value!);
              },
            ),
          ],
        ),
        const Divider(),
        Expanded(
          child: _buildContentViewer(),
        ),
      ],
    );
  }
}
