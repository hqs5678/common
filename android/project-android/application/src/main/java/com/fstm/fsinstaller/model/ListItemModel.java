package com.fstm.fsinstaller.model;

/**
 * Created by apple on 16/9/29.
 */

public class ListItemModel {
    // 组之间的分割线  相当于footer  header
    public boolean isSection = false;
    public int bgColorRes = -1;
    public boolean clickable = true;
    public int rowHeight = -1;    // -1: 默认高度    0: 自动高度    其他: 具体高度
}
