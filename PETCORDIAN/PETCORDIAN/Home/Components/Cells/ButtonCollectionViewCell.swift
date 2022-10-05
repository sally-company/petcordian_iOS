//
//  ButtonCollectionViewCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import SnapKit
import Then
import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
  
  private let alarmButton = UIButton().then {
    $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    $0.backgroundColor = .white
    $0.setTitle("펫코디언의 알람", for: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.cornerRadius = 18
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
    self.addSubview(self.alarmButton)
    
    self.alarmButton.snp.makeConstraints {
      $0.left.equalTo(24)
      $0.centerY.equalToSuperview()
    }
  }
}
