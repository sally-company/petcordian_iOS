//
//  OnboardingCellReactor.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/14.
//

import ReactorKit

public class OnboardingCellReactor: Reactor, IdentityHashable {
  
  public typealias Action = NoAction
  
  public let initialState: State
  
  public struct State {
    public var item: OnboardingItems
  }
  
  public init(item: OnboardingItems) {
    defer { _ = self.state }
    self.initialState = State(item: item)
  }
}
