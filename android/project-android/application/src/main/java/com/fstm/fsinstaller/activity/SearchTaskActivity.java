package com.fstm.fsinstaller.activity;

import android.graphics.Color;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.base.BaseActivity;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.fstm.fsinstaller.helper.Helper;
import com.hqs.utils.ScreenUtils;
import com.hqs.utils.ViewUtil;

public class SearchTaskActivity extends BaseActivity {

    private RelativeLayout rlSearch;
    private RelativeLayout rlSearchContent;
    private EditText etSearchContent;
    private TextView tvSearchContent;
    private String workSheetStatus;
    private String from;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search_task);

        initView(R.id.activity_search_task);
    }

    @Override
    public void initView(int res) {
        super.initView(res);

        Bundle bundle = getIntent().getExtras();
        if (bundle != null){
            workSheetStatus = bundle.getString("workSheetStatus");
            from = bundle.getString("from");
        }

        tvSearchContent = (TextView) findViewById(R.id.tv_search);
        rlSearchContent = (RelativeLayout) findViewById(R.id.rl_search);
        ViewUtil.setRoundCornerToView(rlSearchContent, 0, getResources().getColor(R.color.colorControlHighlight), Color.WHITE);
        rlSearchContent.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                search();
            }
        });

        rlSearch = (RelativeLayout) LayoutInflater.from(this).inflate(R.layout.component_search_bar, null);
        rlSearch.setBackgroundResource(R.color.colorPrimary);
        navigationBar.addView(rlSearch);

        etSearchContent = (EditText) rlSearch.findViewById(R.id.et_search);
        rlSearch.findViewById(R.id.rl_search).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                search();
            }
        });
        etSearchContent.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                if (etSearchContent.getText().length() == 0){
                    tvSearchContent.setText("请输入搜索条件");
                }
                else{
                    tvSearchContent.setText("搜索: " + etSearchContent.getText());
                }
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        Helper.doInMainThreadDelayed(new Runnable() {
            @Override
            public void run() {
                int marginLeft = (int) (36 * ScreenUtils.density(SearchTaskActivity.this));
                int margin = (int) SearchTaskActivity.this.getResources().getDimension(R.dimen.marginEdge);

                int w = navigationBar.getWidth() - marginLeft - margin;
                int h = navigationBar.getHeight();
                RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(w, h);

                params.leftMargin = marginLeft;
                params.topMargin = margin;
                params.bottomMargin = margin;

                rlSearch.setLayoutParams(params);
            }
        }, 30);

    }


    private void search(){
        String searchContent = etSearchContent.getText().toString();
//        if (searchContent.length() == 0){
//            makeToast("请输入条件");
//        }

 
    }
}
