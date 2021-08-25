package rename1.rename2.mfo_showcase_app;

import android.content.Intent;
import android.os.Build;
import android.webkit.CookieManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import rename1.rename2.mfo_showcase_app.channels.AdvertisingIdChannel;
import rename1.rename2.mfo_showcase_app.channels.FacebookAppLinkChannel;

public class MainActivity extends FlutterActivity {

    private static String WEBVIEW_CHANNEL = "WebViewChannel";

    @Nullable
    private AdvancedWebView webView;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        BinaryMessenger binaryMessenger = flutterEngine.getDartExecutor().getBinaryMessenger();

        new MethodChannel(binaryMessenger, WEBVIEW_CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    switch (call.method) {
                        case "startView":
                            String link = call.argument("link");
                            runOnUiThread(() -> startLink(link));
                            result.success(null);
                            break;
                        case "goBack":
                            if (webView != null) {
                                webView.goBack();
                            }
                            result.success(null);
                            break;
                        default:
                            result.notImplemented();
                            break;
                    }
                });

        // Custom Channels
        new FacebookAppLinkChannel(this).attachChannel(binaryMessenger);
        new AdvertisingIdChannel(this).attachChannel(binaryMessenger);
    }

    private void startLink(String link) {

        webView = new AdvancedWebView(MainActivity.this);
        webView.getSettings().setUserAgentString(
                webView.getSettings().getUserAgentString().replace(
                        "; wv",
                        ""
                )
        );

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            CookieManager.getInstance()
                    .setAcceptThirdPartyCookies(webView, true);
        } else {
            CookieManager.getInstance().setAcceptCookie(true);
        }

        webView.loadUrl(link);

//        addContentView(webView, new FrameLayout.LayoutParams(
//                FrameLayout.LayoutParams.MATCH_PARENT,
//                FrameLayout.LayoutParams.MATCH_PARENT
//        ));

        setContentView(webView);
    }

    @Override
    protected void onDestroy() {
        if (webView != null) {
            webView.onDestroy();
        }
        super.onDestroy();
    }

    @Override
    protected void onPause() {
        if (webView != null) {
            webView.onPause();
        }
        super.onPause();
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (webView != null) {
            webView.onResume();
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (webView != null) {
            webView.onActivityResult(requestCode, resultCode, data);
        }
    }

    @Override
    public void onBackPressed() {
        if (webView != null && webView.canGoBack()) {
            webView.goBack();
        } else {
            super.onBackPressed();
        }
    }

}
