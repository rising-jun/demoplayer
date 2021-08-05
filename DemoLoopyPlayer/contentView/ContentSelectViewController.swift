//
//  ContentSelectViewController.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/08/04.
//

import Foundation
import ReactorKit
import RxCocoa
import RxViewController
import RxGesture

class ContentSelectViewController: BaseViewController, ReactorKit.View {
    
    var disposeBag: DisposeBag = DisposeBag()
    lazy var v = ContentSelectView(frame: view.frame)
    
    
    func bind(reactor: ContentSelectReactor) {
        
        self.rx.viewDidLoad
            .map{Reactor.Action.viewDidLoaded}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        v.musicView.rx.tap
            .map{_ in Reactor.Action.contentBtnTap(.music)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        v.ticketView.rx.tap
            .map{_ in Reactor.Action.contentBtnTap(.ticket)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        v.movieView.rx.tap
            .map{_ in Reactor.Action.contentBtnTap(.movie)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map{$0.viewLife}.filter{$0 != .none}.distinctUntilChanged().bind { [weak self] state in
            switch state{
            case .viewDidLoad:
                self?.view = self?.v
                
                break
            case .none:
                break
            case .loadView:
                break
            }
    
        }
        
        reactor.state.map{$0.contentType}.filter{$0 != .none}.bind { content in
            switch content{
            case .music:
                print("music")
                break
            case .ticket:
                print("ticket")
                break
            case .movie:
                print("movie")
                break
            case .none:
                print("none")
                break
            }
        }

        
    }
    
    
    
    
}
