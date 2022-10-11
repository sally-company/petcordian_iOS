//
//  DiaryPopupListViewReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/07.
//

import ReactorKit

final class DiaryPopupListViewReactor: Reactor {
  
  typealias Action = NoAction
  
  struct State {
  }
  
  var initialState: State
  
  private(set)var diaryListContentItemReactors: [DiaryListContentItemReactor] = []
  
  init(
    datas: [ProfileInfo]
  ) {
    defer { _ = self.state }
    
    self.diaryListContentItemReactors = datas.map { data in
      DiaryListContentItemReactor(profileInfoData: data)
    }
    self.initialState = .init()
  }
}
