import 'package:flutter/material.dart';
import 'package:odu_api/app/data/api/url/api_url.dart';
import 'package:odu_api/app/data/api/url/methods.dart';
import 'package:odu_api/core/ui/widgets/select/select.dart';

class EndpointPathField extends StatefulWidget {
  const EndpointPathField({
    super.key,
    required this.url,
    this.onChanged,
  });

  final ApiUrl url;
  final ValueChanged<ApiUrl>? onChanged;

  @override
  State<EndpointPathField> createState() => _EndpointPathFieldState();
}

class _EndpointPathFieldState extends State<EndpointPathField> {
  final _pathController = TextEditingController();

  Color _methodColor(ClassicHttpMethod method) {
    return switch (method.method) {
      HttpMethodOptions.get => Colors.green,
      HttpMethodOptions.head => Colors.green,
      HttpMethodOptions.post => Colors.yellow,
      HttpMethodOptions.put => Colors.orangeAccent,
      HttpMethodOptions.patch => Colors.orangeAccent,
      HttpMethodOptions.delete => Colors.redAccent,
      HttpMethodOptions.options => Colors.blueGrey,
    };
  }

  SelectOption<HttpMethod> _buildSelectOption(
    HttpMethodOptions option,
  ) {
    final data = ClassicHttpMethod(option);
    return SelectOption(
      label: data.name,
      value: data,
      color: _methodColor(data),
    );
  }

  HttpMethod _method = ClassicHttpMethod(HttpMethodOptions.get);

  void _setMethod(HttpMethod? value) {
    if (value == null) return;
    setState(() => _method = value);
    widget.onChanged?.call(
      widget.url.copyWith(
        method: value,
        path: _pathController.text,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _pathController.addListener(() {
      widget.onChanged?.call(
        widget.url.copyWith(
          path: _pathController.text,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _pathController,
            decoration: InputDecoration(
              hintText: "caminho/do/endpoint",
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 8.0),
                  Select(
                    value: _method,
                    options: HttpMethodOptions.values
                        .map(_buildSelectOption)
                        .toList(),
                    onChanged: _setMethod,
                  ),
                  Text(
                    "${widget.url.base}/",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
