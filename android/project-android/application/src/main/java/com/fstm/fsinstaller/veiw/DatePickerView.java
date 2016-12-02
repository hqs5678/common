package com.fstm.fsinstaller.veiw;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import com.aigestudio.wheelpicker.WheelPicker;
import com.fstm.fsinstaller.R;
import com.hqs.utils.DateUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by apple on 16/9/30.
 */

public class DatePickerView extends LinearLayout {

    private LinearLayout contentView;
    private WheelPicker pYear;
    private WheelPicker pMonth;
    private WheelPicker pDay;
    private WheelPicker pHour;
    private WheelPicker pMinute;

    private OnSelectedValueChangedListener onSelectedValueChangedListener;

    private List<String> years = new ArrayList<>();
    private List<String> months = new ArrayList<>();
    private List<String> days = new ArrayList<>();
    private List<String> hours = new ArrayList<>();
    private List<String> minutes = new ArrayList<>();

    private int year;
    private int month;
    private int day;
    private int hour;
    private int minute;

    private int startYear;

    public DatePickerView(Context context) {
        super(context);
    }

    public DatePickerView(Context context, AttributeSet attrs) {
        super(context, attrs);

        initView(context);
    }


    public void initView(Context context){

        contentView = (LinearLayout) LayoutInflater.from(context).inflate(R.layout.date_picker_layout, null);
        ViewGroup.LayoutParams params = new LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        contentView.setLayoutParams(params);
        this.addView(contentView);

        pYear = (WheelPicker) contentView.findViewById(R.id.wheel_year);
        pMonth = (WheelPicker) contentView.findViewById(R.id.wheel_month);
        pDay = (WheelPicker) contentView.findViewById(R.id.wheel_day);
        pHour = (WheelPicker) contentView.findViewById(R.id.wheel_hour1);
        pMinute = (WheelPicker) contentView.findViewById(R.id.wheel_hour2);

        if(pYear != null){
            pYear.setOnItemSelectedListener(new WheelPicker.OnItemSelectedListener() {
                @Override
                public void onItemSelected(WheelPicker picker, Object data, int position) {

                    year = startYear + position;
                    adjustDatePicker();
                    notifyDateChanged();
                }
            });

            pMonth.setOnItemSelectedListener(new WheelPicker.OnItemSelectedListener() {
                @Override
                public void onItemSelected(WheelPicker picker, Object data, int position) {

                    month = position + 1;
                    adjustDatePicker();
                    notifyDateChanged();
                }
            });

            pDay.setOnItemSelectedListener(new WheelPicker.OnItemSelectedListener() {
                @Override
                public void onItemSelected(WheelPicker picker, Object data, int position) {

                    day = position + 1;
                    notifyDateChanged();
                }
            });

            pHour.setOnItemSelectedListener(new WheelPicker.OnItemSelectedListener() {
                @Override
                public void onItemSelected(WheelPicker picker, Object data, int position) {

                    hour = position;
                    notifyDateChanged();

                }
            });

            pMinute.setOnItemSelectedListener(new WheelPicker.OnItemSelectedListener() {
                @Override
                public void onItemSelected(WheelPicker picker, Object data, int position) {

                    minute = position;
                    notifyDateChanged();
                }
            });

            // 初始化日期
            initDate();
        }
    }

    public void notifyDateChanged(){
        if(onSelectedValueChangedListener != null){
            onSelectedValueChangedListener.onSelectedValueChanged(DatePickerView.this);
        }
    }

    private void adjustDatePicker(){
        int daysOfMonth = DateUtil.daysOfMonth(month, year);
        if (daysOfMonth == days.size()){
            return;
        }
        else{
            if (daysOfMonth > days.size()){
                for(int i = days.size() + 1; i <= daysOfMonth; i ++){
                    days.add(i + "日");
                }
            }
            else{
                days = days.subList(0, daysOfMonth);
            }
            if (pDay.getCurrentItemPosition() > days.size() - 1){
                pDay.setSelectedItemPosition(daysOfMonth - 1);
                if(onSelectedValueChangedListener != null){
                    onSelectedValueChangedListener.onSelectedValueChanged(DatePickerView.this);
                }
            }
            day = pDay.getCurrentItemPosition() + 1;
            pDay.setData(days);
        }
    }

    private void initDate(){

        DateUtil.Date date = DateUtil.currentDate();
        startYear = date.year;
        for(int i = startYear; i <= date.year + 1; i ++){
            years.add(i + "年");
        }

        for(int i = 1; i <= 12; i ++){
            months.add(i + "月");
        }

        for(int i = 1; i <= 31; i ++){
            days.add(i + "日");
        }

        for(int i = 0; i < 24; i ++){
            hours.add(i + "时");
        }

        for(int i = 0; i <= 59; i ++){
            minutes.add(i + "分");
        }

        pYear.setData(years);
        pMonth.setData(months);
        pDay.setData(days);
        pHour.setData(hours);
        pMinute.setData(minutes);

        setYear(date.year);
        setMonth(date.month);
        setDay(date.day);
        setHour(date.hour);
        setMinute(date.minute);
    }












    public WheelPicker getpYear() {
        return pYear;
    }

    public void setpYear(WheelPicker pYear) {
        this.pYear = pYear;
    }

    public WheelPicker getpMonth() {
        return pMonth;
    }

    public void setpMonth(WheelPicker pMonth) {
        this.pMonth = pMonth;
    }

    public WheelPicker getpDay() {
        return pDay;
    }

    public void setpDay(WheelPicker pDay) {
        this.pDay = pDay;
    }

    public WheelPicker getpHour() {
        return pHour;
    }

    public void setpHour(WheelPicker pHour) {
        this.pHour = pHour;
    }

    public WheelPicker getpMinute() {
        return pMinute;
    }

    public void setpMinute(WheelPicker pMinute) {
        this.pMinute = pMinute;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;

        pYear.setSelectedItemPosition(year - startYear);
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;

        pMonth.setSelectedItemPosition(month - 1);
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;

        pDay.setSelectedItemPosition(day - 1);
    }

    public int getHour() {
        return hour;
    }

    public void setHour(int hour) {
        this.hour = hour;

        pHour.setSelectedItemPosition(hour);
    }

    public int getMinute() {
        return minute;
    }

    public void setMinute(int minute) {
        this.minute = minute;

        pMinute.setSelectedItemPosition(minute);
    }

    public List<String> getYears() {
        return years;
    }

    public void setYears(List<String> years) {
        this.years = years;
    }

    public List<String> getMonths() {
        return months;
    }

    public void setMonths(List<String> months) {
        this.months = months;
    }

    public List<String> getDays() {
        return days;
    }

    public void setDays(List<String> days) {
        this.days = days;
    }

    public List<String> getHours() {
        return hours;
    }

    public void setHours(List<String> hours) {
        this.hours = hours;
    }

    public OnSelectedValueChangedListener getOnSelectedValueChangedListener() {
        return onSelectedValueChangedListener;
    }

    public void setOnSelectedValueChangedListener(OnSelectedValueChangedListener onSelectedValueChanged) {
        this.onSelectedValueChangedListener = onSelectedValueChanged;
    }

    public interface OnSelectedValueChangedListener{
        void onSelectedValueChanged(DatePickerView datePickerView);
    }
}
