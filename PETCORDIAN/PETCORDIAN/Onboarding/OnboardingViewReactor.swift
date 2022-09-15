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
  }
  
  enum Mutation {
    case moveToPosition(Int)
  }
  
  struct State {
    var sections: [OnboardingSection] = [OnboardingSection.Maker(items:
                                                                  [OnboardingItems(
                                                                    screenshot: UIImage(named: "sampleImage") ?? UIImage(),
                                                                    description: "미래에서 온 AI 기반 반려동물\n감정 인식 서비스 펫코디언"),
                                                                   
                                                                   OnboardingItems(
                                                                    screenshot: UIImage(named: "sampleImage") ?? UIImage(),
                                                                    description: "AI가 반려동물의 사진을 인식하여\n반려동물의 하루를 분석해 준다몽!")
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
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .moveToPosition(position):
      newState.moveToPosition = position
    
    return newState
    }
  }
}
