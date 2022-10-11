//
//  CalendarCollectionViewCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/05.
//

import SnapKit
import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
  
  private let calendarView = CalendarView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    self.addSubview(calendarView)
    
    self.calendarView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
