//
//  TicketReactor.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/08/06.
//

import Foundation
import ReactorKit

class TicketReatcor: Reactor{
    
    private var disposeBag = DisposeBag()
    public var url: String = ""
    
    enum Action {
        case initViewData
    }
    
    enum Mutation{
        case initView
    }
    
    struct State{
        var viewState: ViewState = .none
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<TicketReatcor.Mutation> {
        // process logic only here
        switch action {
        case .initViewData:
            return Observable.just(Mutation.initView)
            break
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> TicketReatcor.State {
        var newState = state
        
        switch mutation {
        case .initView:
            newState.viewState = .viewDidLoad
            break
        }
        
        return newState
    }
    
}
