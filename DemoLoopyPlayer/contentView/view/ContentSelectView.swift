//
//  ContentSelectView.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/08/04.
//

import Foundation
import SnapKit

class ContentSelectView: BaseView{
    
    lazy var musicView = UIButton()
    lazy var ticketView = UIButton()
    lazy var movieView = UIButton()
    
    override func setup() {
        super.setup()
        backgroundColor = .white
        addSubViews(ticketView, musicView, movieView)
        
        ticketView.backgroundColor = .blue
        ticketView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.leading.equalTo(self).offset(30)
            make.trailing.equalTo(self).offset(-30)
            make.height.equalTo(50)
        }
        
        musicView.backgroundColor = .red
        musicView.snp.makeConstraints { make in
            make.bottom.equalTo(ticketView.snp.top).offset(-30)
            make.leading.equalTo(self).offset(30)
            make.trailing.equalTo(self).offset(-30)
            make.height.equalTo(50)
        }
        
        movieView.backgroundColor = .green
        movieView.snp.makeConstraints { make in
            make.top.equalTo(ticketView.snp.bottom).offset(30)
            make.leading.equalTo(self).offset(30)
            make.trailing.equalTo(self).offset(-30)
            make.height.equalTo(50)
        }
        
        
    }
    
    
}
