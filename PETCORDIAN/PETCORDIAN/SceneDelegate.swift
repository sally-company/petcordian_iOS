//
//  SceneDelegate.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/08.
//

import Inject
import NaverThirdPartyLogin
import netfox
import KakaoSDKAuth
import KakaoSDKCommon
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
    let vc = Inject.ViewControllerHost(SplashBuilder.build())
    let navController = UINavigationController(rootViewController: vc)
    navController.isNavigationBarHidden = true
    window?.rootViewController = HomeBuilder.build()//navController
    
    window?.makeKeyAndVisible()
    
    #if DEBUG
      NFX.sharedInstance().start()
    #endif
  }
  
  func scene(
    _ scene: UIScene,
    openURLContexts URLContexts: Set<UIOpenURLContext>
  ) {
    // Kakao
    if let url = URLContexts.first?.url {
      if (AuthApi.isKakaoTalkLoginUrl(url)) {
        _ = AuthController.handleOpenUrl(url: url)
      }
    }
    
    // Naver
    NaverThirdPartyLoginConnection
      .getSharedInstance()
      .receiveAccessToken(URLContexts.first?.url)
  }
}
