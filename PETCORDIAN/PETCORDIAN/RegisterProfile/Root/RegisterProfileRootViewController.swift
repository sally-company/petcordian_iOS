//
//  RegisterProfileRootViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/20.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit

class RegisterProfileRootViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = RegisterProfileRootViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  // MARK: UI
  
  deinit {
    print("\(self)")
  }
  
  private func addProfileNameAgeView() {
    let profileNameAgeView = ProfileNameAgeBuilder.build(delegate: self)
    self.addChild(profileNameAgeView)
    self.view.addSubview(profileNameAgeView.view)
    profileNameAgeView.view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    self.didMove(toParent: self)
  }
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
    self.navigationController?.isNavigationBarHidden = false
  }
  
  // MARK: Layout
  
  private func setup() {
    self.addProfileNameAgeView()
  }
  
  func bind(reactor: Reactor) {
    
  }
}

extension RegisterProfileRootViewController: ProfileNameAgeViewControllerDelegate {
  
  func ProfileNameAgeViewControllerDidValidProfileNameAge() {
    let profileRelationScene = ProfileRelationBuilder.build(delegate: self)
    self.navigationController?.pushViewController(profileRelationScene, animated: true)
  }
}

extension RegisterProfileRootViewController: ProfileRelationViewControllerDelegate {
  
  func ProfileRelationViewControllerDidValidProfileRelation() {
    let vc = UIViewController()
    vc.view.backgroundColor = .white
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
