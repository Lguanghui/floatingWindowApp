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
        // Do any additional setup after loading the view.
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private let btn = UIButton().then { btn in
        btn.backgroundColor = .yellow
        btn.setTitle("跳转到keep", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13)
    }
    
    func setupViews() {
        let mainView = UIView()
        
        self.view.addSubview(mainView)
        mainView.addSubview(btn)
        
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
        
        mainView.backgroundColor = .orange
    }
    
    @objc func gotoKeep() {
        let url = "keep://settings?backname=%E8%85%BE%E8%AE%AF%E8%A7%86%E9%A2%91&backurl=tenvideo2%3A%2F%2F%3Faction%3D66&backpkg=com.tencent.qqlive"
        let Url = URL.init(string: url)
        
        if UIApplication.shared.canOpenURL(Url!) {
            UIApplication.shared.open(Url!, options: [:], completionHandler: nil)
        }
    }
}

