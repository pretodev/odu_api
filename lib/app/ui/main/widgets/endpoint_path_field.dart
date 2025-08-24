import 'package:flutter/material.dart';
import 'package:odu_api/app/data/api/url/api_url.dart';
import 'package:odu_api/app/data/api/url/methods.dart';

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

  DropdownMenuItem<ClassicHttpMethod> _buildDropdownMenuItem(
    HttpMethodOptions option,
  ) {
    final data = ClassicHttpMethod(option);
    final color = switch (option) {
      HttpMethodOptions.get => Colors.green,
      HttpMethodOptions.head => Colors.green,
      HttpMethodOptions.post => Colors.yellow,
      HttpMethodOptions.put => Colors.orangeAccent,
      HttpMethodOptions.patch => Colors.orangeAccent,
      HttpMethodOptions.delete => Colors.redAccent,
      HttpMethodOptions.options => Colors.blueGrey,
    };
    return DropdownMenuItem(
      value: data,
      child: Text(
        data.name,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }

  HttpMethod method = ClassicHttpMethod(HttpMethodOptions.get);

  void _setMethod(HttpMethod? value) {
    if (value == null) return;
    setState(() => method = value);
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
    return TextField(
      controller: _pathController,
      decoration: InputDecoration(
        hintText: "caminho/do/endpoint",

        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 8.0),
            DropdownButton(
              value: method,
              items: HttpMethodOptions.values
                  .map(_buildDropdownMenuItem)
                  .toList(),
              onChanged: _setMethod,
              isDense: true,
              underline: SizedBox.shrink(),
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
    );
  }
}
