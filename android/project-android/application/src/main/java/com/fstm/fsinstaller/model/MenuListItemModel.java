package com.fstm.fsinstaller.model;

import android.os.Bundle;

/**
 * Created by apple on 16/9/29.
 */

public class MenuListItemModel extends ListItemModel{

    public int iconRes = -1;
    public String title;
    public int titleColorRes = -1;
    public String tail;
    public boolean showIndicator = false;
    public Class activityClass = null;
    public Bundle extraBundle = null;
    public boolean isStartFromBottom = false;
    public boolean centerTitle = false;
    public String id;
    public boolean showSeparator = true;
}
