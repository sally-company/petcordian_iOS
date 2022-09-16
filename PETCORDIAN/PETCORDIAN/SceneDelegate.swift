//
//  SceneDelegate.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/08.
//

import Inject
import netfox
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
//    let vc = Inject.ViewControllerHost(SplashBuilder.build())
//    let navController = UINavigationController(rootViewController: vc)
//    window?.rootViewController = navController
    let vc = TestViewController()
    window?.rootViewController = vc
    
    window?.makeKeyAndVisible()
    
    #if DEBUG
      NFX.sharedInstance().start()
    #endif
  }
}

import SnapKit

class TestViewController: UIViewController {
  
  let testView = ProfileNameAgeContentView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    self.view.addSubview(testView)
    
    testView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
