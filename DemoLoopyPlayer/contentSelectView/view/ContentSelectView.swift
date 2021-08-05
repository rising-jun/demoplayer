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
    lazy var loadingView = UIView()
    
    override func setup() {
        super.setup()
        backgroundColor = .white
        addSubViews(ticketView, musicView, movieView, loadingView)
        
        loadingView.backgroundColor = .red
        loadingView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.height.equalTo(300)
            make.width.equalTo(250)
        }
        
        ticketView.backgroundColor = .blue
        ticketView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.leading.equalTo(self).offset(100)
            make.trailing.equalTo(self).offset(-100)
            make.height.equalTo(50)
        }
        
        musicView.backgroundColor = .red
        musicView.snp.makeConstraints { make in
            make.bottom.equalTo(ticketView.snp.top).offset(-30)
            make.leading.equalTo(self).offset(100)
            make.trailing.equalTo(self).offset(-100)
            make.height.equalTo(50)
        }
        
        movieView.backgroundColor = .green
        movieView.snp.makeConstraints { make in
            make.top.equalTo(ticketView.snp.bottom).offset(30)
            make.leading.equalTo(self).offset(100)
            make.trailing.equalTo(self).offset(-100)
            make.height.equalTo(50)
        }
        
        
    }
    
    
}
