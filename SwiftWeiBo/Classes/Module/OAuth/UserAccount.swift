//
//  UserAccount.swift
//  SwiftWeiBo
//
//  Created by kun on 16/7/21.
//  Copyright © 2016年 kun. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding {
    // 采用OAuth授权方式为必填参数，OAuth授权后获得
    var access_token: String?
    // access_token的生命周期，单位是秒数
    var expires_in: NSTimeInterval = 0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow:expires_in)
        }
    }
    // 过期日期
    var expires_date: NSDate?
    // 授权用户的UID，本字段只是为了方便开发者，减少一次user/show接口调用而返回的，第三方应用不能用此字段作为用户登录状态的识别，只有access_token才是用户授权的唯一票据
    var uid: String?
    // 用户头像
    var avatar_large: String?
    // 用户名
    var name: String?
    // KVC设置初始值
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["access_token", "expires_in", "uid", "avatar_large", "name", "expires_date"]
        return dictionaryWithValuesForKeys(keys).description
    }
    
    // 对象归档 
    func saveAccount()  {
        let path = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString) .stringByAppendingPathComponent("account.plist")
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
    }
    // 对外提供解归档方法
    class func loadAccount() -> UserAccount? {
        let path = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString) .stringByAppendingPathComponent("account.plist")
        if let accout = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? UserAccount {
            if accout.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                return accout
            }
        }
        return nil
    }
    //MARK: 实现NSCoding 协议方法
    // 解档 将磁盘中二进制数据 ——》转换成自定义对象
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        uid = aDecoder.decodeObjectForKey("uid") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        name = aDecoder.decodeObjectForKey("name") as? String
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
    }
    // 归档 将对象 转换成二进制 保存到磁盘中
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
    }
}
