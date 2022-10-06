//
//  CalendarView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/06.
//

import BonMot
import FSCalendar
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

public class CalendarView: UIView {
  
  private let headerView = CalendarHeaderView()
  
  fileprivate lazy var calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 300, height: 300)).then {
    $0.dataSource = self
    $0.delegate = self
    $0.appearance.titleTodayColor = .black
    $0.appearance.titleSelectionColor = .black
    $0.appearance.todayColor = .clear
    $0.appearance.selectionColor = .clear
    $0.headerHeight = 0
    $0.placeholderType = .none
    self.setDate($0)
  }
  
  private let disposeBag: DisposeBag = .init()
  
  private var currentPage: Date?
  
  private var today = Date()
  
  private let dateFormatter = DateFormatter().then {
    $0.locale = Locale(identifier: "ko_KR")
  }
  
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
    self.changeWeekdayTextColor()
    self.addSubview(self.headerView)
    self.addSubview(self.calendar)
    
    self.headerView.snp.makeConstraints {
      $0.left.top.right.equalToSuperview()
      $0.height.equalTo(70)
    }
    
    self.calendar.snp.makeConstraints {
      $0.top.equalTo(self.headerView.snp.bottom)
      $0.left.right.bottom.equalToSuperview()
    }
  }
  
  private func changeWeekdayTextColor() {
    calendar.calendarWeekdayView.weekdayLabels[0].textColor = .red
    for i in 1...5 {
      calendar.calendarWeekdayView.weekdayLabels[i].textColor = .black
    }
  }
  
  private func bind() {
    self.bindPreviousButton()
    self.bindNextButton()
  }
  
  private func bindPreviousButton() {
    self.headerView.previousButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(with: self) { obj, _ in
        obj.scrollCurrentPage(isPrev: true)
      }
      .disposed(by: self.disposeBag)
  }
  
  private func bindNextButton() {
    self.headerView.nextButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(with: self) { obj, _ in
        obj.scrollCurrentPage(isPrev: false)
      }
      .disposed(by: self.disposeBag)
  }
  
  private func scrollCurrentPage(isPrev: Bool) {
    let cal = Calendar.current
    var dateComponents = DateComponents()
    dateComponents.month = isPrev ? -1 : 1
    
    self.currentPage = cal.date(
      byAdding: dateComponents,
      to: self.currentPage ?? self.today)
    self.calendar.setCurrentPage(self.currentPage ?? Date(), animated: true)
  }
  
  private func setDate(_ calendar: FSCalendar?) {
    self.dateFormatter.dateFormat = "MM월"
    self.headerView.date = dateFormatter.string(from: calendar?.currentPage ?? Date())
  }
}

extension CalendarView: FSCalendarDataSource {
  
  public func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
    var image = UIImage(named: "sampleImage")
    let width = self.calendar.collectionViewLayout.estimatedItemSize.width
    let height = self.calendar.collectionViewLayout.estimatedItemSize.height

    image = image?.resized(to: .init(width: width, height: height))

    self.dateFormatter.dateFormat = "yyyy-MM-dd"
    if self.dateFormatter.string(from: date) == self.dateFormatter.string(from: Date()) {
      return image
    } else {
      return nil
    }
  }
}

extension CalendarView: FSCalendarDelegate {
  
  public func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
    calendar.snp.updateConstraints {
      $0.height.equalTo(self.bounds.height)
    }

    self.layoutIfNeeded()
  }

  public func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
    self.setDate(calendar)
  }

  public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    print(date.recentDiaryDate)
  }
}

extension CalendarView {
  
  public class CalendarHeaderView: UIView {
    
    enum Typo {
      static let date = StringStyle([
        .font(.boldSystemFont(ofSize: 24)),
        .color(.black)
      ])
    }
    
    public let previousButton = UIButton().then {
      $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
      $0.tintColor = .black
    }
    
    public var dateLabel = UILabel().then {
      $0.numberOfLines = 1
      $0.textAlignment = .center
    }
    
    public let nextButton = UIButton().then {
      $0.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
      $0.tintColor = .black
    }
    
    public var date: String {
      set {
        self.dateLabel.attributedText = newValue.styled(with: Typo.date)
        self.layoutIfNeeded()
      }
      get {
        self.dateLabel.text ?? ""
      }
    }
    
    public override init(frame: CGRect) {
      super.init(frame: frame)
      self.setup()
    }
    
    public required init?(coder: NSCoder) {
      super.init(coder: coder)
      self.setup()
    }
    
    private func setup() {
      let stack = self.layout()
      
      self.addSubview(stack)
      
      stack.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
    
    private func layout() -> UIView {
      return UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        
        $0.addArrangedSubview(self.previousButton)
        $0.addArrangedSubview(self.dateLabel)
        $0.addArrangedSubview(self.nextButton)
      }
    }
  }
}
