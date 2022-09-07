import 'package:flutter/material.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String deeplinkUrl =
        ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: const OtaAppBar(),
      body: WebView(
        initialUrl: deeplinkUrl,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) async {
          if (request.url.startsWith(_kRobinhoodUrlScheme)) {
            if (await canLaunchUrlString(request.url)) {
              launchUrlString(
                request.url,
                mode: LaunchMode.externalApplication,
              );
              Navigator.of(context).pop();
            }
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}

const _kRobinhoodUrlScheme = 'robinhoodth:';
