import 'package:flutter/material.dart';
import 'package:habari_pay_cs/utils/env_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.checkoutUrl, required this.onComplete});

  final String checkoutUrl;
  final VoidCallback onComplete;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    debugPrint("This Checkout URL: ${widget.checkoutUrl}");

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onNavigationRequest: (request) {
        final callbackUrl = Environment.callbackurl;
        if (request.url.contains(callbackUrl)) {
          Future.delayed(Duration(milliseconds: 400), () => widget.onComplete());
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }))
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
