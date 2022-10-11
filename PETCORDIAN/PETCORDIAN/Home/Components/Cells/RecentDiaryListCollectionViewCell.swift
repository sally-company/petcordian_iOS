//
//  RecentDiaryListCollectionViewCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import SnapKit
import UIKit

class RecentDiaryListCollectionViewCell: UICollectionViewCell {
  
  private let recentDiaryListView = RecentDiaryListView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {    
    self.addSubview(self.recentDiaryListView)
    
    self.recentDiaryListView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
