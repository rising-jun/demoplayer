//
//  TicketViewController.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/08/06.
//

import Foundation
import ReactorKit
import RxViewController

class TicketViewController: BaseViewController, View{
   
    var disposeBag: DisposeBag = DisposeBag()
    lazy var v = TicketView(frame: view.frame)
    
    func bind(reactor: TicketReatcor) {
        
        self.rx.viewDidLoad.map{Reactor.Action.initViewData}.bind(to: reactor.action)
        
        reactor.state.map{$0.viewState}.distinctUntilChanged().bind { [weak self] state in
            guard let self = self else { return }
            switch state{
            case .willLoad:
                break
            case .viewDidLoad:
                self.view = self.v
                break
            case .none:
                break
            }
        }
        
    }
    
}
