//
//  FloatingWindowViewController.swift
//  myApp1
//
//  Created by 梁光辉 on 2021/9/2.
//

import UIKit

let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
let IS_PAD = UIDevice.current.userInterfaceIdiom == .pad

let screenH = UIScreen.main.bounds.size.height
let screenW = UIScreen.main.bounds.size.width

let floatWindowWidth: CGFloat = 50

class FloatingWindowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    enum attachEdge  {
        case left
        case right
    }
    
    let floatWindow = UIWindow()
    private let floatView = FloatingWindowView()
    private let panGestureRecognizer = UIPanGestureRecognizer()
    private let activityAreaInsets = UIEdgeInsets(top: 70, left: 0, bottom: 50, right: 0)
    private var initOrientation: UIInterfaceOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? UIInterfaceOrientation.portrait
    
    /// 能否把浮窗从屏幕边缘拖动到屏幕里面
    var isCanDragOut = true
    
    func setupViews() {
        floatWindow.frame = CGRect(x: 0, y: screenH/2, width: 100, height: 32)
        floatWindow.windowLevel = UIWindow.Level.alert + 1
//        view.addSubview(floatWindow)
        floatWindow.addSubview(floatView)
        floatWindow.makeKeyAndVisible()
        view.addSubview(floatWindow)
        
        floatView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        floatView.setupViews()
        
        panGestureRecognizer.addTarget(self, action: #selector(panGesture(recognizer:)))
        floatWindow.addGestureRecognizer(panGestureRecognizer)
    }
    
    // 另外写一个UIWindow类，把手势和内容都放进去,里面持有一个controller，然后手势的target设置为这个controller
    // 拖拽手势
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let point: CGPoint = recognizer.translation(in: floatWindow.superview)
        guard let view = recognizer.view else {
            return
        }
        let center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        view.center = center
        
        recognizer.setTranslation(CGPoint.zero, in: floatWindow.superview)
        // 拖拽停止/取消/失败
        if recognizer.state == .ended || recognizer.state == .cancelled || recognizer.state == .failed {
            updateViewPosition()
        }
        
    }
    
    // 更新按钮位置
    func updateViewPosition() {
//        if floatWindow.frame.size.width > (floatWindow.superview?.frame.size.width)! && floatWindow.frame.size.height > (floatWindow.superview?.frame.size.height)! {
//            // 保证浮窗在屏幕里面
//            return
//        }
        
        var W = screenW
        var H = screenH
        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            W = screenH
            H = screenW
        }
        
        let distance_to_leftEdge = floatWindow.frame.origin.x
        
        if distance_to_leftEdge > 0 {
            UIView .animate(withDuration: 0.3) { [weak self] in
                guard let self = self else {
                    return
                }
//                let center = CGPoint(x: 0, y: self.floatWindow.frame.origin.y)
                self.floatWindow.frame.origin.x = 0
            }
        }
    }
}
