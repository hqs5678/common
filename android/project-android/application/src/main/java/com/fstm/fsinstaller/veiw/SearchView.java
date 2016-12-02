package com.fstm.fsinstaller.veiw;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.fstm.fsinstaller.R;

/**
 * Created by apple on 16/10/10.
 */

public class SearchView extends RelativeLayout {

    private RelativeLayout contentView;
    private Context context;
    private TextView tvHint;

    public SearchView(Context context) {
        super(context);

        this.context = context;
        initView();
    }

    public SearchView(Context context, AttributeSet attrs) {
        super(context, attrs);

        this.context = context;
        initView();
    }

    private void initView(){
        contentView = (RelativeLayout) LayoutInflater.from(context).inflate(R.layout.view_search_view, null);
        RelativeLayout.LayoutParams params = new LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        contentView.setLayoutParams(params);

        int left = (int) context.getResources().getDimension(R.dimen.marginEdge);
        int top = (int) (left * 0.5);
        this.setPadding(left, top, left, top);

        this.addView(contentView);

        tvHint = (TextView) contentView.findViewById(R.id.tv_hint);
    }

    public void setSearchHintText(String text){
        tvHint.setText(text);
    }

}
