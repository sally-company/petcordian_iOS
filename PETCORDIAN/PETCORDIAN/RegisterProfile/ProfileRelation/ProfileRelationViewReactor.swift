//
//  ProfileRelationViewReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/21.
//

import ReactorKit

class ProfileRelationViewReactor: Reactor {
  
  enum Action {
    case selectRelationName(String)
    case typingRelationText(String)
  }
  
  enum Mutation {
    case setRelationName(String)
    case setRelationText(String)
  }
  
  struct State {
    var relationName: String = ""
    var relationText: String = ""
    var isEnabled: Bool {
      return self.relationName != "" || self.relationText.isNameValid()
    }
  }
  
  let initialState: State
  
  let useCase: ProfileRelationUseCase
  
  init(
    useCase: ProfileRelationUseCase
  ) {
    defer { _ = self.state }
    self.initialState = State()
    self.useCase = useCase
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .selectRelationName(name):
      return selectRelationNameMutation(name)
      
    case let .typingRelationText(text):
      return typingRelationTextMutation(text)
    }
  }
  
  private func selectRelationNameMutation(_ name: String) -> Observable<Mutation> {
    return .just(Mutation.setRelationName(name))
  }
  
  private func typingRelationTextMutation(_ text: String) -> Observable<Mutation> {
    return .just(Mutation.setRelationText(text))
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .setRelationName(name):
      newState.relationName = name
      
    case let .setRelationText(text):
      newState.relationText = text
    }
    
    return newState
  }

}
