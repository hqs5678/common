package com.fstm.fsinstaller.veiw;

import android.app.AlertDialog;
import android.content.Context;
import android.graphics.drawable.Drawable;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.DecelerateInterpolator;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.bm.library.PhotoView;
import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.app.ActivityManager;

import org.xutils.common.Callback;
import org.xutils.x;

import java.util.ArrayList;

/**
 * Created by apple on 2016/11/3.
 */

public class ImageBrowser {


    /**
     * show
     * @param filePaths         文件路径 或 url
     * @param currentIndex      当前显示的图片
     */
    public static void showPhotoBrowser(final ArrayList<String> filePaths, int currentIndex){

        if (filePaths != null && filePaths.size() > 0){


            final Context context = ActivityManager.getInstance().getCurrentActivity();
            AlertDialog.Builder builder = new AlertDialog.Builder(context, R.style.FullScreenDialog);
            builder.setCancelable(true);

            final View view = LayoutInflater.from(context).inflate(R.layout.dialog_photo_browser, null);
            builder.setView(view);
            final AlertDialog dialog = builder.create();

            final TextView tvIndex = (TextView) view.findViewById(R.id.tv_index);
            tvIndex.setText(currentIndex + 1 + "/" + filePaths.size());

            ViewPager viewPager = (ViewPager) view.findViewById(R.id.viewPager);
            viewPager.setAdapter(new PagerAdapter() {

                ArrayList<PhotoView> views = new ArrayList<PhotoView>();
                int maxViews = 4;
                @Override
                public int getCount() {
                    return filePaths.size();
                }

                @Override
                public boolean isViewFromObject(View view, Object object) {
                    return view == object;
                }

                @Override
                public Object instantiateItem(ViewGroup container, int position) {

                    PhotoView photoView;
                    if (views.size() == 0){
                        for (int i = 0; i< maxViews; i ++){
                            photoView = new PhotoView(context);

                            // 启用图片缩放功能
                            photoView.enable();
                            photoView.setAnimaDuring(300);
                            photoView.setMaxScale(3);
                            photoView.setInterpolator(new DecelerateInterpolator());

                            photoView.setOnClickListener(new View.OnClickListener() {
                                @Override
                                public void onClick(View v) {
                                    dialog.dismiss();
                                }
                            });

                            views.add(photoView);
                        }

                    }
                    photoView = views.get(position % maxViews);

                    final PhotoView photoView1 = photoView;
                    String path = filePaths.get(position);
                    x.image().bind(photoView, path, new Callback.CommonCallback<Drawable>() {
                        @Override
                        public void onSuccess(Drawable result) {
                            photoView1.setScaleType(ImageView.ScaleType.FIT_CENTER);
                        }

                        @Override
                        public void onError(Throwable ex, boolean isOnCallback) {
                            Toast.makeText(context, "图片加载失败", Toast.LENGTH_SHORT).show();
                        }

                        @Override
                        public void onCancelled(CancelledException cex) {

                        }

                        @Override
                        public void onFinished() {
                        }
                    });

                    container.addView(photoView);

                    return photoView;
                }

                @Override
                public void destroyItem(ViewGroup container, int position, Object object) {
                    container.removeView((View) object);
                }

            });

            viewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
                @Override
                public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

                }

                @Override
                public void onPageSelected(int position) {
                    tvIndex.setText(position + 1 + "/" + filePaths.size());
                }

                @Override
                public void onPageScrollStateChanged(int state) {

                }
            });

            viewPager.setCurrentItem(currentIndex);






            dialog.show();

        }



    }
}
