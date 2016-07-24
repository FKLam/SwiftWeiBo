//
//  UserAccountViewModel.swift
//  SwiftWeiBo
//
//  Created by kun on 16/7/22.
//  Copyright © 2016年 kun. All rights reserved.
//

import UIKit
import AFNetworking

class UserAccountViewModel: NSObject {
    
    var account: UserAccount?
    
    var userLogin: Bool {
        return account?.access_token != nil
    }
    
    var token: String?  {
        return account?.access_token
    }
    
    override init() {
        account = UserAccount.loadAccount()
    }
    
    func loadAccessToken(code: String, finished: (error: NSError?) ->()) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let parameters = ["client_id": client_id, "client_secret": client_secret, "grant_type": "authorization_code", "code": code, "redirect_uri": redirect_uri]
        let AFN = AFHTTPSessionManager()
        AFN.responseSerializer.acceptableContentTypes?.insert("text/plain")
        AFN.POST(urlString, parameters: parameters, progress: nil, success: { (_, result) in
            if let dict = result as? [String: AnyObject] {
                // 开始字典转模型
                let account = UserAccount(dict: dict)
                self.loadUserInfo(account, finished: finished)
            }
        }) { (_, error) in
            print(error)
        }
    }
    private func loadUserInfo( account : UserAccount, finished: (error: NSError?) ->() ) {
        let urlString = "https://api.weibo.com/2/users/show.json" as String
        let parameters = ["access_token": account.access_token!, "uid": account.uid!]
        let AFN = AFHTTPSessionManager()
        AFN.GET(urlString, parameters: parameters, progress: nil, success: { (_, result) in
            if let dict = result as? [String : AnyObject] {
                account.avatar_large = dict["avatar_large"] as? String
                account.name = dict["name"] as? String
                account.saveAccount()
                // 执行闭包
                finished(error: nil)
            }
        }) { (_, error) in
            finished(error: error)
            print(error)
        }
    }
}
