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
    guard let _ = (scene as? UIWindowScene) else { return }
    
    #if DEBUG
      NFX.sharedInstance().start()
    #endif
  }
}
