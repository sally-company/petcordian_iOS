//
//  RelationItem.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/21.
//

import Foundation

struct RelationItem {
  let name: String
  
  init(name: String) {
    self.name = name
  }
  
  static let relationItems: [RelationItem] = [
  RelationItem(name: "엄마"),
  RelationItem(name: "아빠"),
  RelationItem(name: "언니"),
  RelationItem(name: "누나"),
  RelationItem(name: "오빠"),
  RelationItem(name: "형아"),
  RelationItem(name: "집사"),
  RelationItem(name: "기타")
  ]
}
