package com.fstm.fsinstaller.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.BaseAdapter;
import android.widget.ListView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.veiw.DividerView;

/**
 * Created by apple on 2016/10/11.
 */

public class BasicAdapter extends BaseAdapter {

    protected ListView listView;
    protected Context context;

    @Override
    public int getCount() {
        return 0;
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        return null;
    }

    public void setupClickListener(final View convertView){

        convertView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    int position = Integer.parseInt(convertView.getTag(R.layout.activity_main).toString());
                    listView.getOnItemClickListener().onItemClick(null, v, position, 0);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        });
    }

    public void updateTag(View convertView, int position){
        convertView.setTag(R.layout.activity_main, position + "");
    }

    public View getDivider(View convertView){

        DividerView dividerView = null;
        if (convertView instanceof DividerView){
            dividerView = (DividerView) convertView;
        }
        else{
            dividerView = new DividerView(context);
        }
        dividerView.setDividerColorRes(R.color.dividerColor);
        dividerView.setDividerHeight((int) context.getResources().getDimension(R.dimen.dividerHeight));

        int height = (int) context.getResources().getDimension(R.dimen.dividerHeightSection);
        AbsListView.LayoutParams params = new AbsListView.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, height);
        dividerView.setLayoutParams(params);

        dividerView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });

        return dividerView;
    }
}
