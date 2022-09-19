//
//  UnderLineTextField.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/19.
//

import SnapKit
import Then
import UIKit

class UnderLineTextField: UITextField {
  
  private lazy var placeholderColor: UIColor = .systemGray3
  private lazy var placeholderString: String = ""
  
  private let underLineView = UIView().then {
    $0.backgroundColor = .white
  }
  
  public let checkImageView = UIImageView().then {
    $0.image = UIImage(named: "check")
    $0.contentMode = .scaleAspectFit
    $0.isHidden = true
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(self.underLineView)
    self.addSubview(self.checkImageView)
    
    self.underLineView.snp.makeConstraints {
      $0.top.equalTo(self.snp.bottom).offset(-2)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(2)
    }
    
    self.checkImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.height.equalTo(12)
      $0.width.equalTo(17)
      $0.right.equalTo(-5)
    }
    
    self.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
    self.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setPlaceholder(placeholder: String, color: UIColor) {
    placeholderString = placeholder
    placeholderColor = color
    
    self.setPlaceholder()
    self.underLineView.backgroundColor = placeholderColor
  }
  
  private func setPlaceholder() {
    self.attributedPlaceholder = NSAttributedString(
      string: placeholderString,
      attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
    )
  }
}

extension UnderLineTextField {
  @objc func editingDidBegin() {
    setPlaceholder()
    underLineView.backgroundColor = .black
  }
  
  @objc func editingDidEnd() {
    underLineView.backgroundColor = placeholderColor
  }
}
