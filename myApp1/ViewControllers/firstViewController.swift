//
//  firstViewController.swift
//  myApp1
//
//  Created by 梁光辉 on 2021/9/8.
//

import UIKit

var floatWindow: UIWindow? = nil

class firstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        parentVC = self.parent as? UINavigationController
        setupViews()
        installFloatWindow()
    }
    
    var parentVC: UINavigationController?
    
    private let btn = UIButton().then { btn in
        btn.backgroundColor = .yellow
        btn.setTitle("跳转到keep", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13)
    }
    
    private let btn2 = UIButton().then { btn in
        btn.backgroundColor = .yellow
        btn.setTitle("跳转page", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13)
    }
    
    func setupViews() {
        let mainView = UIView()
        
        guard let parent = self.parent as? UINavigationController else {
            return
        }
        
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
            make.width.equalTo(100)
            make.center.equalToSuperview()
        }
        btn.addTarget(self, action: #selector(gotoKeep), for: .touchUpInside)
        
        btn2.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(100)
            make.top.equalTo(btn.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        btn2.addTarget(self, action: #selector(showAnotherPage), for: .touchUpInside)
        
        mainView.backgroundColor = .orange
    }
    
    func installFloatWindow() {
        floatWindow = UIWindow(frame: CGRect(x: 0, y: 200, width: 100, height: 32))
        floatWindow?.windowScene = UIApplication.shared.keyWindow?.windowScene
        floatWindow?.layer.masksToBounds = true
        floatWindow?.windowLevel = UIWindow.Level.alert + 1
        let floatingWindowController = FloatingViewController()
        floatWindow?.rootViewController = floatingWindowController
        floatingWindowController.addGestureRecognizer(win: floatWindow!)
        floatWindow?.isHidden = false
        print(UIApplication.shared.windows.count)
    }
    
    @objc func gotoKeep() {
//        let url = "keep://settings?backname=%E8%85%BE%E8%AE%AF%E8%A7%86%E9%A2%91&backurl=tenvideo2%3A%2F%2F%3Faction%3D66&backpkg=com.tencent.qqlive"
        let url = "keep://home?tab=hot&backname=%E8%85%BE%E8%AE%AF%E8%A7%86%E9%A2%91&backurl=tenvideo2%3A%2F%2F%3Faction%3D66&backpkg=com.tencent.qqlive"
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
