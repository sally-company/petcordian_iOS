//
//  ProfileNameAgeViewReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/19.
//

import ReactorKit

class ProfileNameAgeViewReactor: Reactor {
  
  enum Action {
    case typingName(String)
    case typingAge(String)
    case selectGender(Bool)
  }
  
  enum Mutation {
    case setName(String)
    case setAge(String)
    case setIsSelectedGender(Bool)
  }
  
  struct State {
    var name: String = ""
    var age: String = ""
    var isSelectedGender: Bool = false
    var isEnabled: Bool {
      return self.name.isNameValid() && self.age.isAgeValid() && isSelectedGender
    }
  }
  
  let initialState: State
  
  private let useCase: ProfileNameAgeUseCase
  
  init(
    useCase: ProfileNameAgeUseCase
  ) {
    defer { _ = self.state }
    self.initialState = State()
    self.useCase = useCase
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .typingName(name):
      return typingNameMutation(name)
      
    case let .typingAge(age):
      return typingAgeMutation(age)
      
    case let .selectGender(isSelected):
      return isSelectedGenderMutation(isSelected)
    }
  }
  
  private func typingNameMutation(_ name: String) -> Observable<Mutation> {
    return .just(Mutation.setName(name))
  }
  
  private func typingAgeMutation(_ age: String) -> Observable<Mutation> {
    return .just(Mutation.setAge(age))
  }
  
  private func isSelectedGenderMutation(_ isSelected: Bool) -> Observable<Mutation> {
    return .just(Mutation.setIsSelectedGender(isSelected))
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .setName(name):
      newState.name = name
      
    case let .setAge(age):
      newState.age = age
      
    case let .setIsSelectedGender(isSelected):
      newState.isSelectedGender = isSelected
    }
    
    return newState
  }
}
