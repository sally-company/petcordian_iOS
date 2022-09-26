//
//  RadioButtonController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/19.
//

import UIKit

public class RadioButtonController: NSObject {
  
  var buttonArray: [UIButton]! {
    didSet {
      for button in buttonArray {
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.setBackgroundColor(.black, for: .selected)
      }
    }
  }
  
  var selectedButton: UIButton?
  var defaultButton = UIButton() {
    didSet {
      self.buttonArrayUpdated(buttonSelected: self.defaultButton)
    }
  }
  
  func buttonArrayUpdated(buttonSelected: UIButton) {
    for b in buttonArray {
      if b == buttonSelected {
        selectedButton = b
        b.isSelected = true
      } else {
        b.isSelected = false
      }
    }
  }
}
