import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            style: GoogleFonts.firaCode(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: "caminho/do/endpoint",
              hintStyle: GoogleFonts.firaCode(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey.withValues(alpha: 0.8),
              ),
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
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.3),
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      "${widget.url.base}/",
                      style: GoogleFonts.firaCode(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
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
