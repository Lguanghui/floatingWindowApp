//
//  FloatingWindowView.swift
//  myApp1
//
//  Created by 梁光辉 on 2021/9/2.
//

import UIKit

class FloatingWindowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let closeBtn = UIButton().then { make in
        make.setImage(UIImage(named: "icon_close_small"), for: .normal)
    }
    
    private let backBtn = UIButton().then { make in
        make.setImage(UIImage(named: "icon_arrow_right"), for: .normal)
    }
    
    private let titleLabel = UILabel().then { make in
        make.font = UIFont.systemFont(ofSize: 12)
        make.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        make.textAlignment = .center
    }
    
    private let mainView = UIView()
    
    func setupViews() {
        addSubview(mainView)
        mainView.addSubview(backBtn)
        mainView.addSubview(titleLabel)
        mainView.addSubview(closeBtn)
        
        mainView.snp.makeConstraints { make in
            make.bottom.top.left.right.equalToSuperview()
        }
        mainView.layer.masksToBounds = true
        mainView.backgroundColor = UIColor.init(hexString: "#24C789")
        
        backBtn.snp.makeConstraints { make in
            make.height.width.equalTo(18)
            make.left.equalToSuperview().offset(4)
            make.top.equalToSuperview().offset(7)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(backBtn.snp.right)
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(16)
            // 先写死宽度，后面要根据实际title调整
            make.width.equalTo(50)
        }
        titleLabel.text = "嘿嘿嘿"
        
        closeBtn.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right).offset(4)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(14.4)
        }
    }
    
    func updateViews(sourceAppName: String) {
        titleLabel.text = sourceAppName
    }
}
