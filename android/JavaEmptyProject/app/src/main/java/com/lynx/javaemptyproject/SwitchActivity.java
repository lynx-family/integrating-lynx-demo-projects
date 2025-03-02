package com.lynx.javaemptyproject;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import com.lynx.tasm.LynxView;
import com.lynx.tasm.LynxViewBuilder;
import com.lynx.tasm.TemplateData;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

public class SwitchActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        LynxView lynxView = buildLynxView();
        setContentView(lynxView);
        byte[] array = null;
        try {
            InputStream inputStream = this.getAssets().open("devtool_switch/switchPage/devtoolSwitch.lynx.bundle");
            array = readBytes(inputStream);
            lynxView.renderTemplateWithBaseUrl(array, TemplateData.empty(), "devtool_switch/switchPage/devtoolSwitch.lynx.bundle");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private LynxView buildLynxView() {
        LynxViewBuilder viewBuilder = new LynxViewBuilder();
        viewBuilder.setTemplateProvider(new DemoTemplateProvider(this));
        return viewBuilder.build(this);
    }

    private byte[] readBytes(InputStream inputStream) throws IOException {
        byte[] buffer = new byte[1024];
        int bytesRead;
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            output.write(buffer, 0, bytesRead);
        }
        return output.toByteArray();
    }
}