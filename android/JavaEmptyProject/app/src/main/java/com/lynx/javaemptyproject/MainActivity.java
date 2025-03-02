package com.lynx.javaemptyproject;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.constraintlayout.widget.ConstraintSet;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setupUI();
    }

    private void setupUI() {
        ConstraintLayout constraintLayout = new ConstraintLayout(this);
        constraintLayout.setId(View.generateViewId());
        setContentView(constraintLayout);

        TextView textView = new TextView(this);
        textView.setId(View.generateViewId());
        textView.setText("Hello Lynx!");
        textView.setTextSize(30);
        textView.setGravity(Gravity.CENTER);

        Button button = new Button(this);
        button.setId(View.generateViewId());
        button.setText("Go");
        button.setOnClickListener(view -> {
            // TODO: modify url to lynx bundle url here
            String url = "";
            if (!url.isEmpty()) {
                LynxActivity.start(this, url);
            } else {
                Toast.makeText(this, "please modify url", Toast.LENGTH_SHORT).show();
            }
        });

        constraintLayout.addView(textView);
        constraintLayout.addView(button);

        ConstraintSet set = new ConstraintSet();
        set.clone(constraintLayout);

        set.connect(textView.getId(), ConstraintSet.TOP, ConstraintSet.PARENT_ID, ConstraintSet.TOP, 16);
        set.connect(textView.getId(), ConstraintSet.START, ConstraintSet.PARENT_ID, ConstraintSet.START, 16);
        set.connect(textView.getId(), ConstraintSet.END, ConstraintSet.PARENT_ID, ConstraintSet.END, 16);

        set.connect(button.getId(), ConstraintSet.TOP, textView.getId(), ConstraintSet.BOTTOM, 32);
        set.connect(button.getId(), ConstraintSet.START, ConstraintSet.PARENT_ID, ConstraintSet.START, 16);
        set.connect(button.getId(), ConstraintSet.END, ConstraintSet.PARENT_ID, ConstraintSet.END, 16);

        set.applyTo(constraintLayout);
    }
}