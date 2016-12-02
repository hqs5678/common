package com.fstm.fsinstaller.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.fstm.fsinstaller.model.MenuListItemModel;
import com.fstm.fsinstaller.veiw.SearchView;

import java.util.ArrayList;

/**
 * Created by apple on 16/9/29.
 */

public class TaskFragmentListViewAdapter extends MenuListViewAdapter {

    public SearchView searchView;

    public TaskFragmentListViewAdapter(Context context, ArrayList<MenuListItemModel> models, ListView listView) {
        super(context, models, listView);
        searchView = new SearchView(context);
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        if(position == 0){
            return searchView;
        }
        else{
            return super.getView(position, convertView, parent);
        }
    }

}
