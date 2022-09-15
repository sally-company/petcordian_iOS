//
//  OnboardingItems.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/14.
//

import UIKit

public struct OnboardingItems: Hashable {
  
  public var screenshot: UIImage
  public var mainTitle: String
  public var description: String
  
  public init(screenshot: UIImage, mainTitle: String, description: String) {
    self.screenshot = screenshot
    self.mainTitle = mainTitle
    self.description = description
  }
  
  public init() {
    self.screenshot = UIImage()
    self.mainTitle = ""
    self.description = ""
  }
}
