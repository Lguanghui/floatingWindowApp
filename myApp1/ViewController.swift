//
//  ViewController.swift
//  myApp1
//
//  Created by 梁光辉 on 2021/9/1.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        installFloatWindow()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    var floatWindow: UIWindow = UIWindow(frame: CGRect(x: 0, y: screenH/2, width: 100, height: 32))
    
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
        
        self.view.addSubview(mainView)
        mainView.addSubview(btn)
        mainView.addSubview(btn2)
        
        mainView.snp.makeConstraints { view in
            view.left.right.equalToSuperview()
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            view.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
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
//        let floatingWindowViewController = FloatingWindowViewController()
//        floatingWindowViewController.view.frame = UIScreen.main.bounds
//        floatingWindowViewController.view.frame = CGRect.zero
//        floatingWindowViewController.setupViews()
        
//        floatWindow = UIWindow(frame: CGRect(x: 0, y: screenH/2, width: 100, height: 32))
//        floatWindow.frame = CGRect(x: 0, y: screenH/2, width: 100, height: 32)
        
        
        // window不置顶是UIWindowScene的问题
        let w = UIApplication.shared.windows.first?.windowScene
        floatWindow.windowScene = w
        
        floatWindow.windowLevel = UIWindow.Level.alert + 1
        let floatingWindowController = FloatingViewController()
        floatWindow.rootViewController = floatingWindowController
        floatingWindowController.addGestureRecognizer(win: floatWindow)
//        floatingWindowController.setupViews()
        floatWindow.makeKeyAndVisible()
        floatWindow.isHidden = false
        print(UIApplication.shared.windows.count)
        
//        view.addSubview(floatWindow)
//        addChild(floatingWindowController)
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
        let page1 = NavViewController_1()
        page1.view.frame = UIScreen.main.bounds
        page1.view.isUserInteractionEnabled = false
        page1.view.backgroundColor = .blue
        self.present(page1, animated: true, completion: nil)
    }
}

