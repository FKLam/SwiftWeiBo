//
//  MainTabBar.swift
//  SwiftWeiBo
//
//  Created by kun on 16/7/12.
//  Copyright © 2016年 kun. All rights reserved.
//

import UIKit

class MainTabBar: UITabBar {
    //默认的构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    //如果重写 init(frame:) 系统会默认为这个控件是通过代码创建
    required init?(coder aDecoder: NSCoder) {
        //只有默认报错的语句
        //如果有调用者通过 sb / xib创建了该对象 这个时候程序就崩溃
        //        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        //添加撰写按钮
        addSubview(composeBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //手动修改所有 '按钮' 的位置
        //遍历所有的子视图
        
        let w = self.bounds.width / 5
        let h = self.bounds.height
        let rect = CGRect(x: 0, y: 0, width: w, height: h)
        
        //定义递增变量
        var index: CGFloat = 0
        for subView in subviews {
            if subView.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                //修改frame
                subView.frame = CGRectOffset(rect, index * w, 0)
                //                if index == 1 {
                //                    index++
                //                }
                //                index++
                
                //三目
                index += index == 1 ? 2 : 1
            }
        }
        
        //设置撰写按钮的位置
        composeBtn.frame = CGRectOffset(rect, w * 2, 0)
        bringSubviewToFront(composeBtn)
    }
    
    
    //MARK:  懒加载 撰写按钮
    lazy var composeBtn: UIButton = {
        //UIButton()  自定义样式的按钮
        let btn = UIButton()
        
        //设置按钮
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        btn.sizeToFit()
        return btn
    }()}
