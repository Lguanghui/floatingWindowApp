//
//  FloatingViewController.swift
//  myApp1
//
//  Created by 梁光辉 on 2021/9/3.
//

import UIKit

// 标记浮窗悬浮状态
fileprivate enum floatWindowStatus {
    /// 被拖离屏幕边缘
    case Out
    /// 吸附在屏幕边缘
    case Adsorbed
}

@objcMembers
class FloatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /// 能否把浮窗从屏幕边缘拖动到屏幕里面
    var isCanDragOut = true
    /// 悬浮状态
    fileprivate var floatStatus: floatWindowStatus = .Adsorbed
    
    private let floatView = FloatingWindowView()
    private let panGestureRecognizer = UIPanGestureRecognizer()
    private var initOrientation: UIInterfaceOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? UIInterfaceOrientation.portrait
    
    func setupViews() {
        view.addSubview(floatView)
        view.layer.masksToBounds = true
        
        // 初始化内容视图
        floatView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        floatView.setupViews()
        
        // 圆角状态
        floatStatus = .Adsorbed
        changeViewCornerRadius()
    }
    
    func addGestureRecognizer(win: UIWindow) {
        panGestureRecognizer.addTarget(self, action: #selector(panGesture(recognizer:)))
        win.addGestureRecognizer(panGestureRecognizer)
    }
    
    // 拖拽手势
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let point: CGPoint = recognizer.translation(in: self.view.superview)
        guard let view = recognizer.view else {
            return
        }
        let center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        if isCanDragOut {
            view.center = center
            floatStatus = .Out
            changeViewCornerRadius()
        } else {
            view.center.y = center.y
        }

        recognizer.setTranslation(CGPoint.zero, in: self.view.superview)
        // 拖拽停止/取消/失败
        if recognizer.state == .ended || recognizer.state == .cancelled || recognizer.state == .failed {
            updateViewPosition(recognizer: recognizer)
        }
        
    }
    
    // 更新按钮位置
    func updateViewPosition(recognizer: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 0.3) {
            recognizer.view?.frame.origin.x = 0
        } completion: { success in
            self.floatStatus = .Adsorbed
            self.changeViewCornerRadius()
        }
    }
    
    // 转变圆角，吸附状态只有右侧的有圆角
    func changeViewCornerRadius() {
        if floatStatus == .Out {
            view.layer.mask = nil
            view.layer.cornerRadius = 14
        } else {
            view.layer.cornerRadius = 0
            let corners: UIRectCorner = [.bottomRight, .topRight]
            let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 12, height: 12))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = view.bounds
            maskLayer.path = maskPath.cgPath
            view.layer.mask = maskLayer
        }
    }
    
    // MARK:-屏幕旋转
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate { context in
            
        } completion: { context in
            floatWindow.frame.size.width = 100
            floatWindow.frame.size.height = 32
            floatWindow.frame.origin.x = 0
            floatWindow.frame.origin.y = 200
        }

    }
}
