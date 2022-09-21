//
//  RelationButtonCell.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/20.
//

import BonMot
import SnapKit
import Then
import UIKit

protocol RelationButtonCellDelegate: AnyObject {
  func RelationButtonCellItemIsSelected(_ title: String)
}

class RelationButtonCell: UICollectionViewCell {
  
  weak var delegate: RelationButtonCellDelegate?
  
  enum Typo {
    static let title = StringStyle([
      .font(.systemFont(ofSize: 16)),
      .color(.black)
    ])
  }
  
  private let titleLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  override var isSelected: Bool {
    didSet {
      self.backgroundColor = isSelected ? .black : .white
      self.titleLabel.textColor = isSelected ? .white : .black
      self.delegate?.RelationButtonCellItemIsSelected(self.titleLabel.text ?? "")
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
        self.setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    private func setup() {
      self.addSubview(self.titleLabel)
      
      self.titleLabel.snp.makeConstraints {
        $0.center.equalToSuperview()
      }
    }
  
  public func configure(with title: String) {
    self.titleLabel.attributedText = title.styled(with: Typo.title)
  }
}
