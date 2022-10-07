//
//  DiaryListPopupViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/06.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

class DiaryListPopupViewController: BottomSheetPopViewController, ReactorKit.View {
  
  typealias Reactor = DiaryListPopupViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  // MARK: UI
  
  private lazy var backgroundView = UIView().then {
    $0.backgroundColor = .clear
    let recognizer = UITapGestureRecognizer(target: self,
                                            action: #selector(handleTap(recognizer:)))
    $0.addGestureRecognizer(recognizer)
  }
  
  private let contentView = DiaryListPopupView()
  
  deinit {
    print("\(self)")
  }
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
  }
  
  // MARK: Layout
  
  private func setup() {
    self.view.backgroundColor = .clear
    
    self.view.addSubview(self.backgroundView)
    self.view.addSubview(self.contentView)
    
    self.backgroundView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    self.contentView.snp.makeConstraints {
      $0.left.right.bottom.equalToSuperview()
    }
  }
  
  @objc func handleTap(recognizer: UITapGestureRecognizer) {
    self.dismiss(animated: true)
  }
  
  func bind(reactor: Reactor) {
    
  }
}
