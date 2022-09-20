//
//  InputView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/19.
//

import BonMot
import SnapKit
import Then
import UIKit

extension ProfileNameAgeContentView {
  
  public class InputView: UIView {
    
    private let nameInputView = NameInputView()
    private let ageInputView = AgeInputView()
    
    private let genderLabel = UILabel().then {
      $0.numberOfLines = 1
      $0.attributedText = "성별".styled(
        with: StringStyle([
          .font(.systemFont(ofSize: 14)),
          .color(.systemGray3)
        ]))
      $0.setContentHuggingPriority(.init(rawValue: 999), for: .vertical)
    }
    
    public let manButton = UIButton().then {
      $0.backgroundColor = .white
      $0.layer.borderWidth = 1
      $0.layer.borderColor = UIColor.black.cgColor
      $0.setTitle("남아", for: .normal)
      $0.setTitleColor(.black, for: .normal)
      $0.layer.cornerRadius = 20
      $0.clipsToBounds = true
    }
    
    public let womanButton = UIButton().then {
      $0.backgroundColor = .white
      $0.layer.borderWidth = 1
      $0.layer.borderColor = UIColor.black.cgColor
      $0.setTitle("여아", for: .normal)
      $0.setTitleColor(.black, for: .normal)
      $0.layer.cornerRadius = 20
      $0.clipsToBounds = true
    }
    
    public override init(frame: CGRect) {
      super.init(frame: frame)
      self.setup()
    }
    
    public required init?(coder: NSCoder) {
      super.init(coder: coder)
      fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize: CGSize {
      return .init(width: UIView.noIntrinsicMetric, height: 160)
    }
    
    private func setup() {
      let stack = self.allContentLayout()
      
      self.addSubview(stack)
      
      stack.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
    
    private func buttonLayout() -> UIView {
      return UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 14
        
        $0.addArrangedSubview(self.manButton)
        $0.addArrangedSubview(self.womanButton)
      }
    }
    
    private func genderLayout() -> UIView {
      return UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 10
        
        let buttonStack = self.buttonLayout()
        
        $0.addArrangedSubview(self.genderLabel)
        $0.addArrangedSubview(buttonStack)
      }
    }
    
    private func ageGenderLayout() -> UIView {
      return UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 14
        
        let genderStack = self.genderLayout()
        
        $0.addArrangedSubview(ageInputView)
        $0.addArrangedSubview(genderStack)
      }
    }
    
    private func allContentLayout() -> UIView {
      return UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 7
        
        let ageGenderStack = self.ageGenderLayout()
        
        $0.addArrangedSubview(self.nameInputView)
        $0.addArrangedSubview(ageGenderStack)
      }
    }
  }
}

private class NameInputView: UIView {
  
  private let nameLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.attributedText = "이름".styled(
      with: StringStyle([
        .font(.systemFont(ofSize: 14)),
        .color(.systemGray3)
      ]))
    $0.setContentHuggingPriority(.init(rawValue: 999), for: .vertical)
  }
  
  private lazy var nameTextField = UnderLineTextField().then {
    $0.addAction(for: .editingChanged) { nameTextField in
      if nameTextField.text == "" {
        nameTextField.checkImageView.isHidden = true
      } else {
        nameTextField.checkImageView.isHidden = false
      }
    }
    $0.setPlaceholder(placeholder: "반려동물의 이름을 입력해주세요", color: .systemGray3)
    $0.layer.masksToBounds = true
    $0.autocorrectionType = .no
    $0.delegate = self
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    let stack = self.nameLayout()
    
    self.addSubview(stack)
    
    stack.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func nameLayout() -> UIView {
    return UIStackView().then {
      $0.axis = .vertical
      $0.distribution = .fill
      $0.alignment = .fill
      $0.spacing = 10
      
      $0.addArrangedSubview(self.nameLabel)
      $0.addArrangedSubview(self.nameTextField)
    }
  }
}

extension NameInputView: UITextFieldDelegate {

  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
}

public class AgeInputView: UIView {
  
  private let ageLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.attributedText = "나이".styled(
      with: StringStyle([
        .font(.systemFont(ofSize: 14)),
        .color(.systemGray3)
      ]))
    $0.setContentHuggingPriority(.init(rawValue: 999), for: .vertical)
  }
  
  private lazy var ageTextField = UnderLineTextField().then {
    $0.addAction(for: .editingChanged) { ageTextField in
      if ageTextField.text == "" {
        ageTextField.checkImageView.isHidden = true
      } else {
        ageTextField.checkImageView.isHidden = false
      }
    }
    $0.setPlaceholder(placeholder: "최대 숫자 2자리", color: .systemGray3)
    $0.layer.masksToBounds = true
    $0.keyboardType = .numberPad
    $0.delegate = self
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    let stack = self.ageLayout()
    
    self.addSubview(stack)
    
    stack.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func ageLayout() -> UIView {
    return UIStackView().then {
      $0.axis = .vertical
      $0.distribution = .fill
      $0.alignment = .fill
      $0.spacing = 10
      
      $0.addArrangedSubview(self.ageLabel)
      $0.addArrangedSubview(self.ageTextField)
    }
  }
}

extension AgeInputView: UITextFieldDelegate {

  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
  
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else { return true }
    let newText = (text as NSString).replacingCharacters(in: range, with: string)
    return newText.count <= 2
  }
}
