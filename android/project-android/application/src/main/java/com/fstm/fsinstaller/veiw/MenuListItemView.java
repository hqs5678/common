package com.fstm.fsinstaller.veiw;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.model.MenuListItemModel;

/**
 * Created by apple on 16/9/29.
 */

public class MenuListItemView extends ListItemViewRelativeLayout {

    public ImageView imgIcon;
    public TextView tvTitle;
    public TextView tvTail;
    public ImageView imgIndicator;
    public TextView tvDivider;

    public MenuListItemView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }


    @Override
    public void initView(){
        if(tvTitle != null){
            return;
        }
        imgIcon = (ImageView) findViewById(R.id.img_icon);
        tvTitle = (TextView) findViewById(R.id.tv_title);
        tvTail = (TextView) findViewById(R.id.tv_tail);
        imgIndicator = (ImageView) findViewById(R.id.img_indicator);
        tvDivider = (TextView) findViewById(R.id.tv_divider);
    }

    public void setModel(MenuListItemModel model) {
        super.setModel(model);

        if(model.iconRes != -1){
            imgIcon.setImageResource(model.iconRes);
            imgIcon.setVisibility(View.VISIBLE);

            LayoutParams layoutParams = new LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            layoutParams.addRule(CENTER_VERTICAL, TRUE);
            layoutParams.addRule(RIGHT_OF, R.id.img_icon);
            tvTitle.setLayoutParams(layoutParams);
        }
        else{
            imgIcon.setVisibility(View.GONE);

            if (model.centerTitle){
                LayoutParams layoutParams = new LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                layoutParams.addRule(CENTER_IN_PARENT, TRUE);
                tvTitle.setLayoutParams(layoutParams);
            }
            else{
                LayoutParams layoutParams = new LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                layoutParams.addRule(ALIGN_PARENT_LEFT, TRUE);
                layoutParams.addRule(CENTER_VERTICAL, TRUE);
                tvTitle.setLayoutParams(layoutParams);
            }
        }

        tvTitle.setText(model.title);

        if ("0".equals(model.tail)){
            tvTail.setText("");
        }
        else{
            tvTail.setText(model.tail);
        }

        if(model.showIndicator){
            imgIndicator.setVisibility(View.VISIBLE);
        }
        else{
            imgIndicator.setVisibility(View.GONE);
        }

        if (model.titleColorRes > 0) {
            this.tvTitle.setTextColor(getResources().getColor(model.titleColorRes));
        }else{
            this.tvTitle.setTextColor(getResources().getColor(R.color.titleColor));
        }

        if (model.showSeparator){
            tvDivider.setVisibility(View.VISIBLE);
        }
        else{
            tvDivider.setVisibility(View.GONE);
        }

    }
}
