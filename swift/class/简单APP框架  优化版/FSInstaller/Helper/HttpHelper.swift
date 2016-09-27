 
import AFNetworking
 
typealias HttpRequestCallBack = (_ isSuccess:Bool, _ content:AnyObject) -> ()
 
class HttpHelper: NSObject {
    
    var manager:AFHTTPSessionManager!
      
    static let shared = HttpHelper()
    
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
    
    func postRequestWithUrl(_ url:String, params:NSMutableDictionary?, callBackClosure:HttpRequestCallBack?){
        
        let header = HttpUtil.sharedInstance.genCertification().mj_JSONString()
        manager.requestSerializer.setValue(header, forHTTPHeaderField: "header")
        
        print("----url----",url)
        print("----params----",params)
        print("----header----",HttpUtil.sharedInstance.genCertification())
        
        manager.post(url, parameters: params,
                     success: { [weak self](task:URLSessionDataTask, obj:Any) -> Void in
                        
                        // 成功
                        self?.dealResult(result: obj, callBackClosure: callBackClosure)
                        
                        print("task === \(task.description)")
                        
        }) { (task:URLSessionDataTask?, error:Error) -> Void in
            
            // 失败
            
            print("error === \(error)")
            
            callBackClosure?(false,error as AnyObject)

        }
    }
    
    private func dealResult(result: Any, callBackClosure:HttpRequestCallBack?){
      
        let tmpObj = result as AnyObject
        if tmpObj.isKind(of: NSData.classForCoder()){
            print("data obj === \n\n\((tmpObj as! Data).toString())")
        }
        else{
            print("content type error === \(tmpObj)")
        }
        
        let hresult = HttpResult()
        hresult.mj_setKeyValues(result)
        
        
        if hresult.state {
            callBackClosure?(true, hresult.data!)
        }
        else {
            callBackClosure?(false, hresult.msg as AnyObject)
        }
    }
    
 }
 
 class HttpResult: NSObject {
    lazy var state = false
    lazy var msg = ""
    var data: AnyObject?
 }
