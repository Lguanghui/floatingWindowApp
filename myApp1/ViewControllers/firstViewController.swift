//
//  firstViewController.swift
//  myApp1
//
//  Created by 梁光辉 on 2021/9/8.
//

import UIKit

var floatWindow: UIWindow = UIWindow()

@objcMembers
class firstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        parentVC = self.parent as? UINavigationController
        setupViews()
        
        // 装载浮窗
        installFloatingWindow()
    }
    
    var parentVC: UINavigationController?
    
    private let btn = UIButton().then { btn in
        btn.backgroundColor = .yellow
        btn.setTitle("跳转到另一应用", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13)
    }
    
    private let btn2 = UIButton().then { btn in
        btn.backgroundColor = .yellow
        btn.setTitle("跳转到另一page", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13)
    }
    
    func setupViews() {
        let mainView = UIView()
        
        self.view.addSubview(mainView)
        mainView.addSubview(btn)
        mainView.addSubview(btn2)
        
        mainView.snp.makeConstraints { view in
            view.left.right.equalToSuperview()
            view.top.equalToSuperview()
            view.bottom.equalToSuperview()
        }
        
        btn.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(110)
            make.center.equalToSuperview()
        }
        btn.addTarget(self, action: #selector(gotoAnotherApp), for: .touchUpInside)
        
        btn2.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(110)
            make.top.equalTo(btn.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        btn2.addTarget(self, action: #selector(showAnotherPage), for: .touchUpInside)
        
        mainView.backgroundColor = .orange
    }
    
    func installFloatingWindow() {
        // 设置window的初始位置和长宽
        floatWindow = UIWindow(frame: CGRect(x: 0, y: 200, width: 100, height: 32))
        
        // 基于windowScene的应用需要设置一下Scene，否则不需要设置
        floatWindow.windowScene = UIApplication.shared.keyWindow?.windowScene
        
        // 防止旋转屏幕时浮窗四周出现黑色矩形
        floatWindow.layer.masksToBounds = true
        // window优先级
        floatWindow.windowLevel = UIWindow.Level.alert + 1
        
        // 设置window的根控制器，用来接收手势操作等
        let floatingWindowController = FloatingViewController()
        floatWindow.rootViewController = floatingWindowController
        // 给window添加手势
        floatingWindowController.addGestureRecognizer(win: floatWindow)
        // 设置浮窗能否被拖离屏幕边缘,默认true
        floatingWindowController.isCanDragOut = true
        
        // 显示浮窗
        floatWindow.isHidden = false
        print(UIApplication.shared.windows.count)
    }
    
    @objc func gotoAnotherApp() {
        let url = ""    // schema of your another App， 跳转到另一个App的schema
        let Url = URL.init(string: url)
        
        if UIApplication.shared.canOpenURL(Url!) {
            UIApplication.shared.open(Url!, options: [:], completionHandler: nil)
        }
    }
    
    @objc func showAnotherPage() {
        let page2 = secondViewController()
        parentVC?.pushViewController(page2, animated: true)
    }
}
