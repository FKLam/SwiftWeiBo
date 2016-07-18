//
//  MessageController.swift
//  SwiftWeiBo
//
//  Created by kun on 16/7/12.
//  Copyright © 2016年 kun. All rights reserved.
//

import UIKit

class MessageController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorLoginView?.setUIInfo("visitordiscover_image_message", title: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
    }

}
