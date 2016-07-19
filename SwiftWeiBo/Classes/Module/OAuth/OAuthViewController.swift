//
//  OAuthViewController.swift
//  SwiftWeiBo
//
//  Created by kun on 16/7/19.
//  Copyright © 2016年 kun. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {
    let client_id = "627727710"
    let redirect_uri = "http://www.520it.com"
    
    
    let webView = UIWebView()
    
    @objc private func close() {
        dismissViewControllerAnimated(true) { 
            
        }
    }
    
    @objc private func fullAccount() {
        let jsString = "document.getElementById('userId').value = '1312344701@qq.com' ,document.getElementById('passwd').value = 'FK01201002l';"
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
        print(request.URL)
        return true
    }
}
