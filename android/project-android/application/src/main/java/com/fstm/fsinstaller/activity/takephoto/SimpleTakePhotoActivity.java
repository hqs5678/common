package com.fstm.fsinstaller.activity.takephoto;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.PersistableBundle;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.fstm.fsinstaller.R;
import com.hqs.utils.Log;
import com.jph.takephoto.app.TakePhoto;
import com.jph.takephoto.app.TakePhotoActivity;
import com.jph.takephoto.model.CropOptions;
import com.jph.takephoto.model.TImage;
import com.jph.takephoto.model.TResult;

import java.io.File;
import java.util.ArrayList;

public class SimpleTakePhotoActivity extends TakePhotoActivity {

    private String takePhotoType = TYPE_MULTIPLE;
    private String filePath;
    private boolean crop;

    public final static String PATH = "filePath";
    public final static String TYPE = "takePhotoType";
    public final static String TYPE_MULTIPLE = "multiple";
    public final static String TYPE_SINGLE = "single";
    public final static String TYPE_CAMERA = "camera";

    public final static String CROP = "crop";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_simple_take_photo);

        startTakePhoto();
    }

    @Override
    public void takeSuccess(TResult result) {
        super.takeSuccess(result);

        Intent intent = new Intent();
        Bundle bundle = new Bundle();
        bundle.putSerializable("result", result.getImages());
        intent.putExtras(bundle);
        setResult(Activity.RESULT_OK, intent);
        finish();
    }

    private void startTakePhoto(){

        Bundle bundle = getIntent().getExtras();
        if (bundle != null){
            takePhotoType = bundle.getString(TYPE);
            filePath = bundle.getString(PATH);
            crop = bundle.getBoolean(CROP);

            int wh = 180;
            CropOptions options = new CropOptions.Builder()
                    .setAspectX(wh)
                    .setAspectY(wh)
                    .setOutputX(wh)
                    .setOutputY(wh)
                    .create();
            TakePhoto takePhoto = getTakePhoto();

            if (TYPE_MULTIPLE.equals(takePhotoType)){
                if (crop){
                    takePhoto.onPickMultipleWithCrop(99, options);
                }
                else{
                    takePhoto.onPickMultiple(99);
                }
            }
            else if (TYPE_SINGLE.equals(takePhotoType)){
                if (crop){
                    takePhoto.onPickMultipleWithCrop(1, options);
                }
                else{
                    takePhoto.onPickMultiple(1);
                }
            }
            else if (TYPE_CAMERA.equals(takePhotoType)){
                if (filePath == null){
                    Log.print("FILEPATH IS NULL !!!");
                    return;
                }
                File file = new File(filePath);
                Uri uri = Uri.fromFile(file);
                if (crop){
                    takePhoto.onPickFromCaptureWithCrop(uri, options);
                }
                else{
                    takePhoto.onPickFromCapture(uri);
                }
            }
        }


    }

    @Override
    public void takeCancel() {
        super.takeCancel();
        finish();
    }

    @Override
    public void takeFail(TResult result, String msg) {
        super.takeFail(result, msg);
        finish();
    }
}
