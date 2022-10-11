//
//  EmptyCollectionViewCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import BonMot
import SnapKit
import Then
import UIKit

class RecentDiaryEmptyCollectionViewCell: UICollectionViewCell {
  
  private let titleLabel = UILabel().then {
    $0.numberOfLines = 2
    $0.attributedText = "오늘의 일상을\n등록해 보라몽".styled(
      with: StringStyle([
        .font(.systemFont(ofSize: 14)),
        .color(.white)
      ]))
  }
  
  private let plusImageView = UIImageView().then {
    $0.image = UIImage(named: "plus")
    $0.contentMode = .scaleAspectFit
  }
  
  private let dateLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.textColor = .white
    $0.attributedText = Date().recentDiaryDate.styled(
      with: StringStyle([
        .font(.systemFont(ofSize: 14)),
        .color(.white)
      ]))
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func setup() {
    self.backgroundColor = .gray
    self.clipsToBounds = true
    self.layer.cornerRadius = 8
    
    self.addSubview(self.titleLabel)
    self.addSubview(self.dateLabel)
    self.addSubview(self.plusImageView)
    
    self.titleLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    
    self.dateLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(-7)
    }
    
    self.plusImageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.size.equalTo(34)
      $0.bottom.equalTo(self.dateLabel.snp.top).offset(-5)
    }
  }
}
