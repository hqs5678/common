package com.fstm.fsinstaller.veiw;

import android.content.Context;
import android.util.AttributeSet;
import android.view.Gravity;
import android.widget.EditText;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.model.InputListItemModel;

/**
 * Created by apple on 16/9/29.
 */

public class InputListItemView extends ListItemViewRelativeLayout {

    public EditText etInput;

    public InputListItemView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    public void initView(){
        if(etInput != null){
            return;
        }

        etInput = (EditText) findViewById(R.id.et_input);
    }

    public void setModel(InputListItemModel model) {
        super.setModel(model);

        etInput.setTextColor(getResources().getColor(model.titleColorRes));
        if (model.singleLine){
            etInput.setGravity(Gravity.CENTER_VERTICAL);
        }
        else{
            etInput.setGravity(Gravity.TOP | Gravity.LEFT);
        }
        etInput.setText(model.title);
        etInput.setHint(model.hintString);
    }
}
