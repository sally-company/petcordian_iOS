//
//  RecentDiaryListView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import BonMot
import ReusableKit
import SnapKit
import Then
import UIKit

class RecentDiaryListView: UIView {
  
  enum Reusable {
    static let recentDiaryCell = ReusableCell<RecentDiaryCollectionViewCell>()
    static let emptyCell = ReusableCell<RecentDiaryEmptyCollectionViewCell>()
  }
  
  public lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout().then {
      $0.minimumInteritemSpacing = 10
      $0.scrollDirection = .horizontal
    }
  ).then {
    $0.register(Reusable.recentDiaryCell)
    $0.register(Reusable.emptyCell)
    $0.dataSource = self
    $0.delegate = self
    $0.backgroundColor = .clear
    $0.showsHorizontalScrollIndicator = false
    $0.showsVerticalScrollIndicator = false
    $0.isScrollEnabled = true
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    self.backgroundColor = .clear
    
    self.addSubview(self.collectionView)
    
    self.collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

extension RecentDiaryListView: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sampleDiaryList.count + 1
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.item == sampleDiaryList.count {
      let cell = collectionView.dequeue(Reusable.emptyCell, for: indexPath)

      return cell
    } else {
      let cell = collectionView.dequeue(Reusable.recentDiaryCell, for: indexPath)
      cell.configure(index: indexPath.item)
      
      return cell
    }
  }
}

extension RecentDiaryListView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: UIScreen.main.bounds.width / 3, height: 201)
  }
}
