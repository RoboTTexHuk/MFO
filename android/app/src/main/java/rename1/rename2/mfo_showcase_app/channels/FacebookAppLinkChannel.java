package rename1.rename2.mfo_showcase_app.channels;

import android.app.Activity;
import android.content.Context;

import com.facebook.applinks.AppLinkData;

import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import java9.util.concurrent.CompletableFuture;

public class FacebookAppLinkChannel extends IFlutterChannel {

    private static final String SHARED_PREFERENCES_NAME = "FlutterSharedPreferences";

    private final Future<String> futureFacebookAppLink;

    private final android.content.SharedPreferences preferences;

    public FacebookAppLinkChannel(Activity activity) {
        super(activity);
        preferences = activity.getSharedPreferences(SHARED_PREFERENCES_NAME, Context.MODE_PRIVATE);

        futureFacebookAppLink = fetchFacebookAppLink();
    }

    @Override
    public void attachChannel(BinaryMessenger binaryMessenger) {
        new MethodChannel(binaryMessenger, "FacebookAppLinkChannel")
                .setMethodCallHandler((call, result) -> {
                    if ("fetchFacebookAppLink".equals(call.method)) {
                        waitForFacebookAppLink(result);
                    } else {
                        result.notImplemented();
                    }

                });
    }

    private void waitForFacebookAppLink(MethodChannel.Result result) {
        new Thread(() -> {
            try {
                success(result, futureFacebookAppLink.get(8, TimeUnit.SECONDS));
            } catch (Exception e) {
                e.printStackTrace();
                success(result, "");
            }
        }).start();
    }

    private Future<String> fetchFacebookAppLink() {
        CompletableFuture<String> completableFuture
                = new CompletableFuture<>();

        if (preferences.contains("facebooklink")) {
            completableFuture.complete(
                    preferences.getString("facebooklink", "")
            );
            return completableFuture;
        }

        AppLinkData.fetchDeferredAppLinkData(mActivity, appLinkData -> {

            String facebooklink = "";

            try {

                if (appLinkData == null || appLinkData.getTargetUri() == null) {
                    AppLinkData data = AppLinkData.createFromActivity(mActivity);

                    if (data != null && data.getTargetUri() != null) {
                        facebooklink = data.getTargetUri().toString();
                    }

                }
                if (appLinkData != null) {
                    facebooklink = appLinkData.getTargetUri().toString();
                }

            } catch (Exception e) {
                e.printStackTrace();
                facebooklink = "";
            }

            final String link = facebooklink;
            preferences.edit()
                    .putString("facebooklink", link)
                    .apply();
            completableFuture.complete(link);
        });

        return completableFuture;
    }

}
