//
//  ViewController.swift
//  myApp1
//
//  Created by 梁光辉 on 2021/9/1.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func setupViews() {
        let mainView = UIView()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints { view in
            view 
        }
        
        mainView.snp_makeConstraints { view in
            view.bottom.top.left.right.equalToSuperview()
        }
        mainView.backgroundColor = .orange
    }
}

