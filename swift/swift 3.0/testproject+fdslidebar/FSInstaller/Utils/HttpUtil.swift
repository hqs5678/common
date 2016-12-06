

class HttpUtil: NSObject {
    
    
    lazy var jsonDictionary = NSMutableDictionary()
    
    var appSecret:String = "8a372b44c171ba8d860b5c25374ca57c"
    var requestTime:String = "3"
    var append:String = "5"
    var device = kDevice
    var apiCode = kApiCode
    var role:String = kUserRole
    var sign:String = "6"
    
    public static var shared:HttpUtil = {
        return HttpUtil()
    }()
    
    // 生成加了签名的参数 NSDictionary
    func genRequestParams(_ params:NSDictionary) -> NSDictionary {
        // set requestTime
        makeRequestTime()
        
        append = String.uuid()
        
        // set sign
        makeSign()
        
        // set head
        setJsonDictionary()
        
        // set para
        jsonDictionary.setValue(params, forKey: "para")
        
        return jsonDictionary
    }
    
    func genCertification() -> NSDictionary {
        let headDict = NSMutableDictionary()
        headDict.setValue(User.shared.uid, forKey: "userId")
        headDict.setValue(appSecret, forKey: "appSecret")
        headDict.setValue(requestTime, forKey: "requestTime")
        headDict.setValue(User.shared.token, forKey: "token")
        headDict.setValue(device, forKey: "device")
        headDict.setValue(apiCode, forKey: "apiCode")
        headDict.setValue(append, forKey: "append")
        headDict.setValue(sign, forKey: "sign")
        return headDict
    }
    
    // 设置head
    fileprivate func setJsonDictionary(){
        let headDict = self.genCertification()
        jsonDictionary.setValue(headDict, forKey: "head")
    }
    
    // 生成请求时间
    fileprivate func makeRequestTime(){
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        requestTime = dateFormat.string(from: date)
    }
    
    // 生成签名
    fileprivate func makeSign(){
        let str1:String = "[" + User.shared.uid + "_" + appSecret + "]"
        let str2:String = str1.md5
        let str3:String = "[" + str2 + "_" + requestTime + "_" + User.shared.token + "_" + append + "]"
        sign = str3.md5
        
//        appPrint("userId = \(User.shared.userId)  appSecret = \(appSecret) requestTime = \(requestTime)  token = \(User.shared.token) append = \(append)")
//        appPrint("str1 = \(str1)  str2 = \(str2) str3 = \(str3)  sign = \(sign)")
    }
    
    
    func encryptPassword (pwd: String) -> String {
        return pwd.md5.md5
    }
    
}
