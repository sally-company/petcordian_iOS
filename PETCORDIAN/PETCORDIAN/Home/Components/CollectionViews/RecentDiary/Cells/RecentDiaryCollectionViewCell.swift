//
//  RecentDiaryCollectionViewCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import BonMot
import SnapKit
import Then
import UIKit

class RecentDiaryCollectionViewCell: UICollectionViewCell {
  
  enum Typo {
    static let date = StringStyle([
      .font(.systemFont(ofSize: 14)),
      .color(.white)
    ])
  }
  
  private let petImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
  }
  
  private let emojiImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    var image = UIImage(named: "sampleEmoji")
    image = image?.withTintColor(.white)
    $0.image = image
  }
  
  private let dateLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  private var date: String {
    set {
      self.dateLabel.attributedText = newValue.styled(with: Typo.date)
      self.layoutIfNeeded()
    }
    get {
      self.dateLabel.text ?? ""
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func setup() {
    self.clipsToBounds = true
    self.layer.cornerRadius = 8
    
    self.addSubview(self.petImageView)
    self.addSubview(self.dateLabel)
    self.addSubview(self.emojiImageView)
    
    self.petImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    self.dateLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(-7)
    }
    
    self.emojiImageView.snp.makeConstraints {
      $0.size.equalTo(34)
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(self.dateLabel.snp.top).offset(-5)
    }
  }
  
  private func layout() -> UIView {
    return UIStackView().then {
      $0.axis = .vertical
      $0.distribution = .fill
      $0.alignment = .fill
      $0.spacing = 5
      
      self.emojiImageView.snp.makeConstraints {
        $0.size.equalTo(34)
      }
      
      $0.addArrangedSubview(self.emojiImageView)
      $0.addArrangedSubview(self.dateLabel)
    }
  }
  
  public func configure(index: Int) {
    self.petImageView.image = sampleDiaryList[index].image
    self.date = sampleDiaryList[index].date.recentDiaryDate
  }
}

