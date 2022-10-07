//
//  DiaryListPopupView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/06.
//

import BonMot
import ReusableKit
import SnapKit
import Then
import UIKit

public class DiaryListPopupView: UIView {
  
  enum Reusable {
    static let titleCell = ReusableCell<DiaryListTitleCollectionViewCell>()
    static let contentCell = ReusableCell<DiaryListContentCollectionViewCell>()
    static let newProfileCell = ReusableCell<DiaryListNewProfileCollectionViewCell>()
  }
  
  public lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout().then {
      $0.scrollDirection = .vertical
      $0.minimumLineSpacing = 0
      $0.minimumInteritemSpacing = 0
    }
  ).then {
    $0.isScrollEnabled = false
    $0.backgroundColor = .white
    $0.bounces = false
    $0.contentInsetAdjustmentBehavior = .never
    $0.dataSource = self
    $0.delegate = self
    $0.register(Reusable.titleCell)
    $0.register(Reusable.contentCell)
    $0.register(Reusable.newProfileCell)
  }
  
  private var collectionViewContentSizeObserver: NSKeyValueObservation?
  
  func startObserving() {
    self.collectionViewContentSizeObserver = self.collectionView.observe(\.contentSize, changeHandler: { [weak self] collection, _ in
      self?.collectionView.snp.makeConstraints {
        $0.height.equalTo(collection.contentSize.height + 32)
        
        self?.layoutIfNeeded()
      }
    })
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
    self.layer.cornerRadius = 24
    self.layer.masksToBounds = true
    self.backgroundColor = .white
    
    self.addSubview(self.collectionView)
    
    self.collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    self.startObserving()
  }
}

extension DiaryListPopupView: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sampleProfileList.count + 2
  }
  
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.item {
    case 0:
      let cell = collectionView.dequeue(Reusable.titleCell, for: indexPath)
      
      return cell
      
    case sampleProfileList.count + 2 - 1:
      let cell = collectionView.dequeue(Reusable.newProfileCell, for: indexPath)
      
      return cell
      
    default:
      let cell = collectionView.dequeue(Reusable.contentCell, for: indexPath)
      let profileData = sampleProfileList[indexPath.item - 1]
      cell.reactor = DiaryListContentItemReactor(profileInfoData: profileData)
      
      return cell
    }
  }
}

extension DiaryListPopupView: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width
    return .init(width: width, height: 60)
  }
}
