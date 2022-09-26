//
//  ProfileRelationContentView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/20.
//

import BonMot
import ReusableKit
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

protocol ProfileRelationContentViewDelegate: AnyObject {
  func profileRelationContentViewCellItemSelected(_ title: String)
}

public class ProfileRelationContentView: UIView {
  
  weak var delegate: ProfileRelationContentViewDelegate?
  
  enum Reusable {
    static let buttonCell = ReusableCell<RelationButtonCell>()
  }
  
  private let progressView = ProgressView().then {
    $0.firstStepLineView.backgroundColor = .black
    $0.secondStepLineView.backgroundColor = .black
  }
  
  private let titleView = TitleView()
  
  public lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout().then {
      $0.scrollDirection = .vertical
      $0.minimumLineSpacing = 8
      $0.minimumInteritemSpacing = 4
    }
  ).then {
    $0.register(Reusable.buttonCell)
    $0.isScrollEnabled = false
    $0.backgroundColor = .white
    $0.contentInsetAdjustmentBehavior = .never
    $0.allowsMultipleSelection = false
    $0.dataSource = self
    $0.delegate = self
  }
  
  public lazy var textField = UnderLineTextField().then {
    $0.addAction(for: .editingChanged) { textField in
      if textField.text == "" {
        textField.checkImageView.isHidden = true
      } else {
        textField.checkImageView.isHidden = false
      }
    }
    $0.setPlaceholder(placeholder: "반려동물과의 관계를 입력해주세요", color: .systemGray3)
    $0.layer.masksToBounds = true
    $0.autocorrectionType = .no
    $0.isHidden = true
    $0.delegate = self
  }
  
  public let petButton = PETButton(title: "다음")
  
  private var collectionViewContentSizeObserver: NSKeyValueObservation?
  
  func startObserving() {
    self.collectionViewContentSizeObserver = self.collectionView.observe(\.contentSize, changeHandler: { [weak self] collection, _ in
      self?.collectionView.snp.makeConstraints {
        $0.height.equalTo(collection.contentSize.height)
        
        self?.layoutIfNeeded()
      }
    })
  }
  
  private var lastSelectedIndexPath: IndexPath?
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
    self.startObserving()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    self.addSubview(self.progressView)
    self.addSubview(self.titleView)
    self.addSubview(self.collectionView)
    self.addSubview(self.textField)
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
    
    self.collectionView.snp.makeConstraints {
      $0.top.equalTo(self.titleView.snp.bottom)
      $0.left.equalTo(24)
      $0.right.equalTo(-27)
    }
    
    self.textField.snp.makeConstraints {
      $0.top.equalTo(self.collectionView.snp.bottom).offset(24)
      $0.left.equalTo(24)
      $0.right.equalTo(-24)
      $0.height.equalTo(42)
    }
    
    self.petButton.snp.makeConstraints {
      $0.left.equalTo(24)
      $0.right.equalTo(-24)
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-12)
    }
  }
}

extension ProfileRelationContentView: UICollectionViewDataSource {

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return RelationItem.relationItems.count
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(Reusable.buttonCell, for: indexPath)
    
    let target = RelationItem.relationItems[indexPath.item].name
    cell.layer.borderColor = UIColor.black.cgColor
    cell.layer.borderWidth = 1
    cell.layer.cornerRadius = 20
    cell.configure(with: target)
    cell.delegate = self
    
    return cell
  }
}

extension ProfileRelationContentView: UICollectionViewDelegate {
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard lastSelectedIndexPath != indexPath else { return }
    
    if let index = lastSelectedIndexPath {
      let cell = collectionView.cellForItem(at: index) as! RelationButtonCell
      cell.isSelected = false
      self.textField.isHidden = true
      self.textField.text = ""
      self.textField.resignFirstResponder()
    }
    
    let cell = collectionView.cellForItem(at: indexPath) as! RelationButtonCell
    cell.isSelected = true
    if indexPath.item == 7 {
      self.textField.isHidden = false
      self.textField.becomeFirstResponder()
    }
    
    self.lastSelectedIndexPath = indexPath
  }
}

extension ProfileRelationContentView: UITextFieldDelegate {
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
}

extension ProfileRelationContentView: RelationButtonCellDelegate {
  
  func relationButtonCellItemIsSelected(_ title: String) {
    self.delegate?.profileRelationContentViewCellItemSelected(title)
  }
}

extension ProfileRelationContentView: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = ((collectionView.frame.size.width - 24) / 4) 
    
    return .init(width: width, height: 42)
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
