package com.fstm.fsinstaller.veiw;

import android.content.Context;
import android.graphics.Color;
import android.util.AttributeSet;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.fstm.fsinstaller.model.ButtonListItemModel;

/**
 * Created by apple on 16/9/29.
 */

public class ButtonListItemView extends ListItemViewRelativeLayout {

    public Button button;
    public TextView tvDivider;

    public ButtonListItemView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }


    @Override
    public void initView(){
        if(button != null){
            return;
        }
        button = (Button) findViewById(R.id.btn_submit);
        tvDivider = (TextView) findViewById(R.id.tv_divider);
    }

    public void setModel(ButtonListItemModel model) {
        super.setModel(model);

        if(model.titleColorRes > 0){
            button.setTextColor(getResources().getColor(model.titleColorRes));
        }
        else{
            button.setTextColor(Color.WHITE);
        }

        button.setText(model.title);
        if (model.buttonColorRes > 0){
            ActivityHelper.setViewBackgroundColorWithRoundCorner(button, model.buttonColorRes);
        }
        else{
            ActivityHelper.setViewBackgroundColorWithRoundCorner(button, R.color.colorButtonNormal);
        }

        if (model.showSeparator){
            tvDivider.setVisibility(View.VISIBLE);
        }
        else{
            tvDivider.setVisibility(View.GONE);
        }

    }
}
