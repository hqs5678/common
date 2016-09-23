 


 
import AFNetworking
 
typealias HttpRequestCallBack = (_ isSuccess:Bool, _ content:AnyObject) -> ()
 
class HttpHelper: NSObject {
    
    var manager:AFHTTPSessionManager!
      
    static let sharedInstance = HttpHelper()
    
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
        print("----url----",url)
        
        var para: NSDictionary!
        if params != nil {
            para = HttpUtil.sharedInstance.genRequestParams(params!)
            print("----params----",para)
        }
        
        
       
        manager.requestSerializer.setValue(HttpUtil.sharedInstance.genCertification().mj_JSONString(), forHTTPHeaderField: "certification")
        
        manager.post(url, parameters: para,
                     success: { (task:URLSessionDataTask, obj:Any) -> Void in
                        
                        // 成功
                        
                        let tmpObj = obj as AnyObject
                        
                        print("task === \(task.description)")
                        
                        if tmpObj.isKind(of: NSData.classForCoder()){
                            print("data obj === \n\n\((obj as! Data).toString())")
                            
                            callBackClosure?(true, tmpObj)
                        }
                        else if tmpObj.isKind(of: NSDictionary.classForCoder()){
                            print("obj === \n\n\(obj)")
                            
                            callBackClosure?(true, tmpObj)
                        }
                        else{
                            print("content type error === \(obj)")
                            
                            callBackClosure?(false, tmpObj)
                        }
                        
                        
                        
        }) { (task:URLSessionDataTask?, error:Error) -> Void in
            
            // 失败
            
            print("error === \(error)")
            
            callBackClosure?(false,error as AnyObject)

        } 
        
    }
    
    func dict2Json(_ dict:NSDictionary) -> AnyObject{
        do{
            let jsonData:Data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            
            return jsonString!
        } catch{
            print("-----dict2json error----")
            return dict
        }
    }
     
 }
