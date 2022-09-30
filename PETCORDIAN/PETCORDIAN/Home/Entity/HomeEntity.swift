//
//  HomeEntity.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/30.
//

import UIKit

public struct ProfileInfo {
  
  public init(id: Int, profileImg: UIImage?, petName: String) {
    self.id = id
    self.profileImg = profileImg
    self.petName = petName
  }
  
  public var id: Int
  public var profileImg: UIImage?
  public var petName: String
  
  public init() {
    self.id = 0
    self.profileImg = nil
    self.petName = ""
  }
}

public struct DiaryItem {
  public init(image: UIImage?, date: Date) {
    self.image = image
    self.date = date
  }
  
  public var image: UIImage?
  public var date: Date
}

public let sampleProfile = ProfileInfo(id: 0,
                                       profileImg: UIImage(named: "sampleProfileImage"),
                                       petName: "달짜몽")

public let sampleDiaryList: [DiaryItem] = [
  DiaryItem(image: UIImage(named: "sampleImage"), date: Date()),
  DiaryItem(image: UIImage(named: "sampleImage"), date: Date()),
  DiaryItem(image: UIImage(named: "sampleImage"), date: Date()),
  DiaryItem(image: UIImage(named: "sampleImage"), date: Date())
]
