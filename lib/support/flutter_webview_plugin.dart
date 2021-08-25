import 'package:flutter/services.dart';

class FlutterWebviewPlugin {
  static const _platform = const MethodChannel("WebViewChannel");

  static void goBack() {
    _platform.invokeMethod("goBack");
  }

  static void startView(String link) {
    _platform.invokeMethod("startView", <String, dynamic>{'link': link});
  }
}

class AdvertisingIdPlugin {
  static const _platform = const MethodChannel("AdvertisingIdChannel");

  static Future<String> getAdvertisingId() async {
    return _platform.invokeMethod("getAdvertisingId");
  }
}

class FacebookAppLinkPlugin {
  static const _platform = const MethodChannel("FacebookAppLinkChannel");

  static Future<String> fetchFacebookAppLink() async {
    return _platform.invokeMethod("fetchFacebookAppLink");
  }
}