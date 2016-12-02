package com.fstm.fsinstaller.veiw;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.TextView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.model.ToggleListItemModel;
import com.zcw.togglebutton.ToggleButton;

/**
 * Created by apple on 16/9/29.
 */

public class ToggleListItemView extends ListItemViewRelativeLayout {

    public TextView tvTitle;
    public ToggleButton toggleButton;
    private ToggleListItemModel model;

    public ToggleListItemView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }


    @Override
    public void initView(){
        if(tvTitle != null){
            return;
        }

        tvTitle = (TextView) findViewById(R.id.tv_title);
        toggleButton = (ToggleButton) findViewById(R.id.btn_toggle);
        toggleButton.setOnToggleChanged(new ToggleButton.OnToggleChanged() {
            @Override
            public void onToggle(boolean on) {
                if (model != null){
                    model.isOn = on;
                }
            }
        });
    }

    public void setModel(ToggleListItemModel model) {
        super.setModel(model);
        this.model = model;

        if (model != null){
            tvTitle.setText(model.title);
            if (model.isOn){
                toggleButton.toggleOn();
            }
            else{
                toggleButton.toggleOff();
            }
        }
    }
}
