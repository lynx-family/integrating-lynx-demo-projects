package com.lynx.javaemptyproject;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

public class LynxActivity extends AppCompatActivity {

    private static final String TAG = "LynxActivity";
    private static final String INTENT_EXTRA_URL = "url";

    public static void start(Context context, String url) {
        Intent intent = new Intent(context, LynxActivity.class);
        intent.putExtra(INTENT_EXTRA_URL, url);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        render(getIntent().getStringExtra(INTENT_EXTRA_URL));
    }

    private void render(String url) {
        // TODO: render lynx view here
    }
}