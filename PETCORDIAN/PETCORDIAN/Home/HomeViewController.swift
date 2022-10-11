//
//  HomeViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

class HomeViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = HomeViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  // MARK: UI
  
  private lazy var contentView = HomeContentView().then {
    $0.delegate = self
  }
  
  deinit {
    print("\(self)")
  }
  
  // MARK: View Life Cycle
  
  override func loadView() {
    self.view = self.contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
  }
  
  // MARK: Layout
  
  private func setup() {
    self.view.backgroundColor = .white
  }
  
  func bind(reactor: Reactor) {
    
  }
}

extension HomeViewController: HomeContentViewDelegate {
  
  func homeContentViewAlarmButtonTap() {
    let vc = DiaryListPopupBuilder.build()
    
    self.present(vc, animated: true)
  }
}
