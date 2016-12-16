package comf.fstm.teststatusbarcolor;

import android.app.Activity;
import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


//        StatusBarUtil.setStatusBarColor(this, R.color.color);
//        StatusBarUtil.FlymeSetStatusBarLightMode(this.getWindow(), false);
        StatusBarUtil.MIUISetStatusBarLightMode(this.getWindow(), true);
        StatusBarUtil.transparencyBar(this);
    }
}
