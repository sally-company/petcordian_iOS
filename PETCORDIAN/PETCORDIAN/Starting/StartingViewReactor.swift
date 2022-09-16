//
//  StartingViewReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/16.
//

import ReactorKit

class StartingViewReactor: Reactor {
    
  enum Action {
    
  }
  
  enum Mutation {
    
  }
  
  struct State {
    
  }
  
  let initialState: State
  
  private let useCase: StartingUseCase
  
  init(
    useCase: StartingUseCase
  ) {
    defer { _ = self.state }
    self.initialState = State()
    self.useCase = useCase
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    return newState
  }
}
