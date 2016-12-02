package com.fstm.fsinstaller.veiw;

import android.app.AlertDialog;
import android.content.Context;
import android.graphics.Color;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.app.ActivityManager;
import com.hqs.utils.ViewUtil;

import java.util.ArrayList;

/**
 * Created by apple on 2016/11/3.
 */

public class SingleSelectDialog {

    private AlertDialog dialog;
    private ArrayList<String> items;
    private AdapterView.OnItemClickListener listener;

    public SingleSelectDialog(ArrayList<String> items, final AdapterView.OnItemClickListener listener){

        this.listener = listener;
        this.items = items;

        Context context = ActivityManager.getInstance().getCurrentActivity();
        AlertDialog.Builder builder = new AlertDialog.Builder(context);

        LinearLayout view = new LinearLayout(context);
        view.setOrientation(LinearLayout.VERTICAL);

        int rowHeight = (int) context.getResources().getDimension(R.dimen.listViewRowHeight);
        int dividerHeight = (int) context.getResources().getDimension(R.dimen.dividerHeight);
        int margin = (int) context.getResources().getDimension(R.dimen.marginEdge);

        for (int i = 0;i< items.size(); i++){
            TextView tv = new TextView(context);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, rowHeight);
            tv.setLayoutParams(params);
            tv.setPadding(margin, 0, 0, 0);

            tv.setText(items.get(i));
            tv.setTextSize(15);
            tv.setTextColor(context.getResources().getColor(R.color.titleColor));
            tv.setGravity(Gravity.CENTER_VERTICAL);

            ViewUtil.setRoundCornerToView(tv, 0, context.getResources().getColor(R.color.colorControlHighlight), Color.WHITE);

            final int index = i;
            tv.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if (listener != null){
                        listener.onItemClick(null, v, index, index);
                    }
                    dialog.dismiss();
                }
            });

            view.addView(tv);

            if (i < items.size() - 1){
                View divider = new View(context);
                divider.setBackgroundResource(R.color.dividerColor);
                params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, dividerHeight);
                divider.setLayoutParams(params);
                view.addView(divider);
            }
        }

        builder.setView(view);
        dialog = builder.create();

    }

    public void show(){

        if (dialog != null){
            dialog.show();
        }
    }
}
