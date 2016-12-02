package com.fstm.fsinstaller.veiw;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Color;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;

import com.fstm.fsinstaller.R;

/**
 * Created by apple on 16/10/10.
 */

public class DividerView extends RelativeLayout {

    private Context context;
    private View divider;

    public DividerView(Context context) {
        super(context);

        this.context = context;
        initView();
    }

    public DividerView(Context context, AttributeSet attrs) {
        super(context, attrs);

        this.context = context;
        initView();

        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.DividerView);
        int dividerColor = a.getColor(R.styleable.DividerView_dividerColor, Color.BLUE);
        int dividerHeight = (int) a.getDimension(R.styleable.DividerView_dividerHeight, 2);
        a.recycle();

        divider.setBackgroundColor(dividerColor);
        setDividerHeight(dividerHeight);
    }

    private void initView(){
        divider = new View(context);
        RelativeLayout.LayoutParams dividerParams = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 2);
        dividerParams.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM, RelativeLayout.TRUE);
        divider.setLayoutParams(dividerParams);
        addView(divider);
    }

    public void setDividerColorRes(int dividerColorRes) {
        divider.setBackgroundResource(dividerColorRes);
    }

    public void setDividerHeight(int dividerHeight) {
        RelativeLayout.LayoutParams dividerParams = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, dividerHeight);
        dividerParams.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM, RelativeLayout.TRUE);
        divider.setLayoutParams(dividerParams);
    }
}
