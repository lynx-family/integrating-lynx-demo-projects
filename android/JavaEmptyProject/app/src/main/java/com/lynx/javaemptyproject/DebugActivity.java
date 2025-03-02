package com.lynx.javaemptyproject;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import com.lynx.tasm.LynxView;
import com.lynx.tasm.LynxViewBuilder;
import com.lynx.tasm.TemplateData;

public class DebugActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        LynxView lynxView = buildLynxView();
        setContentView(lynxView);
        String url = getIntent().getStringExtra("url");
        if (url != null) {
            lynxView.renderTemplateUrl(url, TemplateData.empty());
        }
    }
    private LynxView buildLynxView() {
        LynxViewBuilder viewBuilder = new LynxViewBuilder();
        viewBuilder.setTemplateProvider(new DemoTemplateProvider(this));
        return viewBuilder.build(this);
    }
}