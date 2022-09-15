//
//  OnboardingItems.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/14.
//

import UIKit

public struct OnboardingItems: Hashable {
  
  public var screenshot: UIImage
  public var description: String
  
  public init(screenshot: UIImage, description: String) {
    self.screenshot = screenshot
    self.description = description
  }
  
  public init() {
    self.screenshot = UIImage()
    self.description = ""
  }
}
