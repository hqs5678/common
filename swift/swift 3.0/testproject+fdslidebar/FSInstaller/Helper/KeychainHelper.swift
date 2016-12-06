//
//  KeychainHelper.swift
//  keychain
//
//  Created by Apple on 16/9/23.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

import UIKit

public class KeychainHelper: NSObject {
    
    static let shared: KeychainHelper = {
        return KeychainHelper()
    }()
    
    lazy var service = "keychain_service"
    
    override init() {
        super.init()
        
        setup()
    }
    
    private func setup(){
        
    }
    
    public func string(forKey key: String) -> String?{
        if let data = retrieveData(forKey: key) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    public func data(forKey key: String) -> Data?{
        return retrieveData(forKey: key)
    }
    
    public func set(value: String, forKey key: String){
        
        let data = value.data(using: .utf8)
        
        store(data: data, forKey: key)
    }
    
    public func set(data: Data?, forKey key: String){
        store(data: data, forKey: key)
    }
    
    public func removeForKey(key: String){
        let keychainQuery = NSMutableDictionary()
        keychainQuery.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        keychainQuery.setValue(service, forKey: kSecAttrService as String)
        keychainQuery.setValue(kCFBooleanTrue, forKey: kSecReturnAttributes as String)
        keychainQuery.setValue(key, forKey: kSecAttrAccount as String)
        
        let query: CFDictionary = keychainQuery
        let status = SecItemDelete(query)
        appPrint(status)
    }
    
    private func store(data: Data?, forKey key: String){
        
        if let data = data {
            let keychainQuery = NSMutableDictionary()
            keychainQuery.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
            keychainQuery.setValue(service, forKey: kSecAttrService as String)
            keychainQuery.setValue(kCFBooleanTrue, forKey: kSecReturnAttributes as String)
            keychainQuery.setValue(key, forKey: kSecAttrAccount as String)
            
            let query: CFDictionary = keychainQuery
            var status = SecItemDelete(query)
            appPrint(status)
            
            keychainQuery.setObject(data, forKey: kSecValueData as NSString)
            
            let query1: CFDictionary = keychainQuery
            var result: CFTypeRef?
            status = SecItemAdd(query1, &result)
            
            appPrint(status)
            
//            CFRelease(query)
        }
    }
    
    private func  retrieveData(forKey key: String?) -> Data?{
        
        if let key = key {
            let keychainQuery = NSMutableDictionary()
            keychainQuery.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
            keychainQuery.setValue(service, forKey: kSecAttrService as String)
            keychainQuery.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
            keychainQuery.setValue(kSecMatchLimitOne, forKey: kSecMatchLimit as String)
            keychainQuery.setValue(key, forKey: kSecAttrAccount as String)
            
            let query: CFDictionary = keychainQuery
            var result: CFTypeRef?
            let status = SecItemCopyMatching(query, &result)
            appPrint(status)
            
            if SecItemCopyMatching(query, &result) == noErr {
                let data = result as! Data
                return data
            }
        }
        
        return nil
    }
 
}
