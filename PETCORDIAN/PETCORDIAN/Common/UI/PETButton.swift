//
//  PETButton.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/19.
//

import BonMot
import UIKit

public class PETButton: UIButton {
  
  public enum Typo {
    static let normal = StringStyle([
      .font(.systemFont(ofSize: 20)),
      .color(.white)
    ])
    
    static let disabled = StringStyle([
      .font(.systemFont(ofSize: 20)),
      .color(.white)
    ])
  }
  
  public override var isEnabled: Bool {
    didSet {
      let title = self.titleLabel?.text ?? ""
      self.setAttributedTitle(
        isEnabled ? title.styled(with: Typo.normal) : title.styled(with: Typo.disabled),
        for: .normal)
      
      self.backgroundColor = isEnabled ? .black : .systemGray3
    }
  }
  
  public override var intrinsicContentSize: CGSize {
    return .init(width: UIView.noIntrinsicMetric, height: 56)
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  init(title: String) {
    defer { self.isEnabled = true }
    
    super.init(frame: .zero)
    
    setup(title: title)
  }
  
  private func setup(title: String) {
    self.setTitle(title, for: .normal)
    self.setTitleColor(.white, for: .normal)
    self.layer.cornerRadius = 9
  }
}
