//
//  HomeViewController.swift
//  SwiftWeiBo
//
//  Created by kun on 16/7/12.
//  Copyright © 2016年 kun. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        visitorLoginView?.setUIInfo(nil, title: "关注一些人，回这里看看有什么惊喜")
    }

}
