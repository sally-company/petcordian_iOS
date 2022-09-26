//
//  BaseViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/26.
//

import UIKit

class BaseViewController: UIViewController {
  
  func showAlert(title: String, message: String, actionHandler: ((UIAlertAction) -> Void)?) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      
      let cancelAction = UIAlertAction(title: "취소", style: .default)
      alert.addAction(cancelAction)
      
      let okAction = UIAlertAction(title: "확인", style: .default, handler: actionHandler)
      alert.addAction(okAction)
      
      self.present(alert, animated: true)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}
