//
//  RootViewReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/13.
//

import ReactorKit
import Foundation

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
    if UserDefaults.standard.bool(forKey: "launchedBefore") == false {
      UserDefaults.standard.set(true, forKey: "launchedBefore")
      self.screenRouter.addOnboarding()
      return .empty()
    }
    
    if UserDefaults.standard.bool(forKey: "launchedBefore") == true {
      self.screenRouter.addStarting()
      return .empty()
    }
    
    // TODO: 저장된 유저 정보가 있다면 홈 화면으로 이동
    
    return .empty()
  }
}
