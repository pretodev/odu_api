import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:odu_api/app/commands/send_request.dart';
import 'package:odu_api/app/data/api/url/api_url.dart';
import 'package:odu_api/app/data/api/url/methods.dart';
import 'package:odu_api/app/ui/main/widgets/endpoint_path_field.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  var _requestUrl = ApiUrl(
    method: ClassicHttpMethod(HttpMethodOptions.get),
    base: 'https://brasilapi.com.br/api',
    path: '',
  );

  @override
  Widget build(BuildContext context) {
    final sendRequest = ref.read(sendRequestProvider.notifier);
    final sendRequestResult = ref.watch(sendRequestProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              spacing: 8.0,
              children: [
                Expanded(
                  child: EndpointPathField(
                    url: _requestUrl,
                    onChanged: (value) {
                      setState(() => _requestUrl = value);
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    sendRequest(_requestUrl);
                  },
                  child: const Text('Enviar'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text('Salvar'),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            if (sendRequestResult is AsyncData)
              Text(sendRequestResult.value.toString()),
            if (sendRequestResult is AsyncError)
              Text(sendRequestResult.error.toString()),
          ],
        ),
      ),
    );
  }
}
