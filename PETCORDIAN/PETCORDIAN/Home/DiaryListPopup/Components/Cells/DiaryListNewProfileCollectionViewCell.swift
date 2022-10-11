//
//  DiaryListNewProfileCollectionViewCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/06.
//

import BonMot
import SnapKit
import Then
import UIKit

class DiaryListNewProfileCollectionViewCell: UICollectionViewCell {
  
  private let plusImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = 24
    $0.layer.masksToBounds = true
    $0.image = UIImage(named: "plus")
    $0.backgroundColor = .purple
  }
  
  private let titleLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.attributedText = "새로운 가족 추가하기".styled(
      with: StringStyle([
        .font(.boldSystemFont(ofSize: 16)),
        .color(.black)
      ]))
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
    self.addSubview(self.plusImageView)
    self.addSubview(self.titleLabel)
    
    self.plusImageView.snp.makeConstraints {
      $0.size.equalTo(48)
      $0.left.equalTo(24)
      $0.centerY.equalToSuperview()
    }
    
    self.titleLabel.snp.makeConstraints {
      $0.left.equalTo(self.plusImageView.snp.right).offset(11)
      $0.centerY.equalToSuperview()
    }
  }
}
