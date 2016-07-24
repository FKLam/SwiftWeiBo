//
//  OAuthViewController.swift
//  SwiftWeiBo
//
//  Created by kun on 16/7/19.
//  Copyright © 2016年 kun. All rights reserved.
//

import UIKit
import SVProgressHUD
import AFNetworking

class OAuthViewController: UIViewController {
    let webView = UIWebView()
    
    @objc private func close() {
        dismissViewControllerAnimated(true) { 
            
        }
    }
    @objc private func fullAccount() {
        let jsString = "document.getElementById('userId').value = 'lfk01201002@3g.sina.cn' ,document.getElementById('passwd').value = '01201002lfk';"
        webView.stringByEvaluatingJavaScriptFromString(jsString)
    }
    
    override func loadView() {
        view = webView
        webView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadOauthPage()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        SVProgressHUD.dismiss()
    }
    
    private func loadOauthPage() {
        let urlString = "https://api.weibo.com/oauth2/authorize?" + "client_id=" + client_id + "&redirect_uri=" + redirect_uri
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    private func setupUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: #selector(OAuthViewController.close))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .Plain, target: self, action: #selector(OAuthViewController.fullAccount))
    }
}
// 专门处理 webView所有的协议方法
extension OAuthViewController: UIWebViewDelegate {
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    // 此方法 返回true 当前对象可以正常工作
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let urlString = request.URL?.absoluteString else {
            return false
        }
        // 是网页请求页面，或者请求授权页面
        if urlString.hasPrefix("https://api.weibo.com") {
            return true
        }
        
        if !urlString.hasPrefix(redirect_uri) {
            return false
        }
        
        // 程序到这一定包含了回调url
        guard let query = request.URL?.query else {
            return false
        }
        let codeStr = "code="
        let code = query.substringFromIndex(codeStr.endIndex)
        UserAccountViewModel().loadAccessToken(code) { (error) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        return false
    }
}
