//
//  HomeEntity.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/30.
//

import UIKit

public enum Gender: String {
  case man = "남아"
  case woman = "여아"
}

public struct ProfileInfo {
  
  public init(id: Int, profileImg: UIImage?, petName: String, gender: Gender, age: Int, isSelected: Bool) {
    self.id = id
    self.profileImg = profileImg
    self.petName = petName
    self.gender = gender
    self.age = age
    self.isSelected = isSelected
  }
  
  public var id: Int
  public var profileImg: UIImage?
  public var petName: String
  public var gender: Gender
  public var age: Int
  public var isSelected: Bool
  
  public init() {
    self.id = 0
    self.profileImg = nil
    self.petName = ""
    self.gender = Gender.woman
    self.age = 1
    self.isSelected = true
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

public var sampleProfileList: [ProfileInfo] = [ ProfileInfo(id: 0,
                                                            profileImg: UIImage(named: "sampleProfileImage"),
                                                            petName: "달짜몽",
                                                            gender: .woman,
                                                            age: 1,
                                                            isSelected: true),
                                                
                                                ProfileInfo(id: 1,
                                                            profileImg: UIImage(named: "sampleProfileImage"),
                                                            petName: "짜몽",
                                                            gender: .man,
                                                            age: 3,
                                                            isSelected: false),
                                                
                                                ProfileInfo(id: 2,
                                                            profileImg: UIImage(named: "sampleProfileImage"),
                                                            petName: "달짜",
                                                            gender: .woman,
                                                            age: 5,
                                                            isSelected: false)
]

public let sampleProfile = ProfileInfo(id: 0,
                                       profileImg: UIImage(named: "sampleProfileImage"),
                                       petName: "달짜몽",
                                       gender: .woman,
                                       age: 1,
                                       isSelected: true)

public var sampleDiaryList: [DiaryItem] = [
  DiaryItem(image: UIImage(named: "sampleImage"), date: Date()),
  DiaryItem(image: UIImage(named: "sampleImage"), date: Date()),
  DiaryItem(image: UIImage(named: "sampleImage"), date: Date()),
  DiaryItem(image: UIImage(named: "sampleImage"), date: Date()),
  DiaryItem(image: UIImage(named: "sampleImage"), date: Date()),
  DiaryItem(image: UIImage(named: "sampleImage"), date: Date()),
  DiaryItem(image: UIImage(named: "sampleImage"), date: Date()),
  DiaryItem(image: UIImage(named: "sampleImage"), date: Date())
]
