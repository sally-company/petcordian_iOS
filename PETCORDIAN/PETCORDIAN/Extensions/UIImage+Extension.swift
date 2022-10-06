//
//  UIImage+Extension.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/06.
//

import UIKit

extension UIImage {
  func resized(to size: CGSize) -> UIImage {
    return UIGraphicsImageRenderer(size: size).image { _ in
      draw(in: CGRect(origin: .zero, size: size))
    }
  }
}
