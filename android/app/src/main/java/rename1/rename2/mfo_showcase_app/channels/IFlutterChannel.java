package rename1.rename2.mfo_showcase_app.channels;

import android.app.Activity;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

abstract class IFlutterChannel {

    protected Activity mActivity;

    public IFlutterChannel(Activity activity) {
        mActivity = activity;
    }

    abstract void attachChannel(BinaryMessenger binaryMessenger);

    protected void success(MethodChannel.Result result, String value) {
        mActivity.runOnUiThread(() -> {
            result.success(value);
        });
    }

}
