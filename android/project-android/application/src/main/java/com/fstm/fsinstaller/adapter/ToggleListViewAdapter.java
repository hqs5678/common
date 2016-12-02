package com.fstm.fsinstaller.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.model.ToggleListItemModel;
import com.fstm.fsinstaller.veiw.ToggleListItemView;

import java.util.ArrayList;

/**
 * Created by apple on 16/9/29.
 */

public class ToggleListViewAdapter extends BasicAdapter {

    private ArrayList<ToggleListItemModel> models;

    public ToggleListViewAdapter(Context context, ArrayList<ToggleListItemModel> models, ListView listView) {
        this.context = context;
        this.models = models;
        this.listView = listView;
    }

    @Override
    public int getCount() {
        if (models == null){
            return 0;
        }
        return models.size();
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {

        ToggleListItemModel model = models.get(position);
        if (model.isSection){
            return getDivider(convertView);
        }
        else{
            ToggleListItemView toggleListItemView = null;
            if (convertView == null || convertView instanceof ToggleListItemView == false){
                toggleListItemView = (ToggleListItemView) LayoutInflater.from(context).inflate(R.layout.list_view_item_toggle, null);
                toggleListItemView.initView();

                setupClickListener(toggleListItemView);
            }
            else {
                toggleListItemView = (ToggleListItemView) convertView;
            }

            updateTag(toggleListItemView, position);
            toggleListItemView.setModel(model);

            return toggleListItemView;
        }
    }

}
