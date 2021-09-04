//
//  FloatingViewController.swift
//  myApp1
//
//  Created by 梁光辉 on 2021/9/3.
//

import UIKit

class FloatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private let floatView = FloatingWindowView()
    private let panGestureRecognizer = UIPanGestureRecognizer()
    private var initOrientation: UIInterfaceOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? UIInterfaceOrientation.portrait
    
    /// 能否把浮窗从屏幕边缘拖动到屏幕里面
    var isCanDragOut = true
    
    func setupViews() {
        view.addSubview(floatView)
        view.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        floatView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        floatView.setupViews()
        
        panGestureRecognizer.addTarget(self, action: #selector(panGesture(recognizer:)))
        floatView.addGestureRecognizer(panGestureRecognizer)
    }
    
    // 拖拽手势
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let point: CGPoint = recognizer.translation(in: view.superview)
        guard let view = recognizer.view else {
            return
        }
        let center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        view.center = center
        
        recognizer.setTranslation(CGPoint.zero, in: view.superview)
        // 拖拽停止/取消/失败
        if recognizer.state == .ended || recognizer.state == .cancelled || recognizer.state == .failed {
            updateViewPosition()
        }
        
    }
    
    // 更新按钮位置
    func updateViewPosition() {
        if floatView.frame.size.width > (floatView.superview?.frame.size.width)! && floatView.frame.size.height > (floatView.superview?.frame.size.height)! {
            // 保证浮窗在屏幕里面
            return
        }
        
        var W = screenW
        var H = screenH
        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            W = screenH
            H = screenW
        }
        
        let distance_to_leftEdge = floatView.frame.origin.x
        
        if distance_to_leftEdge > 0 {
            UIView .animate(withDuration: 0.3) { [weak self] in
                guard let self = self else {
                    return
                }
//                let center = CGPoint(x: 0, y: self.floatWindow.frame.origin.y)
                self.view.superview!.frame.origin.x = 0
            }
        }
    }
}
