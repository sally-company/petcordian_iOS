//
//  OnboardingImageCollectionViewCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/14.
//

import BonMot
import ReactorKit
import SnapKit
import Then
import UIKit

final class OnboardingImageCollectionViewCell: UICollectionViewCell, ReactorKit.View {
  
  var disposeBag: DisposeBag = .init()
  
  typealias Reactor = OnboardingCellReactor
  
  public enum Typo {
    static let mainTitle = StringStyle([
      .font(.boldSystemFont(ofSize: 26)),
      .color(.black),
      .alignment(.center)
    ])
    
    static let description = StringStyle([
      .font(.systemFont(ofSize: 16)),
      .color(.black),
      .alignment(.center)
    ])
  }
  
  private let onboardingImageView = UIImageView().then {
    $0.layer.cornerRadius = 34
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
  }
  
  private let maintTitleLabel = UILabel().then {
    $0.numberOfLines = 0
  }
  
  private let descriptionLabel = UILabel().then {
    $0.numberOfLines = 0
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    self.contentView.backgroundColor = .white
    
    [self.onboardingImageView, self.maintTitleLabel, self.descriptionLabel].forEach {
      self.contentView.addSubview($0)
    }
  }
  
  func bind(reactor: Reactor) {
    reactor.state
      .map { $0.item }
      .distinctUntilChanged()
      .asDriver(onErrorJustReturn: .init())
      .do(onNext: { [weak self] items in
        guard let self = self else { return }
        self.onboardingImageView.image = items.screenshot
        self.maintTitleLabel.attributedText = items.mainTitle.styled(with: Typo.mainTitle)
        self.descriptionLabel.attributedText = items.description.styled(with: Typo.description)
      })
        .drive(onNext: { [weak self] items in
          guard let self = self else { return }
          self.setLayout()
        })
        .disposed(by: self.disposeBag)
        
  }
  
  private func setLayout() {
    self.maintTitleLabel.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(100)
      $0.centerX.equalToSuperview()
    }
    
    self.descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(self.maintTitleLabel.snp.bottom).offset(13)
      $0.centerX.equalToSuperview()
    }
    
    self.onboardingImageView.snp.makeConstraints {
      $0.top.equalTo(self.descriptionLabel.snp.bottom).offset(40)
      $0.left.equalTo(24)
      $0.right.equalTo(-24)
      $0.height.equalTo(self.onboardingImageView.snp.width)
    }
  }
}
