package com.fstm.fsinstaller.model;

/**
 * Created by apple on 16/9/29.
 */

public class MyHeadViewModel extends MenuListItemModel{

    private String number;
    private String iconPath;

    public String getPraise() {
        return title;
    }

    public void setPraise(String praise) {
        this.title = praise;
    }

    public String getComments() {
        return tail;
    }

    public void setComments(String comments) {
        this.tail = comments;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getIconPath() {
        return iconPath;
    }

    public void setIconPath(String iconPath) {
        this.iconPath = iconPath;
    }
}
