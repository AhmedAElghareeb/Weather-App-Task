import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewWidget extends StatefulWidget {
  const PaymentWebViewWidget({
    super.key,
    required this.redirectPaymentUrl,
    required this.callBackKey,
    required this.successKey,
    required this.failedKey,
    required this.onSuccess,
    required this.onFailed,
  });

  final String redirectPaymentUrl;
  final String callBackKey;
  final String successKey, failedKey;
  final VoidCallback onSuccess, onFailed;

  @override
  State<PaymentWebViewWidget> createState() => _PaymentWebViewWidgetState();
}

class _PaymentWebViewWidgetState extends State<PaymentWebViewWidget> {
  final WebViewController webViewController = WebViewController();

  //Its keys returned from backend dev
  late String successKey;
  late String failedKey;

  late String callBackKey;

  @override
  void initState() {
    super.initState();
    successKey = widget.successKey;
    failedKey = widget.failedKey;
    callBackKey = widget.callBackKey;
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(const Color(0x00000000));
    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          debugPrint('onProgress => $progress');
        },
        onPageStarted: (String url) {
          debugPrint('onPageStarted => $url');
        },
        onPageFinished: (String url) {
          debugPrint('onPageFinished => $url');
          debugPrint('onPageFinished contains => ${url.contains(callBackKey)}');
          if (url.contains(callBackKey)) {
            //runJavaScript is used for executing JavaScript code without expecting a return value,
            //while runJavaScriptReturningResult is used when you need to execute JavaScript code and retrieve a result or value from the WebView.
            webViewController.runJavaScriptReturningResult(
                "(function(){Flutter.postMessage(window.document.body.outerHTML)})();");
          }
        },
        onWebResourceError: (WebResourceError error) {
          debugPrint('onWebResourceError => ${error.description}');
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.google.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
    webViewController.addJavaScriptChannel(
      'Flutter',
      onMessageReceived: (JavaScriptMessage javaScriptMessage) {
        final String pageBody = javaScriptMessage.message;
        debugPrint('page body: $pageBody');
        if (pageBody.contains(successKey)) {
          //Navigate to confirmation page and next to orders
          widget.onSuccess();
        } else if (pageBody.contains(failedKey)) {
          //Navigate to home page, show failed message and to home page
          widget.onFailed();
        }
      },
    );
    webViewController.loadRequest(
      Uri.parse(widget.redirectPaymentUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: webViewController);
  }
}