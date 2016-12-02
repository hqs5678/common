package com.fstm.fsinstaller.utils;

import android.os.Environment;

import com.fstm.fsinstaller.app.ActivityManager;
import com.jph.takephoto.compress.CompressConfig;
import com.jph.takephoto.compress.CompressImageUtil;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.util.ArrayList;

/**
 * Created by apple on 16/9/26.
 */

public class FileUtil {


    public static String userDocumentPath(){
        if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)){
            String path = Environment.getExternalStorageDirectory().getAbsolutePath();
            path += "/fstm";
            File file = new File(path);
            if (file.exists() == false){
                file.mkdir();
            }
            return path;
        }
        return ActivityManager.getInstance().getCurrentActivity().getFilesDir().getAbsolutePath();
    }

    public static String tmpImgPath(){
        return userDocumentPath() + "/tmp.png";
    }
    public static String tmpImgDir(){
        return userDocumentPath() + "/tmp/";
    }

    public static String fileToString(File file){
        StringBuffer stringBuffer = new StringBuffer();

        try {
            FileInputStream fis = new FileInputStream(file);

            int len = 0;
            byte[] bytes = new byte[1024 * 4];
            while (true){
                len = fis.read(bytes);
                if (len == - 1){
                    break;
                }
                else {
                    stringBuffer.append(new String(bytes, 0, len));
                }
            }
            fis.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return stringBuffer.toString();
    }

    public static void removeDir(File file){
        if (file.isDirectory()){
            File[] files = file.listFiles();
            for (File f: files){
                removeDir(f);
            }
        }
        else{
            file.delete();
        }
    }



    public static ArrayList<File> findFiles(String dir){
        File file = new File(dir);
        ArrayList<File> files = new ArrayList<>();
        findFiles(file, files);
        return files;
    }

    private static void findFiles(File dir, ArrayList<File> fileArrayList){
        if (dir.isDirectory()){
            File[] files = dir.listFiles();
            for (File file : files){
                if (file.isDirectory()){
                    findFiles(file, fileArrayList);
                }
                else{
                    fileArrayList.add(file);
                }
            }
        }
        else{
            fileArrayList.add(dir);
        }
    }



    public static void compressImage(String imgPath, String newImgPath, CompressImageUtil.CompressListener listener){
        CompressConfig config = new CompressConfig.Builder().enableQualityCompress(true).create();
        CompressImageUtil compressImage = new CompressImageUtil(config);
        compressImage.compress(imgPath, newImgPath, listener);
    }

}


