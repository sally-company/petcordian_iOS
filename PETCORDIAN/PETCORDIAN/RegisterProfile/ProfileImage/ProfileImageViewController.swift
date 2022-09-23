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
import SnapKit
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
    self.addCancelButton()
  }
  
  private func addCancelButton() {
    let cancelButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelAction))
    cancelButton.tintColor = .black
    self.navigationItem.rightBarButtonItem = cancelButton
  }
  
  @objc private func cancelAction() {
    self.dismiss(animated: true)
  }
  
  func bind(reactor: Reactor) {
    self.bindPhotoSelectButton()
    self.bindImage(reactor: reactor)
    self.bindConfirmButton()
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
  
  private func bindConfirmButton() {
    self.contentView.petButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(onNext: { [weak self] in
        guard let self = self else { return }
        UIView.animate(withDuration: 1.0, delay: 0) {
          self.contentView.progressView.alpha = 0.0
          self.contentView.titleView.alpha = 0.0
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 1.0) {
              self.contentView.beginTitleView.alpha = 1.0
            }
            
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut) {
              self.contentView.photoImageView.snp.updateConstraints {
                $0.top.equalTo(self.contentView.titleView.snp.bottom).offset(80)
              }
              self.contentView.photoImageView.superview?.layoutIfNeeded()
            }
          }
        }
        // TODO: 버튼 타이틀 변경
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