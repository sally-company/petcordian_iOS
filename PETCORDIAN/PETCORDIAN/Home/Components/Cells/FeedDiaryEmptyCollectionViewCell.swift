//
//  FeedDiaryEmptyCollectionViewCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/05.
//

import BonMot
import SnapKit
import Then
import UIKit

class FeedDiaryEmptyCollectionViewCell: UICollectionViewCell {
  
  private let emptyView = UIView().then {
    $0.layer.cornerRadius = 10
    $0.layer.masksToBounds = true
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.black.cgColor
  }
  
  private let contentLabel = UILabel().then {
    $0.numberOfLines = 3
    $0.textAlignment = .center
    $0.attributedText = "아직 작성된 일기가 없다몽...\n사진을 등로하면 반려동물의 기분을\n확인할 수 있다몽!".styled(
      with: StringStyle([
        .font(.systemFont(ofSize: 15)),
        .color(.gray)
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
    self.addSubview(self.emptyView)
    self.emptyView.addSubview(self.contentLabel)
    
    self.emptyView.snp.makeConstraints {
      $0.left.top.equalTo(18)
      $0.right.equalTo(-18)
      $0.bottom.equalTo(-40)
    }
    
    self.contentLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}
