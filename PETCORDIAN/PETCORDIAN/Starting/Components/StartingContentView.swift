//
//  StartingContentView.swift
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
      StartingContentView.SocialLoginButtonView(title: "카카오")
        .showPreview()
        .previewLayout(.fixed(width: 390, height: 56))
    }
  }
}
#endif

public class StartingContentView: UIView {
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
  }
}

extension StartingContentView {
  
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
