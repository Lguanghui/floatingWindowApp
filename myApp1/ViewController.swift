//
//  ViewController.swift
//  myApp1
//
//  Created by 梁光辉 on 2021/9/1.
//

import UIKit
import SnapKit
import Then

@objcMembers
class ViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let page1 = firstViewController()
        pushViewController(page1, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}
