//
//  RegisterProfileRootViewReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/20.
//

import ReactorKit

class RegisterProfileRootViewReactor: Reactor {
    
  enum Action {
    
  }
  
  enum Mutation {
    
  }
  
  struct State {
    
  }
  
  let initialState: State
  
  init(
  ) {
    defer { _ = self.state }
    self.initialState = State()
    
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    return newState
  }
}
