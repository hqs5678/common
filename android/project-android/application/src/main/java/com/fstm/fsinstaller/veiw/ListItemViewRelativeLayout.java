package com.fstm.fsinstaller.veiw;

import android.content.Context;
import android.graphics.Color;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.RelativeLayout;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.model.ListItemModel;
import com.hqs.utils.ViewUtil;

/**
 * Created by apple on 16/9/29.
 */

public class ListItemViewRelativeLayout extends RelativeLayout {

    protected OnClickListener onClickListener;
    protected ListItemModel model;

    public ListItemViewRelativeLayout(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public void initView(){

    }


    @Override
    public void setOnClickListener(OnClickListener l) {
        super.setOnClickListener(l);
        this.onClickListener = l;
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {

        if (model != null){
            if (model.clickable){
                return super.onTouchEvent(event);
            }
        }
        return true;
    }

    public void setModel(ListItemModel model) {
        this.model = model;

        if (model == null){
            return;
        }

        int color;
        if (model.bgColorRes > 0){
            color = getResources().getColor(model.bgColorRes);
        }
        else{
            color = Color.WHITE;
        }
        this.setBackgroundColor(color);

        if (model.clickable && model.isSection == false){
            ViewUtil.setRoundCornerToView(this, 0, this.getResources().getColor(R.color.colorControlHighlight), color);
        }


        if (model.rowHeight < 0){
            setDefaultHeight();
        }
        else{
            if (model.rowHeight > 0){
                setHeight();
            }
            else{
                AbsListView.LayoutParams layoutParams = new AbsListView.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                this.setLayoutParams(layoutParams);
            }
        }

    }

    private void setDefaultHeight(){
        AbsListView.LayoutParams layoutParams = new AbsListView.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                (int) getResources().getDimension(R.dimen.listViewRowHeight));
        this.setLayoutParams(layoutParams);
    }

    private void setHeight(){
        AbsListView.LayoutParams layoutParams = new AbsListView.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,model.rowHeight);
        this.setLayoutParams(layoutParams);
    }

}
