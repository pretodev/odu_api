import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:loader_overlay/loader_overlay.dart';
import 'package:odu_api/app/commands/save_endpoint.dart';
import 'package:odu_api/app/commands/send_request.dart';
import 'package:odu_api/app/data/api/url/api_url.dart';
import 'package:odu_api/app/data/api/url/methods.dart';
import 'package:odu_api/app/data/endpoints/endpoint.dart';
import 'package:odu_api/app/ui/main/widgets/body_visualizer/body_visualizer.dart';
import 'package:odu_api/app/ui/main/widgets/endpoint_path_field.dart';
import 'package:odu_api/app/ui/main/widgets/explorer/explorer.dart';

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
    ref.listen(sendRequestProvider, (previous, next) {
      if (next is AsyncLoading) {
        return context.loaderOverlay.show();
      }
      return context.loaderOverlay.hide();
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          spacing: 12.0,
          children: [
            Explorer(),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.02),
                      spreadRadius: 1.0,
                      blurRadius: 0.0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
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
                        FilledButton(
                          style: FilledButton.styleFrom(
                            minimumSize: Size(100.0, 50.0),
                          ),
                          onPressed: () {
                            sendRequest(_requestUrl);
                          },
                          child: const Text('Enviar'),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(100.0, 50.0),
                          ),
                          onPressed: () async {
                            final saveEndpoint = ref.read(
                              saveEndpointProvider.notifier,
                            );
                            await saveEndpoint(Endpoint(_requestUrl));
                          },
                          child: const Text('Salvar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: BodyVisualizer(
                        response: switch (sendRequestResult) {
                          AsyncData(value: final v) => v,
                          _ => null,
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
