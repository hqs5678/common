//
//  HttpHelper+API.swift
//  formoney
//
//  Created by 火星人 on 16/5/17.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//



//let urlServer = "http://192.168.50.134:8888/fushuntianmu/"
//let urlServer = "http://192.168.50.134:8081/fushuntianmu/"


let urlServer = "http://www.7x24home.com/fushuntianmu/"
//let urlServer = "http://www.7x24home.com:8081/fushuntianmu/"

let urlHelper = "http://www.7x24home.com/introduced.html"

let urlLogin = "fstm/o_login.do"
let urlModifyPwd = "fstm_user/o_upd_pwd.do"
let urlResetPwd = "fstm_user/o_reset_pwd.do"
let urlGetTaskList = "fstm_repairorder/o_get_emp_task_list_app.do"
let urlTaskDetail = "fstm_repairorderdetail/o_get_emp_task_detail_app.do"

// 处理任务 （接收/拒绝/签到/完工/改约）
let urlDealTask = "fstm_repairorder/o_emp_task_deal_app.do"
let urlTaskStat = "fstm_repairorder/o_get_emp_refresh_count_app.do"
let urlUploadFile = "fstm_img/o_img_upload_app.do"
let urlSearchTask = "fstm_repairorder/o_emp_search_task_app.do"
let urlGetCaptcha = "sms/o_get_code.do"
let urlGetUploadedImage = "fstm_img/o_img_by_visitorderno_app.do"
let urlGetBrand = "fstm_pro_brand/o_list_app.do"
let urlGetCategory = "fstm_pro_category/o_list_app.do"
let urlGetFeeList = "fee/o_get_fee.do"
let urlSubmitFee = "fee/o_add.do"





extension HttpHelper {
    
    
    func test(){
        let url = "https://www.baidu.com"
        postRequestWithUrl(url, params: nil) { (isSuccess, content) in
//            appPrint(isSuccess)
//            appPrint(content)
        }
    }
    
    // login
    func loginWithParams(params:NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        updatePwd(params: params)
        postRequestWithUrl(urlServer + urlLogin, params: params, callBackClosure: callBack)
    }
    
    // 修改密码
    func modityPwdWithParams(params:NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        updatePwd(params: params)
        postRequestWithUrl(urlServer + urlModifyPwd, params: params, callBackClosure: callBack)
    }
    
    // 重置密码
    func resetPwdWithParams(params:NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        updatePwd(params: params)
        postRequestWithUrl(urlServer + urlResetPwd, params: params, callBackClosure: callBack)
    }
    
    // 修改密码 将密码加密
    private func updatePwd(params: NSMutableDictionary){
        let pwd = params["pwd"] as? String
        if let pwd = pwd {
            params["pwd"] = HttpUtil.shared.encryptPassword(pwd: pwd)
        }
        let newPwd = params["newPwd"] as? String
        if let newPwd = newPwd {
            params["newPwd"] = HttpUtil.shared.encryptPassword(pwd: newPwd)
        }
    }
    
    // 获取手机验证码
    func getCaptchaWithParams(params:NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        postRequestWithUrl(urlServer + urlGetCaptcha, params: params, callBackClosure: callBack)
    }
    
    // 任务列表
    func getTaskListWithParams(params:NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        postRequestWithUrl(urlServer + urlGetTaskList, params: params, callBackClosure: callBack)
    }
    
    // 获取任务详情
    func getTaskDetailWithParams(params:NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        postRequestWithUrl(urlServer + urlTaskDetail, params: params, callBackClosure: callBack)
    }
    
    // 签到
    func signInWithWithParams(params:NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        params.setValue("签到", forKey: "workSheetStatus")
        params.setValue(User.shared.realName, forKey: "empName")
        postRequestWithUrl(urlServer + urlDealTask, params: params, callBackClosure: callBack)
    }
    
    // 改约
    func modityAppointmentTimeWithWithParams(params:NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        params.setValue("改约", forKey: "workSheetStatus")
        params.setValue(User.shared.realName, forKey: "empName")
        postRequestWithUrl(urlServer + urlDealTask, params: params, callBackClosure: callBack)
    }
    
    // 安装反馈
    func workerFeedbackWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        params.setValue("反馈", forKey: "workSheetStatus")
        params.setValue(User.shared.realName, forKey: "empName")
        postRequestWithUrl(urlServer + urlDealTask, params: params, callBackClosure: callBack)
    }
    
    // 安装反馈 等配件
    func workerFeedbackWaitAccessoryWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        params.setValue("等配件", forKey: "workSheetStatus")
        params.setValue(User.shared.realName, forKey: "empName")
        postRequestWithUrl(urlServer + urlDealTask, params: params, callBackClosure: callBack)
    }
    
    // 我要上门
    func startToServerWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        params.setValue("我要上门", forKey: "workSheetStatus")
        params.setValue(User.shared.realName, forKey: "empName")
        postRequestWithUrl(urlServer + urlDealTask, params: params, callBackClosure: callBack)
    }
    
    // 完工
    func completeWorkWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        params.setValue("完工", forKey: "workSheetStatus")
        params.setValue(User.shared.realName, forKey: "empName")
        postRequestWithUrl(urlServer + urlDealTask, params: params, callBackClosure: callBack)
    }
    
    // 接受任务
    func acceptTaskWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        params.setValue("接受任务", forKey: "workSheetStatus")
        params.setValue(User.shared.realName, forKey: "empName")
        postRequestWithUrl(urlServer + urlDealTask, params: params, callBackClosure: callBack)
    }
    
    // 拒绝任务
    func rejectTaskWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        params.setValue("拒绝任务", forKey: "workSheetStatus")
        params.setValue(User.shared.realName, forKey: "empName")
        postRequestWithUrl(urlServer + urlDealTask, params: params, callBackClosure: callBack)
    }
    
    // 任务统计
    func statTaskWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        postRequestWithUrl(urlServer + urlTaskStat, params: params, callBackClosure: callBack)
    }
    
    // 搜索任务
    func searchTaskWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        postRequestWithUrl(urlServer + urlSearchTask, params: params, callBackClosure: callBack)
    }
    
    // 获取已经上传的图片
    func getUploadedImageWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        postRequestWithUrl(urlServer + urlGetUploadedImage, params: params, callBackClosure: callBack)
    }
    
    // 获取品牌
    func getBrandWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        postRequestWithUrl(urlServer + urlGetBrand, params: params, callBackClosure: callBack)
    }
    
    // 获取分类
    func getCategoryWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        postRequestWithUrl(urlServer + urlGetCategory, params: params, callBackClosure: callBack)
    }
    
    // 获取维修项目费用列表
    func getFeeListWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        postRequestWithUrl(urlServer + urlGetFeeList, params: params, callBackClosure: callBack)
    }
    
    // 上传配件回填结果
    func submitFeeWithParams(params: NSMutableDictionary, callBack:@escaping HttpRequestCallBack){
        postRequestWithUrl(urlServer + urlSubmitFee, params: params, callBackClosure: callBack)
    }
    
}
