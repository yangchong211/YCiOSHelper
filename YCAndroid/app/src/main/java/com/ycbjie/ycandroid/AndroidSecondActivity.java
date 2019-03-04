package com.ycbjie.ycandroid;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

/**
 * @author yc
 */
public class AndroidSecondActivity extends AppCompatActivity {

    @SuppressLint("SetTextI18n")
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_android);
        TextView tv = findViewById(R.id.tv);

        ArrayList<String> params = getIntent().getStringArrayListExtra("yc");
        if (params!=null && params.size()>0) {
            Toast.makeText(this, "逗比" + params.get(0), Toast.LENGTH_SHORT).show();
            tv.setText("flutter 传参集合:" + params.get(0));
        }else {
            Toast.makeText(this, "逗比，没有接收到数据", Toast.LENGTH_SHORT).show();
        }
    }

}
