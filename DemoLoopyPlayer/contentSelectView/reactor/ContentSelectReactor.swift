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
    private var tokenListPublish = PublishSubject<[ContentType : String]>()
    
    private var smartContract: SmartContract! = nil
    
    
    
    
    enum Action {
        case viewDidLoaded
        case contentBtnTap(ContentType)
    }
    
    enum Mutation{
        case setWalletLoginView(ViewLife)
        case updateContentState(ContentType)
        case updateContentData([ContentType: String])
    }
    
    struct State{
        var viewLife: ViewLife = .none
        var contentType: ContentType = .none
        var contentData: [ContentType : String] = [:]
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<ContentSelectReactor.Mutation> {
        switch action {
        case .viewDidLoaded:
            smartContract = SmartContract(userAddress: self.address, contractAddress: nftID)
            smartContract.getTokenData(contractAddress: nftID) { [weak self] tokenList in
                print("reactor data \(tokenList)")
                self?.tokenListPublish.onNext(tokenList!)
            }
            
            return Observable.concat([
                Observable.just(Mutation.setWalletLoginView(.viewDidLoad)),
                tokenListPublish.map{Mutation.updateContentData($0)}
            ])
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
        case .updateContentData(let contentData):
            newState.contentData = contentData
        default:
            break
        }
        
        return newState
    }
    
    
}
