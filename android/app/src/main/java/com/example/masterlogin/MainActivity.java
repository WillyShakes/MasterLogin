package com.example.masterlogin;

import android.os.Bundle;
import android.content.ComponentName;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import org.json.JSONObject;
import android.content.Intent;
import android.os.Bundle;
import android.content.ContextWrapper;
import android.content.IntentFilter;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.AppCompatButton;
import android.support.v7.widget.AppCompatTextView;
import android.text.TextUtils;
import android.util.Log;
import android.net.Uri;
import android.os.Bundle;
import android.support.customtabs.CustomTabsClient;
import android.support.customtabs.CustomTabsIntent;
import android.support.customtabs.CustomTabsServiceConnection;
import android.support.customtabs.CustomTabsSession;



public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "masterlogin/code";
    public static MethodChannel channel;
    public static Result codeResult;
    private static final String USED_INTENT = "USED_INTENT";
    public static final String LOG_TAG = "MainActivity";
    private CustomTabsServiceConnection mCustomTabsServiceConnection;
    private CustomTabsClient mCustomTabsClient;
    private CustomTabsSession mCustomTabsSession;
    private CustomTabsIntent mCustomTabsIntent;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        if (call.method.equals("getCode")) {
                            codeResult = result;

                            String domain = "willyshakes.eu.auth0.com";
                            String clientId = "0gFFyIoKa22pIQqG2acOKugXC--_d-ts";
                            final String url = "https://"+domain+"/authorize?&response_type=code&client_id="+clientId+"&redirect_uri=com.google.codelabs.appauth://oauth2callback&state=STATE";

                            mCustomTabsServiceConnection = new CustomTabsServiceConnection() {
                                @Override
                                public void onCustomTabsServiceConnected(ComponentName componentName, CustomTabsClient customTabsClient) {
                                    mCustomTabsClient= customTabsClient;
                                    mCustomTabsClient.warmup(0L);
                                    mCustomTabsSession = mCustomTabsClient.newSession(null);
                                }

                                @Override
                                public void onServiceDisconnected(ComponentName name) {
                                    mCustomTabsClient= null;
                                }
                            };

                            CustomTabsClient.bindCustomTabsService(MainActivity.this, "com.example.masterlogin", mCustomTabsServiceConnection);
                            mCustomTabsIntent = new CustomTabsIntent.Builder(mCustomTabsSession)
                                    .setShowTitle(true)
                                    .build();
                            mCustomTabsIntent.launchUrl(MainActivity.this, Uri.parse(url));
                        } else {
                            result.notImplemented();
                        }
                    }
                });
    }

    public static void setToken(String code) {
        codeResult.success(code);
    }
}
