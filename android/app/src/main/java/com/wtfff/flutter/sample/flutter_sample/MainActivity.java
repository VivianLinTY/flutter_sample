package com.wtfff.flutter.sample.flutter_sample;

import android.text.TextUtils;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static final String MESSAGES_CHANNEL = "com.wtfff.sample/messages";
    private int index = 0;

    private String receiveMessage() {
        index++;
        String message = "test " + index;
        return message;
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), MESSAGES_CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("getMessage")) {
                                String message = receiveMessage();

                                if (!TextUtils.isEmpty(message)) {
                                    result.success(message);
                                } else {
                                    result.error("UNAVAILABLE", "No message", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}
