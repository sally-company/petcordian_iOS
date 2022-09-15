//
//  OnboardingContentView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/14.
//

import BonMot
import ReusableKit
import SnapKit
import Then
import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct OnboardingContentView_Preview: PreviewProvider {
  static var previews: some SwiftUI.View {
    Group {
      OnboardingContentView()
        .showPreview()
    }
  }
}
#endif

public class OnboardingContentView: UIView {
  
  private let layout = UICollectionViewFlowLayout().then {
    $0.scrollDirection = .horizontal
  }
  
  public lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
    $0.backgroundColor = .white
    $0.isPagingEnabled = true
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.contentInsetAdjustmentBehavior = .never
    $0.register(OnboardingImageCollectionViewCell.self, forCellWithReuseIdentifier: "items")
  }
  
  public let pageControl = UIPageControl().then {
    $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    
    $0.pageIndicatorTintColor = .gray
    $0.currentPageIndicatorTintColor = .black
  }
  
  public let submitButton = SubmitButton()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    self.backgroundColor = .white
    
    [self.collectionView, self.pageControl, self.submitButton].forEach {
      self.addSubview($0)
    }
    
    self.collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    self.pageControl.snp.makeConstraints {
      $0.bottom.equalTo(-(UIScreen.main.bounds.height * (159.0 / 812.0)))
      $0.centerX.equalToSuperview()
    }
    
    self.submitButton.snp.makeConstraints {
      $0.bottom.equalTo(self.safeAreaLayoutGuide)
      $0.left.equalToSuperview().offset(24)
      $0.right.equalToSuperview().offset(-24)
    }
  }
  
  public func positionChanged(position: Int) {
    self.pageControl.currentPage = position
    self.collectionView.scrollToItem(at: IndexPath(item: position, section: 0),
                                     at: .centeredHorizontally,
                                     animated: true)
  }
  
  public func setSubmitButtonIsHidden(page: Int) {
    let isHidden: Bool = page == 1 ? false : true
    self.submitButton.submitButton.isHidden = isHidden
  }
  
  public func setConfigurePageControl(count: Int) {
    self.pageControl.numberOfPages = count
  }
  
  public func setCurrentPageControl(position: Int) {
    self.pageControl.currentPage = position
  }
}

extension OnboardingContentView {
  
  public class SubmitButton: UIControl {
    
    let submitButton = UIButton().then {
      $0.setTitle("시작하기", for: .normal)
      $0.titleLabel?.font = .systemFont(ofSize: 18)
      $0.setTitleColor(.white, for: .normal)
      $0.layer.cornerRadius = 6
      $0.backgroundColor = .black
      $0.layer.borderWidth = 9
    }
    
    public override init(frame: CGRect) {
      super.init(frame: frame)
      self.setup()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize: CGSize {
      return CGSize(width: UIView.noIntrinsicMetric, height: 56)
    }
    
    private func setup() {
      self.addSubview(self.submitButton)
      self.submitButton.snp.makeConstraints {
        $0.bottom.equalTo(-6)
        $0.left.right.equalToSuperview()
        $0.height.equalTo(56)
      }
    }
  }
}

