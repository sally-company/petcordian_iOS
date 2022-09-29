//
//  AppDelegate.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/08.
//

import FirebaseCore
import GoogleSignIn
import NaverThirdPartyLogin
import KakaoSDKAuth
import KakaoSDKCommon
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Kakao
    KakaoSDK.initSDK(appKey: "7e6fbc0aab90753a9de39fa70c970707")
    
    // Google, Firebase
    FirebaseApp.configure()
    
    // Naver
    let instance = NaverThirdPartyLoginConnection.getSharedInstance()
    instance?.isNaverAppOauthEnable = true // 네이버 앱 인증
    instance?.isInAppOauthEnable = true // 사파리에서 인증
    instance?.isOnlyPortraitSupportedInIphone()
    
    instance?.serviceUrlScheme = "naverdev"
    instance?.consumerKey = "Zi8lwShFoOXEWmtzX6So"
    instance?.consumerSecret = "Xc0BLq6Yzz"
    instance?.appName = "펫코디언"
    
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    // Kakao
    if (AuthApi.isKakaoTalkLoginUrl(url)) {
      return AuthController.handleOpenUrl(url: url)
    }
    
    // Google
    var googleHandled: Bool
    
    googleHandled = GIDSignIn.sharedInstance.handle(url)
    if googleHandled {
      return true
    }
    
    // Naver
    NaverThirdPartyLoginConnection
      .getSharedInstance()
      .application(app, open: url, options: options)
    
    return false
  }
}
