package com.example.masterlogin;

import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;


import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


import com.auth0.android.Auth0;
import com.auth0.android.authentication.AuthenticationException;
import com.auth0.android.provider.AuthCallback;
import com.auth0.android.provider.WebAuthProvider;
import com.auth0.android.result.Credentials;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "masterlogin/login";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, final MethodChannel.Result result) {
                        if (call.method.equals("login")) {
                            Auth0 auth0 = new Auth0(MainActivity.this);
                            auth0.setOIDCConformant(true);
                            WebAuthProvider.init(auth0)
                                    .withScheme("http")
                                    .withAudience(String.format("https://%s/userinfo", getString(R.string.com_auth0_domain)))
                                    .start(MainActivity.this, new AuthCallback() {
                                        @Override
                                        public void onFailure(@NonNull Dialog dialog) {
                                            // Show error Dialog to user
                                            result.success("false");
                                        }


                                        @Override
                                        public void onFailure(AuthenticationException exception) {
                                            // Show error to user
                                            result.error("exception", exception.getMessage(), null);
                                        }

                                        @Override
                                        public void onSuccess(@NonNull Credentials credentials) {
                                            // Store credentials
                                            // Navigate to your main activity
                                            result.success("Your access Token: " + credentials.getAccessToken());
                                        }
                                    });
                        } else {
                            result.notImplemented();
                        }
                    }
                });
    }
}
