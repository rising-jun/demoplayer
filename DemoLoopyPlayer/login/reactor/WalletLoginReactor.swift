//
//  WalletLoginReactor.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/07/30.
//

import Foundation
import ReactorKit
import Moya

class WalletLoginReactor: Reactor{
    
    private var disposeBag = DisposeBag()
    private var etherWallet = EthWalletLogin()
    private var userAddress = ""
    private var userState = PublishSubject<LoginState>()
    
    
    enum Action {
        case viewDidLoaded
        case startEdit
        case tapNextBtn(privatekey: String)
    }
    
    enum Mutation{
        case setWalletLoginView(ViewLife)
        case startEditView
        case checkPrivateKey(String)
    }
    
    struct State{
        var loginState = LoginState.none
        var userAddress: String = ""
        var viewState = ViewLife.viewDidLoad
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<WalletLoginReactor.Mutation> {
        switch action {
        case .startEdit:
            return Observable.just(Mutation.startEditView)
            break
        case .tapNextBtn(let privatekey):
            do{
            try etherWallet.importAccount(privateKey: privatekey)
            }catch{
                print("error in etherwallet importAccount \(error)")
                return Observable.just(Mutation.checkPrivateKey(""))
            }
            
            guard let address = etherWallet.userAddress else {
                return Observable.just(Mutation.checkPrivateKey(""))
            }
            self.userAddress = address
            return Observable.just(Mutation.checkPrivateKey(address))
        case .viewDidLoaded:
            return Observable.just(Mutation.setWalletLoginView(.viewDidLoad))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> WalletLoginReactor.State {
        var newState = state
        switch mutation {
        case .checkPrivateKey(let address):
            newState.userAddress = address
            if address == ""{
                newState.loginState = .failLogin
            }else{
                newState.loginState = .login
                newState.userAddress = self.userAddress
            }
            break
        case .setWalletLoginView(let viewState):
            newState.viewState = viewState
            break
        default:
            break
        }
        
        
        return newState
    }
    
    
    
}

