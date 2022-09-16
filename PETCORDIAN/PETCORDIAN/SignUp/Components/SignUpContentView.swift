//
//  SignUpContentView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/15.
//

import BonMot
import SnapKit
import Then
import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct StartingContentView_Preview: PreviewProvider {
  static var previews: some SwiftUI.View {
    Group {
      SignUpContentView()
        .showPreview()
    }
  }
}
#endif

public class SignUpContentView: UIView { // SignUp
  
  private let topView = TopView()
  private let characterView = CharacterView()
  private let actionView = ActionView()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    self.addSubview(self.topView)
    self.addSubview(self.characterView)
    self.addSubview(self.actionView)
    
    self.topView.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(UIScreen.main.bounds.height * (167 / 812))
      $0.left.right.equalToSuperview()
    }
    
    self.characterView.snp.makeConstraints {
      $0.top.equalTo(self.topView.snp.bottom)
      $0.left.right.equalToSuperview()
    }
    
    self.actionView.snp.makeConstraints {
      $0.top.equalTo(self.characterView.snp.bottom)
      $0.left.right.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
}

extension SignUpContentView {
  
  public class TopView: UIView {
    
    private let logoLabel = UILabel().then {
      $0.numberOfLines = 1
      $0.attributedText = "LOGO".styled(
        with: StringStyle([
          .font(.boldSystemFont(ofSize: 55)),
          .color(.black)
        ]))
    }
    
    private let descriptionLabel = UILabel().then {
      $0.numberOfLines = 2
      $0.attributedText = "나의 작은 반려동물의 일기장을\n넘겨볼 수 있는 시간".styled(
        with: StringStyle([
          .font(UIFont(name: Font.Kyobo_Handwriting_2019.rawValue, size: 21) ?? .systemFont(ofSize: 21)),
          .color(.black),
          .alignment(.center)
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
        $0.height.equalTo(138)
      }
      
      self.addSubview(self.logoLabel)
      self.addSubview(self.descriptionLabel)
      
      self.logoLabel.snp.makeConstraints {
        $0.top.equalToSuperview()
        $0.centerX.equalToSuperview()
      }
      
      self.descriptionLabel.snp.makeConstraints {
        $0.top.equalTo(self.logoLabel.snp.bottom).offset(24)
        $0.centerX.equalToSuperview()
      }
    }
  }
}

extension SignUpContentView {
  
  public class CharacterView: UIView {
    
    private let characterImageView = UIImageView().then {
      $0.image = UIImage(named: "starting_Character")
      $0.contentMode = .scaleAspectFill
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
      self.addSubview(self.characterImageView)
      
      self.characterImageView.snp.makeConstraints {
        $0.left.equalTo(95)
        $0.right.equalTo(-95)
        $0.top.equalTo(12)
        $0.height.equalTo(self.characterImageView.snp.width)
      }
    }
  }
}

extension SignUpContentView {
  
  public class ActionView: UIView {
    
    private let kakaoLoginButtonView = SocialLoginButtonView(title: "카카오")
    private let googleLoginButtonView = SocialLoginButtonView(title: "구글")
    private let naverLoginButtonView = SocialLoginButtonView(title: "네이버")
    
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
        $0.height.equalTo(self.snp.width).multipliedBy(305.0/375.0)
      }
      
      let stack = self.layout()
      
      self.addSubview(stack)
      
      stack.snp.makeConstraints {
        $0.left.equalTo(40)
        $0.right.equalTo(-35)
        if UIScreen.main.bounds.size.height < 700 {
          $0.bottom.equalTo(-5)
        } else {
          $0.top.equalTo(28)
        }
      }
    }
    
    private func layout() -> UIView {
      return UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 16
        
        $0.addArrangedSubview(self.kakaoLoginButtonView)
        $0.addArrangedSubview(self.googleLoginButtonView)
        $0.addArrangedSubview(self.naverLoginButtonView)
      }
    }
  }
}

extension SignUpContentView {
  
  public class SocialLoginButtonView: UIView {
    
    enum Typo {
      static let social = StringStyle([
        .font(.boldSystemFont(ofSize: 16)),
        .color(.black)
      ])
    }
    
    private let socialLabel = UILabel().then {
      $0.numberOfLines = 1
    }
    
    private let continueLabel = UILabel().then {
      $0.numberOfLines = 1
      $0.attributedText = "로 계속하기".styled(
        with: StringStyle([
          .font(.systemFont(ofSize: 16)),
          .color(.black)
        ]))
    }
    
    private let button = UIButton()
    
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
      super.init(frame: .zero)
      
      self.setup(title: title)
    }
    
    private func setup(title: String) {
      self.do {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 9
      }
      
      let stack = self.layout()
      
      self.addSubview(stack)
      self.addSubview(self.button)
      
      stack.snp.makeConstraints {
        $0.center.equalToSuperview()
      }
      
      self.button.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
      
      self.socialLabel.attributedText = title.styled(with: Typo.social)
    }
    
    private func layout() -> UIView {
      return UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 0
        
        $0.addArrangedSubview(self.socialLabel)
        $0.addArrangedSubview(self.continueLabel)
      }
    }
  }
}
