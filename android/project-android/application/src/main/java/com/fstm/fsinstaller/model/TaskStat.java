package com.fstm.fsinstaller.model;

/**
 * Created by apple on 2016/10/27.
 */

public class TaskStat {

    public String overtimeTaskNum;
    public String newTaskNum;
    public String checkingNum;
    public String checkFailedNum;
    public String finishedTaskNum;
    public String havingTaskNum;
    public String waitToDoorNum;
    public String countTaskNum;

    private TaskStat(){}

    private static TaskStat instance = null;

    public static TaskStat getInstance(){
        if (instance == null){
            instance = new TaskStat();
        }
        return instance;
    }

    public void setValueWithStat(TaskStat stat){
        if (stat != null){
            instance = stat;
        }
    }

}
