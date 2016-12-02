package com.fstm.fsinstaller.helper;

import com.fstm.fsinstaller.model.TaskModel;
import com.hqs.utils.SDCardUtils;

import org.xutils.DbManager;
import org.xutils.db.sqlite.WhereBuilder;
import org.xutils.x;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by apple on 16/9/27.
 */

public class DBHelper {

    public final static String kDBName = "db_fstm.db";
    private static DbManager.DaoConfig config = null;

    public static void init(){

        config = new DbManager.DaoConfig();

        config.setDbName(kDBName);
        File file = new File(SDCardUtils.getSDCardPath());
        config.setDbDir(file);
        config.setDbVersion(1);
        config.setDbOpenListener(new DbManager.DbOpenListener() {
            @Override
            public void onDbOpened(DbManager db) {
                // 开启WAL
                db.getDatabase().enableWriteAheadLogging();
            }
        });
        config.setDbUpgradeListener(new DbManager.DbUpgradeListener() {
            @Override
            public void onUpgrade(DbManager db, int oldVersion, int newVersion) {

                // 数据库更新时需要用到


            }
        });

    }


    public static <T> void writeToDB(final ArrayList<T> values, final Runnable onFinishedRunnable){

        if (values != null && values.size() > 0){
            final DbManager db = getDBManager();

            // 异步执行
            x.task().run(new Runnable() {
                @Override
                public void run() {

                    try {
                        db.saveBindingId(values);
                        db.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    if (onFinishedRunnable != null){
                        x.task().post(onFinishedRunnable);
                    }
                }
            });
        }
    }

    public static void query(final Class klass, final WhereBuilder where, final OnSelectorFinishedListener listener){

        final DbManager db = getDBManager();
        // 异步执行
        x.task().run(new Runnable() {
            @Override
            public void run() {

                try {
                    final List<Object> list = db.selector(klass).where(where).findAll();
                    db.close();
                    if (listener != null){
                        x.task().post(new Runnable() {
                            @Override
                            public void run() {
                                listener.onFinished(list);
                            }
                        });
                    }
                } catch (Exception e) {
                    e.printStackTrace();

                    x.task().post(new Runnable() {
                        @Override
                        public void run() {
                            listener.onFinished(null);
                        }
                    });
                }

            }
        });
    }

    public static void clearTaskTable(){
        DbManager db = getDBManager();
        try {
            db.delete(TaskModel.class);
            db.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void clearTaskTable(WhereBuilder whereBuilder){
        DbManager db = getDBManager();
        try {
            db.delete(TaskModel.class, whereBuilder);
            db.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public interface OnSelectorFinishedListener{
        <T> void onFinished(List<T> list);
    }

    public static DbManager getDBManager(){
        DbManager db = null;
        try {
            db = x.getDb(config);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return db;
    }

}
