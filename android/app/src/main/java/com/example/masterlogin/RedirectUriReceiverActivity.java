package com.example.masterlogin;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import com.example.masterlogin.MainActivity;

public class RedirectUriReceiverActivity extends Activity {


    public void onCreate(Bundle savedInstanceBundle) {
        super.onCreate(savedInstanceBundle);
        Intent intent = this.getIntent();
        Uri uri = intent.getData();
        String access_token = uri.getQueryParameter("code");
        MainActivity.setToken(access_token);
        Intent openMainActivity= new Intent(RedirectUriReceiverActivity.this, MainActivity.class);
        openMainActivity.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);
        startActivityIfNeeded(openMainActivity, 0);
        this.finish();
        }
    }

