//
//  OnboardingImageSection.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/14.
//

import Foundation
import Differentiator

public struct OnboardingSection: Hashable {
  public enum Identity: String {
    case image
  }
  public let identity: Identity
  public var items: [Item]
}

extension OnboardingSection {
  public enum Item: Hashable {
    case image(OnboardingCellReactor)
  }
}

extension OnboardingSection.Item {
  public var identity: String {
    return "\(self.hashValue)"
  }
}

extension OnboardingSection {
  
  public class Maker {
    
    private let items: [OnboardingItems]
    
    public init(items: [OnboardingItems]) {
      self.items = items
    }
    
    public func makeOnboardingSection() -> OnboardingSection {
      return .init(identity: .image,
                   items: self.makeOnboardingSectionItems())
    }
    
    public func makeOnboardingSectionItems() -> [OnboardingSection.Item] {
      return self.items
        .map(OnboardingCellReactor.init)
        .map(OnboardingSection.Item.image)
    }
  }
}
