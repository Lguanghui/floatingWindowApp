//
//  FloatingViewController.swift
//  myApp1
//
//  Created by 梁光辉 on 2021/9/3.
//

import UIKit

@objcMembers
class FloatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
        
        floatView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        floatView.setupViews()
        
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
        view.center = center
        
        recognizer.setTranslation(CGPoint.zero, in: self.view.superview)
        // 拖拽停止/取消/失败
        if recognizer.state == .ended || recognizer.state == .cancelled || recognizer.state == .failed {
            updateViewPosition(recognizer: recognizer)
        }
        
    }
    
    // 更新按钮位置
    func updateViewPosition(recognizer: UIPanGestureRecognizer) {
        
        UIView .animate(withDuration: 0.3) { [weak self] in
            recognizer.view?.frame.origin.x = 0
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
            floatWindow?.frame.size.width = 100
            floatWindow?.frame.size.height = 32
            floatWindow?.frame.origin.x = 0
            floatWindow?.frame.origin.y = 200
        }

    }
}
