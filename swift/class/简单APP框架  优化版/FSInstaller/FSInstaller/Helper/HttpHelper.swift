 


 
import AFNetworking
 
typealias HttpRequestCallBack = (isSuccess:Bool, content:AnyObject) -> ()
 
class HttpHelper: NSObject {
    
    var manager:AFHTTPSessionManager!
    
    class var sharedInstance:HttpHelper{
        struct Instance {
            static var onceToken:dispatch_once_t = 0
            static var instance:HttpHelper?=nil
        }
        
        dispatch_once(&Instance.onceToken, { () -> Void in
            Instance.instance = HttpHelper()
            Instance.instance!.manager = AFHTTPSessionManager()
            Instance.instance!.manager.responseSerializer = AFHTTPResponseSerializer()
            Instance.instance!.manager.responseSerializer.acceptableContentTypes = ["text/html","text/plain","application/json"]
            Instance.instance!.manager.requestSerializer = AFJSONRequestSerializer()
        })
        
        return Instance.instance!
    }
    
    func postRequestWithUrl(url:String, params:NSMutableDictionary, callBackClosure:HttpRequestCallBack){
        print("----url----",url)
        
        let para = HttpUtil.sharedInstance.genRequestParams(params)
        
        print("----params----",para)
       
        manager.requestSerializer.setValue(HttpUtil.sharedInstance.genCertification().mj_JSONString(), forHTTPHeaderField: "certification")
        
        manager.POST(url, parameters: para,
                     success: { (task:NSURLSessionDataTask, obj:AnyObject) -> Void in
                        
                        // 成功
                        
                        print("task === \(task)")
                        if obj.isKindOfClass(NSData.classForCoder()){
                            print("data obj === \n\n\((obj as! NSData).toString())")
                            callBackClosure(isSuccess: true,content: (obj as! NSData).mj_JSONObject())
                        }
                        else if obj.isKindOfClass(NSDictionary.classForCoder()){
                            print("obj === \n\n\(obj)")
                            callBackClosure(isSuccess: true,content: obj)
                        }
                        else{
                            print("content type error === \(obj)")
                            callBackClosure(isSuccess: false,content: obj)
                        }
                        
                        
                        
        }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
            
            // 失败
            
            print("error === \(error)")
            callBackClosure(isSuccess: false,content: error)

        } 
        
    }
    
    func dict2Json(dict:NSDictionary) -> AnyObject{
        do{
            let jsonData:NSData = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)
            
            return jsonString!
        } catch{
            print("-----dict2json error----")
            return dict
        }
    }
     
 }
