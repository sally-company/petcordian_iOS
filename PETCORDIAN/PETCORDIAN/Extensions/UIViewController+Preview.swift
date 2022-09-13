//
//  UIViewController+Preview.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/08.
//

#if canImport(SwiftUI) && DEBUG
import UIKit
import SwiftUI
extension UIViewController {
  @available(iOS 13, *)
  private struct Preview: UIViewControllerRepresentable {
    let viewController: UIViewController
    func makeUIViewController(context: Context) -> UIViewController {
      return viewController
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
  }
  @available(iOS 13, *)
  func showPreview() -> some View {
    Preview(viewController: self)
  }
}
#endif
