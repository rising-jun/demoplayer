//
//  WalletLoginView.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/07/30.
//

import Foundation
import SnapKit

class WalletLoginView: BaseView{
    
    lazy var privatekeyTextView = UITextView()
    
    lazy var hintLabel = UILabel()
    
    lazy var nextButton = UIButton()

    
    override func setup() {
        
        backgroundColor = .white
        addSubViews(privatekeyTextView, nextButton)
        
        privatekeyTextView.isUserInteractionEnabled = true
        privatekeyTextView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(70)
            make.leading.equalTo(self).offset(30)
            make.trailing.equalTo(self).offset(-30)
            make.height.equalTo(150)
        }
        
        privatekeyTextView.addSubview(hintLabel)
        hintLabel.adjustsFontSizeToFitWidth = true
        hintLabel.text = "privatekey를 입력해주세요."
        hintLabel.snp.makeConstraints { make in
            make.center.equalTo(privatekeyTextView)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
        nextButton.backgroundColor = .green
        nextButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(privatekeyTextView.snp.bottom).offset(50)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
    }
    
}
