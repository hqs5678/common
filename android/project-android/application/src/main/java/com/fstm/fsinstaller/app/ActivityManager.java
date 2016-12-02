package com.fstm.fsinstaller.app;

import android.app.Activity;

import com.hqs.utils.Log;

import java.lang.ref.WeakReference;
import java.util.ArrayList;

/**
 * Created by apple on 16/9/27.
 */

public class ActivityManager {
    private static ActivityManager sInstance = new ActivityManager();
    // 采用弱引用持有 Activity ，避免造成 内存泄露
    private ArrayList<WeakReference<Activity>> activityStack = new ArrayList<>();

    private ActivityManager() {

    }

    public static ActivityManager getInstance() {
        return sInstance;
    }

    public Activity getCurrentActivity() {
//        Log.print("getCurrentActivity");
//        printActivityStack();

        WeakReference<Activity> activityWeakReference = activityStack.get(activityStack.size() - 1);
        return activityWeakReference.get();
    }

    public void pushActivity(Activity activity) {

        if (containsActivity(activity)){
            return;
        }
        WeakReference<Activity> activityWeakReference = new WeakReference<Activity>(activity);
        activityStack.add(activityWeakReference);

//        Log.print("push");
//        printActivityStack();
    }

    public void popActivity(Activity activity) {

//        Log.print("pop");
        if (containsActivity(activity)){
            while (activityStack.size() > 0){
                WeakReference<Activity> activityWeakReference = activityStack.get(activityStack.size() - 1);
                activityStack.remove(activityStack.size() - 1);
                if (activityWeakReference.get() == activity){

//                    Log.print("pop");
//                    printActivityStack();
                    return;
                }
            }
        }

    }

    private boolean containsActivity(Activity activity){

        for (WeakReference<Activity> activityWeakReference : activityStack){
            if (activityWeakReference.get() == activity){
                return true;
            }
        }
        return false;
    }

    public void printActivityStack(){

        Log.print("=======================================");
        Log.print("activity stack :");
        for (WeakReference<Activity> activityWeakReference : activityStack){
            Log.print(activityWeakReference.get().getClass().getName());
        }
        Log.print("=======================================");
    }
}
