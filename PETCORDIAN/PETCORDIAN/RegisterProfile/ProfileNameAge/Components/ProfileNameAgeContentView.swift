//
//  ProfileNameAgeContentView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/16.
//

import BonMot
import SnapKit
import Then
import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct ProfileNameAgeContentView_Preview: PreviewProvider {
  static var previews: some SwiftUI.View {
    Group {
      ProfileNameAgeContentView()
        .showPreview()
        .previewLayout(.fixed(width: 390, height: 20))
    }
  }
}
#endif

public class ProfileNameAgeContentView: UIView {
  
  private let progressView = ProgressView()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    self.addSubview(self.progressView)
    
    self.progressView.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide).offset(50)
      $0.left.equalTo(24)
      $0.right.equalTo(-24)
    }
  }
}

public class ProgressView: UIView {
  
  private let firstStepLineView = UIView()
  private let secondStepLineView = UIView()
  private let thirdStepLineView = UIView()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    self.snp.makeConstraints {
      $0.height.equalTo(1)
    }
    
    let stack = self.layout()

    self.addSubview(stack)
    
    stack.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func layout() -> UIView {
    return UIStackView().then {
      $0.axis = .horizontal
      $0.distribution = .fillEqually
      $0.alignment = .fill
      $0.spacing = 7
      
      [self.firstStepLineView, self.secondStepLineView, self.thirdStepLineView].forEach {
        $0.backgroundColor = .systemGray3
        $0.snp.makeConstraints {
          $0.height.equalTo(1)
        }
      }
      
      $0.addArrangedSubview(self.firstStepLineView)
      $0.addArrangedSubview(self.secondStepLineView)
      $0.addArrangedSubview(self.thirdStepLineView)
    }
  }
}
