import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:odu_api/app/data/api/api_response.dart';
import 'package:odu_api/core/ui/widgets/select/select.dart';

part 'body_html_visualizer.dart';
part 'body_text_visualizer.dart';
part 'body_visualizer_prettify.dart';

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

  String get _formattedContent {
    if (_currentViewMode == ViewMode.pretty) {
      return widget.response?.prettifiedBody ?? '';
    }
    return widget.response?.body ?? '';
  }

  Widget _buildContentViewer() {
    if (_currentViewMode == ViewMode.preview &&
        _currentContentType == ContentType.html) {
      return BodyHtmlVisualizer(content: widget.response?.body ?? "");
    }
    if (_currentViewMode == ViewMode.raw ||
        _currentViewMode == ViewMode.pretty) {
      return BodyTextVisualizer(content: _formattedContent);
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SelectableText(
          _formattedContent,
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
  void didUpdateWidget(covariant BodyVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.response != widget.response) {
      setState(() {
        _currentContentType = widget.response?.contentType ?? ContentType.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.response?.body == null) {
      return const Center(
        child: Text(
          'Nenhum conteúdo disponível',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Column(
      spacing: 12.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Select(
              value: _currentContentType,
              onChanged: (value) {
                setState(() => _currentContentType = value);
              },
              options: [
                SelectOption(value: ContentType.json, label: 'JSON'),
                SelectOption(value: ContentType.html, label: 'HTML'),
                SelectOption(value: ContentType.xml, label: 'XML'),
                SelectOption(value: ContentType.text, label: 'Text'),
              ],
            ),
          ],
        ),
        Expanded(
          child: _buildContentViewer(),
        ),
      ],
    );
  }
}
