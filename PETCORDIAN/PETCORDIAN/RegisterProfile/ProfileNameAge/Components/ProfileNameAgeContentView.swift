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
        .previewLayout(.fixed(width: 390, height: 150))
    }
  }
}
#endif

public class ProfileNameAgeContentView: UIView {
  
  private let progressView = ProgressView().then {
    $0.firstStepLineView.backgroundColor = .black
  }
  private let titleView = TitleView()
  public let nameAgeInputView = InputView()
  public let petButton = PETButton(title: "다음")
  
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
    self.addSubview(self.titleView)
    self.addSubview(self.nameAgeInputView)
    self.addSubview(self.petButton)
    
    self.progressView.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide).offset(9)
      $0.left.equalTo(24)
      $0.right.equalTo(-24)
    }
    
    self.titleView.snp.makeConstraints {
      $0.top.equalTo(self.progressView.snp.bottom).offset(18)
      $0.left.right.equalToSuperview()
    }
    
    self.nameAgeInputView.snp.makeConstraints {
      $0.top.equalTo(self.titleView.snp.bottom)
      $0.left.equalTo(24)
      $0.right.equalTo(-24)
    }
    
    self.petButton.snp.makeConstraints {
      $0.left.equalTo(24)
      $0.right.equalTo(-24)
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-12)
    }
  }
}

extension ProfileNameAgeContentView {
  
  public class TitleView: UIView {
    
    private let progressLabel = UILabel().then {
      $0.numberOfLines = 1
      $0.attributedText = "1 / 3".styled(
        with: StringStyle([
          .font(.systemFont(ofSize: 18)),
          .color(.black)
        ]))
    }
    
    private let titleLabel = UILabel().then {
      $0.numberOfLines = 2
      $0.attributedText = "생명체의 정보가\n필요하다몽!".styled(
        with: StringStyle([
          .font(.systemFont(ofSize: 24)),
          .color(.black)
        ]))
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
      self.snp.makeConstraints {
        $0.height.equalTo(105)
      }
      
      self.addSubview(self.progressLabel)
      self.addSubview(self.titleLabel)
      
      self.progressLabel.snp.makeConstraints {
        $0.left.equalTo(24)
        $0.top.equalToSuperview()
      }
      
      self.titleLabel.snp.makeConstraints {
        $0.left.equalTo(self.progressLabel.snp.left)
        $0.top.equalTo(self.progressLabel.snp.bottom).offset(10)
      }
    }
  }
}

public class ProgressView: UIView {
  
  public let firstStepLineView = UIView()
  public let secondStepLineView = UIView()
  public let thirdStepLineView = UIView()
  
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
