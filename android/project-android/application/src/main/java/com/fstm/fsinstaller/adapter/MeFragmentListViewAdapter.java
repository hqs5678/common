package com.fstm.fsinstaller.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.fstm.fsinstaller.model.MenuListItemModel;
import com.fstm.fsinstaller.model.MyHeadViewModel;
import com.fstm.fsinstaller.veiw.MeComponent;

import java.util.ArrayList;

/**
 * Created by apple on 16/9/29.
 */

public class MeFragmentListViewAdapter extends MenuListViewAdapter {

    private MeComponent meComponent;

    public MeFragmentListViewAdapter(Context context, ArrayList<MenuListItemModel> models, ListView listView) {
        super(context, models, listView);
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        if(position == 0){
            if(meComponent == null){
                meComponent = new MeComponent(context);
            }
            MyHeadViewModel model = (MyHeadViewModel) models.get(position);
            meComponent.setModel(model);
            return meComponent;
        }
        else{
            return super.getView(position, convertView, parent);
        }
    }

    public MeComponent getMeComponent() {
        return meComponent;
    }
}
