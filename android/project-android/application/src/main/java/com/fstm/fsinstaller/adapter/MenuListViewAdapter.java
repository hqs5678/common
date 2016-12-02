package com.fstm.fsinstaller.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.model.MenuListItemModel;
import com.fstm.fsinstaller.veiw.MenuListItemView;

import java.util.ArrayList;

/**
 * Created by apple on 16/9/29.
 */

public class MenuListViewAdapter extends BasicAdapter{

    protected ArrayList<MenuListItemModel> models;

    public MenuListViewAdapter(Context context, ArrayList<MenuListItemModel> models, ListView listView) {
        this.models = models;
        this.context = context;
        this.listView = listView;
    }

    @Override
    public int getCount() {
        return models.size();
    }

    @Override
    public Object getItem(int position) {
        return models.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        MenuListItemView itemView = null;
        if(convertView == null || convertView instanceof MenuListItemView == false){
            itemView = (MenuListItemView) LayoutInflater.from(context).inflate(R.layout.list_view_item_menu, null);
            itemView.initView();

            setupClickListener(itemView);
        }
        else {
            itemView = (MenuListItemView) convertView;
        }

        updateTag(itemView, position);


        itemView.setModel(models.get(position));

        return itemView;
    }

}
