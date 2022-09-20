//
//  ProfileRelationContentView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/20.
//

import BonMot
import SnapKit
import Then
import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct ProfileRelationContentView_Preview: PreviewProvider {
  static var previews: some SwiftUI.View {
    Group {
      ProfileRelationContentView()
        .showPreview()
    }
  }
}
#endif

public class ProfileRelationContentView: UIView {
  
  private let progressView = ProgressView().then {
    $0.firstStepLineView.backgroundColor = .black
    $0.secondStepLineView.backgroundColor = .black
  }
  private let titleView = TitleView()
  
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
    
    self.progressView.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide).offset(9)
      $0.left.equalTo(24)
      $0.right.equalTo(-24)
    }
    
    self.titleView.snp.makeConstraints {
      $0.top.equalTo(self.progressView.snp.bottom).offset(18)
      $0.left.right.equalToSuperview()
    }
  }
}

extension ProfileRelationContentView {
  
  public class TitleView: UIView {
    
    private let progressLabel = UILabel().then {
      $0.numberOfLines = 1
      $0.attributedText = "2 / 3".styled(
        with: StringStyle([
          .font(.systemFont(ofSize: 18)),
          .color(.black)
        ]))
    }
    
    private let titleLabel = UILabel().then {
      $0.numberOfLines = 2
      $0.attributedText = "지구인과 생명체의\n관계를 알려달라몽!".styled(
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
