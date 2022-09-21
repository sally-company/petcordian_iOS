//
//  ProfileImageContentView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/21.
//

import BonMot
import SnapKit
import Then
import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct ProfileImageContentView_Preview: PreviewProvider {
  static var previews: some SwiftUI.View {
    Group {
      ProfileImageContentView()
        .showPreview()
    }
  }
}
#endif

public class ProfileImageContentView: UIView {
  
  private let progressView = ProgressView().then {
    $0.firstStepLineView.backgroundColor = .black
    $0.secondStepLineView.backgroundColor = .black
    $0.thirdStepLineView.backgroundColor = .black
  }
  
  private let titleView = TitleView()
  private let photoImageView = PhotoImageView()
  private let petButton = PETButton(title: "확인")
  
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
    self.addSubview(self.photoImageView)
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
    
    self.photoImageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(self.titleView.snp.bottom).offset(64)
      $0.size.equalTo(157)
    }
    
    self.petButton.snp.makeConstraints {
      $0.left.equalTo(24)
      $0.right.equalTo(-24)
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-12)
    }
  }
}

extension ProfileImageContentView {
  
  public class TitleView: UIView {
    
    private let progressLabel = UILabel().then {
      $0.numberOfLines = 1
      $0.attributedText = "3 / 3".styled(
        with: StringStyle([
          .font(.systemFont(ofSize: 18)),
          .color(.black)
        ]))
    }
    
    private let titleLabel = UILabel().then {
      $0.numberOfLines = 2
      $0.attributedText = "귀염뽀짝한 생명체의\n사진을 등록해달라몽!".styled(
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

extension ProfileImageContentView {
  
  public class PhotoImageView: UIView {
    
    private lazy var photoButton = UIButton().then {
      $0.backgroundColor = .systemGray3
      $0.layer.cornerRadius = 157 / 2
      $0.layer.masksToBounds = true
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
      self.addSubview(self.photoButton)
      
      self.photoButton.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
}
