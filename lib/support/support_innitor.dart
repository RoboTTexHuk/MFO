import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:mfo_showcase_app/constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class SupportLibraryInnitor {

  static void initOneSignal() async {
    OneSignal.shared.init(
        ApplicationConstants.ONE_SIGNAL_APP_ID,
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: false
        });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
  }

  static AppsflyerSdk appsflyerSdk;

  static void initAppsFlyer() async {
    Map options = {
      AppsflyerConstants.AF_DEV_KEY: ApplicationConstants.APPSFLYER_DEV_KEY,
      AppsflyerConstants.AF_APP_Id: ApplicationConstants.APPLICATION_ID,
      AppsflyerConstants.AF_IS_DEBUG: false
    };

    appsflyerSdk = AppsflyerSdk(options);

    appsflyerSdk.initSdk().then((value) => {
      if (value is Map)
        {print("AppsFlyerInit with result " + value.toString())}
      else
        {print("AppsFlyerInit with " + value?.toString())}
    });
  }
}