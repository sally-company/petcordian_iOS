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
  
  public let progressView = ProgressView().then {
    $0.firstStepLineView.backgroundColor = .black
    $0.secondStepLineView.backgroundColor = .black
    $0.thirdStepLineView.backgroundColor = .black
  }
  
  public let titleView = TitleView()
  public let photoImageView = PhotoImageView()
  public var petButton = PETButton(title: "확인")
  public let beginTitleView = BeginTitleView().then {
    $0.alpha = 0.0
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
    self.addSubview(self.progressView)
    self.addSubview(self.titleView)
    self.addSubview(self.photoImageView)
    self.addSubview(self.petButton)
    self.addSubview(self.beginTitleView)
    
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
    
    self.beginTitleView.snp.makeConstraints {
      $0.left.right.top.equalToSuperview()
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
    
    public let defaultProfileImageView = UIImageView().then {
      $0.backgroundColor = .systemGray3
      $0.contentMode = .scaleAspectFill
    }
    
    public var selectedProfileImageView = UIImageView().then {
      $0.contentMode = .scaleAspectFill
    }
    
    public lazy var photoButton = UIButton().then {
      $0.backgroundColor = .clear
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
      self.layer.cornerRadius = 157 / 2
      self.layer.masksToBounds = true
      
      self.addSubview(self.defaultProfileImageView)
      self.addSubview(self.selectedProfileImageView)
      self.addSubview(self.photoButton)
      
      self.defaultProfileImageView.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
      
      self.selectedProfileImageView.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
      
      self.photoButton.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
}

extension ProfileImageContentView {
  
  public class BeginTitleView: UIView {
    
    enum Typo {
      static let title = StringStyle([
        .font(.systemFont(ofSize: 24)),
        .color(.black)
      ])
    }
    
    private let titleLabel = UILabel().then {
      $0.numberOfLines = 2
      $0.attributedText = "펫코디언에 $$가 등록되었다몽!\n어떤 말을 하는지 들으러 오라몽-.".styled(
        with: StringStyle([
          .font(.systemFont(ofSize: 24)),
          .color(.black)
        ]))
    }
    
    public var title: String {
      set {
        self.titleLabel.attributedText = newValue.styled(with: Typo.title)
        self.layoutIfNeeded()
      }
      get {
        self.titleLabel.text ?? ""
      }
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
      
      self.addSubview(self.titleLabel)
      
      self.titleLabel.snp.makeConstraints {
        $0.top.equalTo(174)
        $0.left.equalTo(24)
      }
    }
  }
}
