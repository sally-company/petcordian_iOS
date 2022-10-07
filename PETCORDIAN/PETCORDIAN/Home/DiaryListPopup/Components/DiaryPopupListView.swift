//
//  DiaryPopupListView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/06.
//

import BonMot
import ReactorKit
import ReusableKit
import SnapKit
import Then
import UIKit

protocol DiaryPopupListViewDelegate: AnyObject {
  func diaryPopupListViewItemDidTap()
}

class DiaryPopupListView
: UIView,
  ReactorKit.View {
  
  typealias Reactor = DiaryPopupListViewReactor
  
  enum Reusable {
    static let titleCell = ReusableCell<DiaryListTitleCollectionViewCell>()
    static let contentCell = ReusableCell<DiaryListContentCollectionViewCell>()
    static let newProfileCell = ReusableCell<DiaryListNewProfileCollectionViewCell>()
  }
  
  weak var delegate: DiaryPopupListViewDelegate?
  
  public var disposeBag: DisposeBag = .init()
  
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
  
  func bind(reactor: Reactor) {
  }
}

extension DiaryPopupListView: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let itemCount = self.reactor?.diaryListContentItemReactors.count ?? 0
    if itemCount == 5 {
      return itemCount + 1
    }

    return itemCount + 2
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
      if let diaryListContentItemReactor = self.reactor?.diaryListContentItemReactors[indexPath.item - 1] {
        cell.reactor = diaryListContentItemReactor
      }
      
      return cell
    }
  }
}

extension DiaryPopupListView: UICollectionViewDelegate {
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let itemCount = self.reactor?.diaryListContentItemReactors.count ?? 0
    if indexPath.item != 0 && indexPath.item != itemCount + 2 - 1 {
      delegate?.diaryPopupListViewItemDidTap()
    }
  }
}

extension DiaryPopupListView: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width
    return .init(width: width, height: 60)
  }
}
