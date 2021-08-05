//
//  ViewController.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/07/30.
//

import UIKit
import ReactorKit
import RxCocoa
import RxViewController
import Tabman
import Pageboy

class WalletLoginViewController: BaseViewController, View {
    
    lazy var disposeBag: DisposeBag = DisposeBag()
    lazy var v: WalletLoginView = WalletLoginView(frame: view.frame)
    
    func bind(reactor: WalletLoginReactor) {
        
        self.rx.viewDidLoad
            .map{_ in Reactor.Action.viewDidLoaded}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        v.nextButton.rx.tap.map{Reactor.Action.tapNextBtn(privatekey: self.v.privatekeyTextView.text)}.bind(to: reactor.action).disposed(by: disposeBag)
        
        reactor.state.map{$0.viewState}.distinctUntilChanged().bind {[weak self] viewLife in
            switch viewLife{
            case .viewDidLoad:
                self?.view = self?.v
                break
            case .none:
                break
            case .loadView:
                break
            }
        }.disposed(by: disposeBag)
        
        reactor.state.map{$0.loginState}
            .distinctUntilChanged()
            .bind { state in
            }.disposed(by: disposeBag)
        
        reactor.state.map{$0.userAddress}
            .filter{$0 != ""}
            .distinctUntilChanged()
            .bind { [weak self] address in
                print("userAddress excecute")
                self?.presentContentViewController(address: address)
            }.disposed(by: disposeBag)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    private func presentContentViewController(address: String){
        print("present ContentView Controller : \(address)")
        let contentSelectViewController = ContentSelectViewController()
        let reactor = ContentSelectReactor()
        reactor.address = address
        contentSelectViewController.reactor = reactor
        contentSelectViewController.modalPresentationStyle = .fullScreen
        self.present(contentSelectViewController, animated: true, completion: nil)
        
    }
    

}

