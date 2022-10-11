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
  
  public let diaryPopupListViewReactor: DiaryPopupListViewReactor
  
  private let useCase: DiaryListPopupUseCase
  
  init(
    useCase: DiaryListPopupUseCase,
    diaryPopupListViewReactor: DiaryPopupListViewReactor
  ) {
    defer { _ = self.state }
    self.initialState = State()
    self.useCase = useCase
    self.diaryPopupListViewReactor = diaryPopupListViewReactor
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    return newState
  }
}