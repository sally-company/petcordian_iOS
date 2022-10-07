//
//  DiaryListPopupViewReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/06.
//

import ReactorKit

class DiaryListPopupViewReactor: Reactor {
    
  enum Action {
    
  }
  
  enum Mutation {
    
  }
  
  struct State {
    
  }
  
  let initialState: State
  
  private let useCase: DiaryListPopupUseCase
  
  init(
    useCase: DiaryListPopupUseCase
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
