//
//  RootViewReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/13.
//

import ReactorKit

class RootViewReactor: Reactor {
    
  enum Action {
    case viewDidLoad
  }
  
  enum Mutation {
  }
  
  struct State {
  }
  
  let initialState: State
  
  let screenRouter: ScreenRouter
  
  init(
    screenRouter: ScreenRouter
  ) {
    defer { _ = self.state }
    self.screenRouter = screenRouter
    self.initialState = State()
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .viewDidLoad:
      return self.viewDidLoadMutation()
    }
  }
  
  private func viewDidLoadMutation() -> Observable<Mutation> {
    // TODO: 앱의 첫 시작이라면 온보딩 화면으로 이동
    
    // TODO: 앱의 첫 시작이 아니고 저장된 유저 정보가 없다면 시작 화면으로 이동
    
    // TODO: 저장된 유저 정보가 있다면 홈 화면으로 이동
    
    return .empty()
  }
}
