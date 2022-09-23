//
//  ProfileImageViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/21.
//

import CropViewController
import ReactorKit
import RxCocoa
import RxSwift
import UIKit

class ProfileImageViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = ProfileImageViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  var imagePicker: UIImagePickerController?
  
  private var croppedRect: CGRect = .zero
  private var croppedAngle = 0
  
  // MARK: UI
  
  private let contentView = ProfileImageContentView()
  
  deinit {
    print("\(self)")
  }
  
  // MARK: View Life Cycle
  
  override func loadView() {
    self.view = self.contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
  }
  
  // MARK: Layout
  
  private func setup() {
    self.view.backgroundColor = .white
  }
  
  func bind(reactor: Reactor) {
    self.bindPhotoSelectButton()
    self.bindImage(reactor: reactor)
  }
  
  private func bindPhotoSelectButton() {
    self.contentView.photoImageView.photoButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(onNext: { [weak self] in
        self?.presentProfileImagePicker()
      })
      .disposed(by: self.disposeBag)
  }
  
  private func bindImage(reactor: Reactor) {
    reactor.state
      .map { $0.profileImage }
      .bind(onNext: { [weak self] profileImage in
        guard let self = self else { return }
        self.contentView.photoImageView.selectedProfileImageView.image = profileImage
      })
      .disposed(by: self.disposeBag)
  }
}

extension ProfileImageViewController {
  
  private func presentProfileImagePicker() {
    let picker = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.allowsEditing = false
    picker.delegate = self
    
    self.imagePicker = picker
    self.present(picker, animated: true, completion: nil)
  }
}

extension ProfileImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
    
    let croppingStyle = CropViewCroppingStyle.circular
    let cropController = CropViewController(croppingStyle: croppingStyle, image: image)
    cropController.delegate = self
    
    if croppingStyle == .circular {
      picker.pushViewController(cropController, animated: true)
    } else {
      self.dismiss(animated: true) {
        self.present(cropController, animated: true, completion: nil)
      }
    }
  }
  
  public func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
    self.reactor?.action.onNext(.changeProfileImage(image))
    
    cropViewController.dismiss(animated: true, completion: nil)
  }
}

extension ProfileImageViewController: CropViewControllerDelegate {
  
  func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
    self.croppedRect = cropRect
    self.croppedAngle = angle
    self.updateImageViewWithImage(image, fromCropViewController: cropViewController)
  }
}
