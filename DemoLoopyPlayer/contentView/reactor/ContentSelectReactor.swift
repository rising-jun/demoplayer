//
//  ContentSelectReactor.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/08/04.
//

import Foundation
import ReactorKit


class ContentSelectReactor: Reactor{
    
    public var address: String = ""
    private let nftID = "0x4C7566f38FA9eB3f5Fd4D7cCce01b43e35592E74"
    
    private var smartContract: SmartContract! = nil
    
    enum Action {
        case viewDidLoaded
        case contentBtnTap(ContentType)
    }
    
    enum Mutation{
        case setWalletLoginView(ViewLife)
        case updateContentState(ContentType)
    }
    
    struct State{
        var viewLife: ViewLife = .none
        var contentType: ContentType = .none
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<ContentSelectReactor.Mutation> {
        switch action {
        case .viewDidLoaded:
            smartContract = SmartContract(userAddress: self.address, contractAddress: nftID)
            smartContract.checkTokenInfo(contractAddress: nftID) { data in
                print("reactor data \(data)")
            }
            return Observable.just(Mutation.setWalletLoginView(.viewDidLoad))
            break
        case .contentBtnTap(let conetentType):
            print("reactor tapped \(conetentType)")
            return Observable.just(Mutation.updateContentState(conetentType))
            break
        }
        
        
    }
    
    func reduce(state: State, mutation: Mutation) -> ContentSelectReactor.State {
        var newState = state
        switch mutation {
        case .setWalletLoginView(let viewLife):
            newState.viewLife = viewLife
            break
        case .updateContentState(let contentType):
            newState.contentType = contentType
            break
        default:
            break
        }
        
        return newState
    }
    
    
}
