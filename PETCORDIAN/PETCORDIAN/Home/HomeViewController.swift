//
//  HomeViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

class HomeViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = HomeViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  // MARK: UI
  
  private let contentView = HomeContentView()
  
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
