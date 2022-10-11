//
//  Date+Formatter.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import Foundation

fileprivate let formatter = DateFormatter()

extension Date {
  
  var recentDiaryDate: String {
    formatter.dateFormat = "yy.MM.dd"
    
    return formatter.string(from: self)
  }
}
