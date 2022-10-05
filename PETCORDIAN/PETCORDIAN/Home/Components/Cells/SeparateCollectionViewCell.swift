//
//  SeparateCollectionViewCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/05.
//

import SnapKit
import Then
import UIKit

class SeparateCollectionViewCell: UICollectionViewCell {
  
  private let separateView = UIView().then {
    $0.backgroundColor = .systemGray3
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func setup() {
    self.addSubview(self.separateView)
    
    self.separateView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
