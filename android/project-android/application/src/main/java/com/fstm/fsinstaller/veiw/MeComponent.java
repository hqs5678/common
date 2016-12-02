package com.fstm.fsinstaller.veiw;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.model.MyHeadViewModel;
import com.hqs.utils.ValidateUtil;
import com.makeramen.roundedimageview.RoundedImageView;

/**
 * Created by apple on 2016/10/11.
 * 主界面 上 我的   上面的头像部分
 */


public class MeComponent extends RelativeLayout{

    private Context context;
    private RelativeLayout contentView;
    private TextView tvPraise;
    private TextView tvComments;
    private TextView tvNumber;
    public RoundedImageView ivHeader;

    private MyHeadViewModel model;


    public MeComponent(Context context) {
        super(context);

        this.context = context;
        initView();
    }

    public MeComponent(Context context, AttributeSet attrs) {
        super(context, attrs);

        this.context = context;
        initView();
    }

    private void initView(){
        contentView = (RelativeLayout) LayoutInflater.from(context).inflate(R.layout.component_fragment_me, null);
        LayoutParams params = new LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        params.height = (int) context.getResources().getDimension(R.dimen.headerHeight);
        contentView.setLayoutParams(params);
        addView(contentView);

        tvPraise = (TextView) contentView.findViewById(R.id.tv_praise);
        tvComments = (TextView) contentView.findViewById(R.id.tv_comments);
        tvNumber = (TextView) contentView.findViewById(R.id.tv_number);
        ivHeader = (RoundedImageView) contentView.findViewById(R.id.iv_header);
    }

    public MyHeadViewModel getModel() {
        return model;
    }

    public void setModel(MyHeadViewModel model) {
        this.model = model;

        tvPraise.setText(model.getPraise());
        tvComments.setText(model.getComments());
        tvNumber.setText(model.getNumber());
        if (ValidateUtil.isEmpty(model.getIconPath()) == false){
            ivHeader.setImageDrawable(Drawable.createFromPath(model.getIconPath()));
        }
    }
}
