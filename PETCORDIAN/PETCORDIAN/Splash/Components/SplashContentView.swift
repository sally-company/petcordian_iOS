//
//  SplashContentView.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/13.
//

import BonMot
import SnapKit
import Then
import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct SplashContentView_Preview: PreviewProvider {
  static var previews: some SwiftUI.View {
    Group {
      SplashContentView()
        .showPreview()
    }
  }
}
#endif

public class SplashContentView: UIView {
  
  private let logoLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.attributedText = "LOGO".styled(
      with: StringStyle([
        .font(.boldSystemFont(ofSize: 55)),
        .color(.black)
      ]))
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setup()
  }
  
  private func setup() {
    self.addSubview(self.logoLabel)
    
    self.logoLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}
