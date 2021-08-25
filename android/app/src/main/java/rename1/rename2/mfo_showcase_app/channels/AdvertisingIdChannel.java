package rename1.rename2.mfo_showcase_app.channels;

import android.app.Activity;

import com.google.android.gms.ads.identifier.AdvertisingIdClient;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class AdvertisingIdChannel extends IFlutterChannel {

    public AdvertisingIdChannel(Activity activity) {
        super(activity);
    }

    @Override
    public void attachChannel(BinaryMessenger binaryMessenger) {
        new MethodChannel(binaryMessenger, "AdvertisingIdChannel")
                .setMethodCallHandler((call, result) -> {
                    if ("getAdvertisingId".equals(call.method)) {
                        getAdvertisingIdOnBackground(result);
                    } else {
                        result.notImplemented();
                    }

                });
    }

    private void getAdvertisingIdOnBackground(MethodChannel.Result result) {

        new Thread(() -> {

            AdvertisingIdClient.Info adInfo = null;

            try {
                adInfo = AdvertisingIdClient.getAdvertisingIdInfo(mActivity.getApplicationContext());
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (adInfo == null) {
                success(result, "");
            } else {
                success(result, adInfo.getId());
            }

        }).start();
    }
}
