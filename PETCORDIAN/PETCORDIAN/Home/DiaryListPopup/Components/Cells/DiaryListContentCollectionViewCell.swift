//
//  DiaryListContentCollectionViewCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/06.
//

import BonMot
import ReactorKit
import RxSwift
import SnapKit
import Then
import UIKit

class DiaryListContentCollectionViewCell
: UICollectionViewCell
, ReactorKit.View {
  
  typealias Reactor = DiaryListContentItemReactor
  
  var disposeBag: DisposeBag = .init()
  
  enum Typo {
    static let name = StringStyle([
      .font(.boldSystemFont(ofSize: 16)),
      .color(.black)
    ])
    
    static let subTitle = StringStyle([
      .font(.systemFont(ofSize: 16)),
      .color(.lightGray)
    ])
  }
  
  private let profileImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = 24
    $0.layer.masksToBounds = true
  }
  
  private let nameLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  private let genderLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  private let dotLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.attributedText = "·".styled(
      with: StringStyle([
        .font(.systemFont(ofSize: 16)),
        .color(.lightGray)
      ]))
  }
  
  private let ageLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  private let checkImageView = UIImageView().then {
    $0.image = UIImage(named: "profileCheck")
    $0.contentMode = .scaleAspectFill
    $0.isHidden = true
  }
  
  private var name: String {
    set {
      self.nameLabel.attributedText = newValue.styled(with: Typo.name)
      self.layoutIfNeeded()
    }
    get {
      self.nameLabel.text ?? ""
    }
  }
  
  private var gender: String {
    set {
      self.genderLabel.attributedText = newValue.styled(with: Typo.subTitle)
      self.layoutIfNeeded()
    }
    get {
      self.genderLabel.text ?? ""
    }
  }
  
  private var age: String {
    set {
      self.ageLabel.attributedText = "\(newValue)살".styled(with: Typo.subTitle)
      self.layoutIfNeeded()
    }
    get {
      self.ageLabel.text ?? ""
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    let stack = self.profileInfolayout()
    
    self.addSubview(self.profileImageView)
    self.addSubview(stack)
    self.addSubview(self.checkImageView)
    
    self.profileImageView.snp.makeConstraints {
      $0.size.equalTo(48)
      $0.left.equalTo(24)
      $0.centerY.equalToSuperview()
    }
    
    stack.snp.makeConstraints {
      $0.left.equalTo(self.profileImageView.snp.right).offset(11)
      $0.centerY.equalToSuperview()
    }
    
    self.checkImageView.snp.makeConstraints {
      $0.size.equalTo(26)
      $0.right.equalTo(-27)
      $0.centerY.equalToSuperview()
    }
  }
  
  private func profileInfolayout() -> UIView {
    return UIStackView().then {
      $0.axis = .vertical
      $0.distribution = .fill
      $0.alignment = .fill
      $0.spacing = 5
      
      let genderAgeStack = self.layout()
      
      $0.addArrangedSubview(self.nameLabel)
      $0.addArrangedSubview(genderAgeStack)
    }
  }
  
  private func layout() -> UIView {
    return UIStackView().then {
      $0.axis = .horizontal
      $0.distribution = .fill
      $0.alignment = .fill
      $0.spacing = 3
      
      $0.addArrangedSubview(self.genderLabel)
      $0.addArrangedSubview(self.dotLabel)
      $0.addArrangedSubview(self.ageLabel)
    }
  }
  
  func bind(reactor: Reactor) {
    let data = reactor.currentState.profileInfoData
    
    self.profileImageView.image = data.profileImg
    self.name = data.petName
    self.gender = data.gender.rawValue
    self.age = data.age.description
    self.checkImageView.isHidden = !data.isSelected
  }
}
