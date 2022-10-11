//
//  DiaryListContentItemReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/07.
//

import ReactorKit

final class DiaryListContentItemReactor: Reactor {
  
  enum Action {
  }
  
  enum Mutation {
  }
  
  struct State {
    let profileInfoData: ProfileInfo
  }
  
  let initialState: State
  
  init(
    profileInfoData: ProfileInfo
  ) {
    defer { _ = self.state }
    self.initialState = .init(profileInfoData: profileInfoData)
  }
}
