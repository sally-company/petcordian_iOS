//
//  OnboardingViewReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/15.
//

import ReactorKit
import UIKit

class OnboardingViewReactor: Reactor {
    
  enum Action {
    case moveToPosition(Int)
    case next(Int)
  }
  
  enum Mutation {
    case moveToPosition(Int)
    case changePosition(Int?)
  }
  
  struct State {
    var sections: [OnboardingSection] = [OnboardingSection.Maker(items:
                                                                  [OnboardingItems(
                                                                    screenshot: UIImage(named: "sampleImage") ?? UIImage(),
                                                                    mainTitle: "미래에서 온 AI 기반 반려동물\n감정 인식 서비스 펫코디언",
                                                                    description: "갤러리 속 사진들을 통해\n우리만의 일상을 채워보아요!"),
                                                                   
                                                                   OnboardingItems(
                                                                    screenshot: UIImage(named: "sampleImage") ?? UIImage(),
                                                                    mainTitle: "AI가 반려동물의 사진을 인식하여\n반려동물의 하루를 분석해 준다몽!",
                                                                    description: "선택한 사진을 자동으로 인식해\n오늘 하루를 기록해준답니다. :)")
                                                                  ]).makeOnboardingSection()]
    
    var pageCount: Int {
      return sections[0].items.count
    }
    
    var moveToPosition: Int = 0
    
    @Pulse var changeToPosition: Int?
  }
  
  let initialState: State
  
  private let useCase: OnboardingUseCase
  
  init(
    useCase: OnboardingUseCase
  ) {
    defer { _ = self.state }
    self.useCase = useCase
    self.initialState = State()
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .moveToPosition(position):
      return .just(Mutation.moveToPosition(position))
      
    case let .next(position):
      if position == 0 {
        return Observable.just(.changePosition(1))
      } else {
        return .empty()
      }
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .moveToPosition(position):
      newState.moveToPosition = position
    case let .changePosition(position):
      newState.changeToPosition = position
    }
    
    return newState
  }
}
