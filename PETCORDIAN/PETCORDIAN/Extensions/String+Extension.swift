//
//  String+Extension.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/20.
//

import Foundation

extension String {
  
  func isNameValid() -> Bool {
    if self.count >= 1 {
      return true
    } else {
      return false
    }
  }
  
  func isAgeValid() -> Bool {
    if self.count >= 1 {
      return true
    } else {
      return false
    }
  }
}
