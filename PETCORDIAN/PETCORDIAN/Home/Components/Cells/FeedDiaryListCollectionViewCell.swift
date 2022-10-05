//
//  FeedDiaryListCollectionViewCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import SnapKit
import UIKit

class FeedDiaryListCollectionViewCell: UICollectionViewCell {
  
  private let imageView = UIImageView().then {
    $0.image = UIImage(named: "")
    $0.contentMode = .scaleToFill
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func setup() {
    self.addSubview(self.imageView)
    
    self.imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  public func configure(with image: UIImage?) {
    self.imageView.image = image
  }
}
