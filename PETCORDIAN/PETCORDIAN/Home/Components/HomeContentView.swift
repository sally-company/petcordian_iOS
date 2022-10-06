//
//  HomeContentView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import BonMot
import ReusableKit
import RxCocoa
import RxSwift
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
    static let calendarCell = ReusableCell<CalendarCollectionViewCell>()
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
    $0.register(Reusable.calendarCell)
    $0.isScrollEnabled = true
    $0.backgroundColor = .white
    $0.contentInsetAdjustmentBehavior = .never
    $0.dataSource = self
    $0.delegate = self
  }
  
  private let toggleButtonView = ToggleButtonView()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
    self.bind()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    self.addSubview(self.collectionView)
    self.addSubview(self.toggleButtonView)
    
    self.collectionView.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide)
      $0.left.right.bottom.equalToSuperview()
    }
    
    self.toggleButtonView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(-32)
      $0.height.equalTo(48)
      $0.width.equalTo(180)
    }
  }
  
  let disposeBag: DisposeBag = .init()
  
  private var isSelectedCalendarView: Bool = false
  
  private func bind() {
    self.toggleButtonView.calendarTypeButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(with: self) { obj, _ in
        obj.isSelectedCalendarView = true
        obj.collectionView.reloadItems(at: [IndexPath(item: 3, section: 0)])
      }
      .disposed(by: self.disposeBag)
    
    self.toggleButtonView.feedTypeButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(with: self) { obj, _ in
        obj.isSelectedCalendarView = false
        obj.collectionView.reloadItems(at: [IndexPath(item: 3, section: 0)])
      }
      .disposed(by: self.disposeBag)
  }
}

extension HomeContentView: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if self.isSelectedCalendarView == true {
      return 4
    } else {
      return sampleDiaryList.isEmpty ? 4 : sampleDiaryList.count + 3
    }
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
      
      if self.isSelectedCalendarView == true {
        let cell = collectionView.dequeue(Reusable.calendarCell, for: indexPath)
        
        return cell
      } else {
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
      if self.isSelectedCalendarView == true {
        return .init(width: width, height: 370)
      } else {
        return sampleDiaryList.isEmpty ?
          .init(width: width, height: height - 50 - 201 - 44) :
          .init(width: UIScreen.main.bounds.width - 48, height: 150)
      }
    }
  }
}

extension HomeContentView {
  
  public class ToggleButtonView: UIView {
    
    private let radioButtonController = RadioButtonController()
    
    public let calendarTypeButton = UIButton().then {
      $0.setTitle("달력형", for: .normal)
    }
    
    public let feedTypeButton = UIButton().then {
      $0.isSelected = true
      $0.setTitle("피드형", for: .normal)
    }
    
    public override init(frame: CGRect) {
      super.init(frame: frame)
      self.setup()
    }
    
    public required init?(coder: NSCoder) {
      super.init(coder: coder)
      fatalError("init(coder:) has not been implemented")
    }
    
    @objc func calendarTypeButtonAction(_ sender: UIButton) {
      self.radioButtonController.buttonArrayUpdated(buttonSelected: sender)
    }
    
    @objc func feedTypeButtonAction(_ sender: UIButton) {
      self.radioButtonController.buttonArrayUpdated(buttonSelected: sender)
    }
    
    private func setup() {
      self.backgroundColor = .systemGray3
      
      let stack = self.layout()
      self.addSubview(stack)
      
      stack.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
      
      self.radioButtonController.buttonArray = [
        self.calendarTypeButton,
        self.feedTypeButton
      ]
      
      self.calendarTypeButton.addTarget(self, action: #selector(calendarTypeButtonAction), for: .touchUpInside)
      self.feedTypeButton.addTarget(self, action: #selector(feedTypeButtonAction), for: .touchUpInside)
    }
    
    private func layout() -> UIView {
      return UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 0
        
        $0.addArrangedSubview(self.calendarTypeButton)
        $0.addArrangedSubview(self.feedTypeButton)
      }
    }
  }
}
