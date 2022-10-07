//
//  DiaryListTitleCollectionViewCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/06.
//

import BonMot
import SnapKit
import Then
import UIKit

class DiaryListTitleCollectionViewCell: UICollectionViewCell {
  
  private let titleLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.attributedText = "프로필 계정".styled(
      with: StringStyle([
        .font(.systemFont(ofSize: 18)),
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
    self.addSubview(self.titleLabel)
    
    self.titleLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}
