 
import AFNetworking
 
typealias HttpRequestCallBack = (_ isSuccess: Bool, _ content: AnyObject?) -> ()
typealias HttpProgressHandle = (_ progress: CGFloat) -> ()
 
 class HttpHelper: NSObject, URLSessionTaskDelegate {
    
    var manager:AFHTTPSessionManager!
    var progressHandle: HttpProgressHandle?
    weak var uploadTask: URLSessionUploadTask?
    weak var progress: Progress?
    
    public static let shared: HttpHelper = {
        return HttpHelper()
    }()
    
    override init() {
        super.init()
        setup()
    }
    
    fileprivate func setup(){
        manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = ["text/html","text/plain","application/json"]
        manager.requestSerializer = AFJSONRequestSerializer()
    }
    
    func uploadDataWithUrl(_ url: String, params:NSMutableDictionary?, dataKey: String, dataArray: NSArray?, progressHandle: @escaping HttpProgressHandle, completeHandle: HttpRequestCallBack?){
        
        let header = HttpUtil.shared.genCertification().mj_JSONString()
        
        appPrint("----url----",url)
        appPrint("----params----",params)
        appPrint("----header----",HttpUtil.shared.genCertification())
        
        var error: NSError?
        let para = params as? [AnyHashable: Any]
        let request = AFHTTPRequestSerializer().multipartFormRequest(withMethod: "POST", urlString: url, parameters: para, constructingBodyWith: { (formData) in
            
            if dataArray != nil && dataArray!.count > 0 {
                for data in dataArray! {
                    let fileName = Helper.uuid() + ".png"
                    formData.appendPart(withFileData: data as! Data, name: dataKey, fileName: fileName, mimeType: "image/png")
                }
            }
            
            }, error: &error)
        
        // 添加header
        request.setValue(header, forHTTPHeaderField: "header")
 
        if error != nil {
            completeHandle?(false, error)
            return
        }
        
        
        uploadTask = manager.uploadTask(with: request as URLRequest, from: request.httpBody, progress: &progress) { [weak self](response, responseObject, error) in
            
            self?.dealResult(result: responseObject, callBackClosure: completeHandle)
        }
        
        self.progressHandle = progressHandle
        uploadTask?.resume()
        
        progress?.addObserver(self, forKeyPath: "fractionCompleted", options: .new, context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if change?[NSKeyValueChangeKey.newKey] != nil {
            let value = change?[NSKeyValueChangeKey.newKey] as? NSObject
            if value != nil && value!.isKind(of: NSNumber.classForCoder()) {
                let progress = CGFloat((value as! NSNumber).floatValue)
                self.progressHandle?(progress)
                
                if progress == 1 {
                    self.progress?.removeObserver(self, forKeyPath: "fractionCompleted")
                }
            }
        }
        
    }
    
    func postRequestWithUrl(_ url:String, params:NSMutableDictionary?, callBackClosure:HttpRequestCallBack?){
        
        let header = HttpUtil.shared.genCertification().mj_JSONString()
        manager.requestSerializer.setValue(header, forHTTPHeaderField: "header")
        
        appPrint("----url----",url)
        appPrint("----params----\(params)")
        appPrint("----header----",HttpUtil.shared.genCertification())
        
        manager.post(url, parameters: params,
                     success: { [weak self](task:URLSessionDataTask, obj:Any) -> Void in
                        
                        // 成功
                        self?.dealResult(result: obj, callBackClosure: callBackClosure)
                        
                        
        }) { (task:URLSessionDataTask?, error:Error) -> Void in
            
            // 失败
            
            appPrint("error === \(error)")
            
            callBackClosure?(false,error.localizedDescription as AnyObject?)

        }
    }
    
    private func dealResult(result: Any?, callBackClosure:HttpRequestCallBack?){
      
        let tmpObj = result as? NSObject
        if tmpObj == nil {
            callBackClosure?(false, "无详情数据!!!" as AnyObject?)
            return
        }
        
        if tmpObj!.isKind(of: NSData.classForCoder()){
            appPrint("data obj === \n\n\n\((tmpObj as! Data).toString())\n\n\n")
        }
        else{
            appPrint("otherType === \n\n\n\(tmpObj?.classForCoder)\n\n\n\(tmpObj)\n\n\n")
        }
        
        let hresult = HttpResult()
        hresult.mj_setKeyValues(result)
        
        
        if hresult.state {
            callBackClosure?(true, hresult.data)
        }
        else {
            if hresult.msg.contains("登录超时") {
                doInMainThreadAfter(0.8, task: { 
                    let vc = currentViewController
                    let naVC = vc?.navigationController as? BaseNavigationController
                    naVC?.turnToLogin()
                })
            }
            callBackClosure?(false, hresult.msg as AnyObject)
        }
    }
    
 }
 
 class HttpResult: NSObject {
    lazy var state = false
    lazy var msg = ""
    var data: AnyObject?
 }
