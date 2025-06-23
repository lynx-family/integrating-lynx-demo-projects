package com.lynx.javaemptyproject;

import android.app.Application;
import android.content.Intent;
import android.os.Handler;
import android.os.Looper;

import com.facebook.drawee.backends.pipeline.Fresco;
import com.facebook.imagepipeline.core.ImagePipelineConfig;
import com.facebook.imagepipeline.memory.PoolConfig;
import com.facebook.imagepipeline.memory.PoolFactory;
import com.lynx.devtoolwrapper.LynxDevtoolCardListener;
import com.lynx.devtoolwrapper.LynxDevtoolGlobalHelper;
import com.lynx.service.image.LynxImageService;
import com.lynx.service.log.LynxLogService;
import com.lynx.service.devtool.LynxDevToolService;
import com.lynx.tasm.LynxEnv;
import com.lynx.tasm.service.LynxServiceCenter;

public class YourApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        initLynxService();
        initLynxEnv();
    }

    private void initLynxService() {
        // init Fresco which is needed by LynxImageService
        final PoolFactory factory = new PoolFactory(PoolConfig.newBuilder().build());
        ImagePipelineConfig.Builder builder =
                ImagePipelineConfig.newBuilder(getApplicationContext()).setPoolFactory(factory);
        Fresco.initialize(getApplicationContext(), builder.build());

        LynxServiceCenter.inst().registerService(LynxImageService.getInstance());
        LynxServiceCenter.inst().registerService(LynxLogService.INSTANCE);

        // register devtool service
        LynxServiceCenter.inst().registerService(LynxDevToolService.getINSTANCE());
    }

    private void initLynxEnv() {
        LynxEnv.inst().init(
                this,
                null,
                null,
                null
        );
        // 打开 Lynx Debug 开关
        LynxEnv.inst().enableLynxDebug(true);
        // 打开 Lynx DevTool 开关
        LynxEnv.inst().enableDevtool(true);
        // 打开 Lynx LogBox 开关
        LynxEnv.inst().enableLogBox(true);
        // 创建一个 Handler 关联到主线程
        Handler mainHandler = new Handler(Looper.getMainLooper());
        // 为 Lynx DevTool 注册 OpenCard
        LynxDevtoolGlobalHelper.getInstance().registerCardListener(new LynxDevtoolCardListener() {
            public void open(String url) {
                mainHandler.post(new Runnable() { // 抛到主线程
                    @Override
                    public void run() {
                        Intent intent = new Intent(getApplicationContext(), DebugActivity.class);
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        intent.putExtra("url", url);
                        startActivity(intent);
                    }
                });
            }
        });
    }
}
