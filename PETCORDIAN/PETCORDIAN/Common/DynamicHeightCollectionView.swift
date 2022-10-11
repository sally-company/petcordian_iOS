//
//  DynamicHeightCollectionView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import UIKit

public class DynamicHeightCollectionView: UICollectionView {
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    if bounds.size != self.intrinsicContentSize && !self.isScrollEnabled {
      self.invalidateIntrinsicContentSize()
    }
  }
  
  public override var intrinsicContentSize: CGSize {
    return contentSize
  }
}
