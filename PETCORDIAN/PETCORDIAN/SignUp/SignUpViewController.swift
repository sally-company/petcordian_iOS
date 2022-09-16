//
//  SignUpViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/16.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

class SignUpViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = SignUpViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  // MARK: UI
  
  private let contentView = SignUpContentView()
  
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
