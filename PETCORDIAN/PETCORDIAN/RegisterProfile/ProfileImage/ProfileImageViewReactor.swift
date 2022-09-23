//
//  ProfileImageViewReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/21.
//

import ReactorKit
import UIKit

class ProfileImageViewReactor: Reactor {
    
  enum Action {
    case changeProfileImage(UIImage?)
  }
  
  enum Mutation {
    case setProfileImage(UIImage?)
  }
  
  struct State {
    var profileImage: UIImage?
  }
  
  let initialState: State
  
  private let useCase: ProfileImageUseCase
  
  init(
    useCase: ProfileImageUseCase
  ) {
    defer { _ = self.state }
    self.initialState = State()
    self.useCase = useCase
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .changeProfileImage(profileImage):
      return self.changeProfileImageMutation(profileImage)
    }
  }
  
  private func changeProfileImageMutation(_ profileImage: UIImage?) -> Observable<Mutation> {
    return .just(.setProfileImage(profileImage))
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .setProfileImage(profileImage):
      newState.profileImage = profileImage
    }
    
    return newState
  }
}
