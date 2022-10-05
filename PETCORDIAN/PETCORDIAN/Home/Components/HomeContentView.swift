//
//  HomeContentView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import BonMot
import ReusableKit
import SnapKit
import Then
import UIKit

public class HomeContentView: UIView {
  
  enum Reusable {
    static let buttonCell = ReusableCell<ButtonCollectionViewCell>()
    static let recentDiaryListCell = ReusableCell<RecentDiaryListCollectionViewCell>()
    static let feedDiaryListCell = ReusableCell<FeedDiaryListCollectionViewCell>()
    static let emptyCell = ReusableCell<FeedDiaryEmptyCollectionViewCell>()
    static let separateCell = ReusableCell<SeparateCollectionViewCell>()
  }
  
  public lazy var collectionView = DynamicHeightCollectionView(
    frame: .zero,
    collectionViewLayout:
      UICollectionViewFlowLayout().then {
      $0.scrollDirection = .vertical
      $0.minimumLineSpacing = 20
      $0.minimumInteritemSpacing = 0
    }
  ).then {
    $0.register(Reusable.buttonCell)
    $0.register(Reusable.recentDiaryListCell)
    $0.register(Reusable.feedDiaryListCell)
    $0.register(Reusable.emptyCell)
    $0.register(Reusable.separateCell)
    $0.isScrollEnabled = true
    $0.backgroundColor = .white
    $0.contentInsetAdjustmentBehavior = .never
    $0.dataSource = self
    $0.delegate = self
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
    self.addSubview(self.collectionView)
    
    self.collectionView.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide)
      $0.left.right.bottom.equalToSuperview()
    }
  }
}

extension HomeContentView: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sampleDiaryList.isEmpty ? 4 : sampleDiaryList.count + 3
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.item {
    case 0:
      let cell = collectionView.dequeue(Reusable.buttonCell, for: indexPath)
      
      return cell
      
    case 1:
      let cell = collectionView.dequeue(Reusable.recentDiaryListCell, for: indexPath)
      
      return cell
      
    case 2:
      let cell = collectionView.dequeue(Reusable.separateCell, for: indexPath)
      
      return cell
      
    default:
      if sampleDiaryList.isEmpty {
        let cell = collectionView.dequeue(Reusable.emptyCell, for: indexPath)
        
        return cell
      } else {
        let cell = collectionView.dequeue(Reusable.feedDiaryListCell, for: indexPath)
        
        let target = sampleDiaryList[indexPath.item - 3].image
        cell.configure(with: target)
        
        return cell
      }
    }
  }
}

extension HomeContentView: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    switch indexPath.item {
    case 0:
      return .init(width: width, height: 50)

    case 1:
      return .init(width: width, height: 201)

    case 2:
      return .init(width: width, height: 8)
      
    default:
      return sampleDiaryList.isEmpty ?
        .init(width: width, height: height - 50 - 201 - 44) :
        .init(width: UIScreen.main.bounds.width - 48, height: 150)
    }
  }
}
