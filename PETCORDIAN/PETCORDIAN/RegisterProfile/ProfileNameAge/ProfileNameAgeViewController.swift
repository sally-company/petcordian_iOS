//
//  ProfileNameAgeViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/19.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

class ProfileNameAgeViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = ProfileNameAgeViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  private let radioButtonController = RadioButtonController()
  
  // MARK: UI
  
  private let contentView = ProfileNameAgeContentView()
  
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
    
    self.radioButtonController.buttonArray = [
      self.contentView.nameInputView.manButton,
      self.contentView.nameInputView.womanButton
    ]
    
    self.contentView.nameInputView.manButton.addTarget(self, action: #selector(manButtonAction(_:)), for: .touchUpInside)
    self.contentView.nameInputView.womanButton.addTarget(self, action: #selector(womanButtonAction(_:)), for: .touchUpInside)
  }
  
  // MARK: Layout
  
  private func setup() {
    self.view.backgroundColor = .white
  }
  
  // MARK: Action
  
  @objc func manButtonAction(_ sender: UIButton) {
    self.radioButtonController.buttonArrayUpdated(buttonSelected: sender)
  }
  
  @objc func womanButtonAction(_ sender: UIButton) {
    self.radioButtonController.buttonArrayUpdated(buttonSelected: sender)
  }
  
  // MARK: Binding
  
  func bind(reactor: Reactor) {
    
  }
}
