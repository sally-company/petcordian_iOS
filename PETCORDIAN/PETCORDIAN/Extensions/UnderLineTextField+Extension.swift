//
//  UnderLineTextField+Extension.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/20.
//

import UIKit

extension UnderLineTextField {
  
  public typealias UITextFieldTargetClosure = (UnderLineTextField) -> ()
  
  private class UITextFieldClosureWrapper: NSObject {
    let closure: UITextFieldTargetClosure
    init(_ closure: @escaping UITextFieldTargetClosure) {
      self.closure = closure
    }
  }
  
  private struct AssociatedKeys {
    static var targetClosure = "targetClosure"
  }
  
  private var targetClosure: UITextFieldTargetClosure? {
    get {
      guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure)
              as? UITextFieldClosureWrapper else { return nil }
      return closureWrapper.closure
    }
    
    set(newValue) {
      guard let newValue = newValue else { return }
      objc_setAssociatedObject(self,
                               &AssociatedKeys.targetClosure,
                               UITextFieldClosureWrapper(newValue),
                               objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  @objc func closureAction() {
    guard let targetClosure = targetClosure else { return }
    targetClosure(self)
  }
  
  public func addAction(for event: UITextField.Event, closure: @escaping UITextFieldTargetClosure) {
    targetClosure = closure
    addTarget(self, action: #selector(UnderLineTextField.closureAction), for: event)
  }
}
