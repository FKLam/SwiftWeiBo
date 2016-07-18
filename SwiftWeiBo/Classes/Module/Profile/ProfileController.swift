//
//  ProfileController.swift
//  SwiftWeiBo
//
//  Created by kun on 16/7/12.
//  Copyright © 2016年 kun. All rights reserved.
//

import UIKit

class ProfileController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorLoginView?.setUIInfo("visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
    }
}
