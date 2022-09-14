//
//  SplashViewReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/13.
//

import ReactorKit
import UIKit

class SplashViewReactor: Reactor {
    
  enum Action {
    case viewDidLoad
    case success
  }
  
  enum Mutation {
    case viewDidLoad
    case success
  }
  
  struct State {
    @Pulse var isSuccess: Bool = false
  }
  
  let initialState: State
  
  private let useCase: SplashUseCase
  
  init(
    useCase: SplashUseCase
  ) {
    defer { _ = self.state }
    self.initialState = State()
    self.useCase = useCase
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .viewDidLoad:
      return self.viewDidLoadMutation()
      
    case .success:
      return self.successMutation()
    }
  }
  
  private func viewDidLoadMutation() -> Observable<Mutation> {
    return Observable.just(Void())
      .do(onNext: { [weak self] _ in
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          self?.action.onNext(.success)
        }
      })
      .flatMap { _ -> Observable<Mutation> in .empty() }
  }
  
  private func successMutation() -> Observable<Mutation> {
    return Observable.just(.success)
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .viewDidLoad:
      break
      
    case .success:
      newState.isSuccess = true
    }
    
    return newState
  }
}
