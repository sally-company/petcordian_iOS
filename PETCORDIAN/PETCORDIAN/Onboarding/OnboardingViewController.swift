//
//  OnboardingViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/15.
//

import ReactorKit
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
  func onboardingViewControllerStartingButtonTapped()
}

class OnboardingViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = OnboardingViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  weak var delegate: OnboardingViewControllerDelegate?
  
  private lazy var dataSource = self.createDataSource()
  
  var visibleCurrentCellIndexPath: IndexPath? {
    for cell in self.contentView.collectionView.visibleCells {
      let indexPath = self.contentView.collectionView.indexPath(for: cell)
      return indexPath
    }
    return nil
  }
  
  // MARK: UI
  private let contentView = OnboardingContentView()
  
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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = true
  }
  
  // MARK: Layout
  private func setup() {
    self.view.backgroundColor = .white
  }
  
  // MARK: Bind
  func bind(reactor: Reactor) {
    self.setCollectionViewDelegate()
    self.bindOnboardingImageState(reactor: reactor)
    self.bindContentOffsetChanged(reactor: reactor)
    self.bindPageCount(reactor: reactor)
    self.bindMoveToPosition(reactor: reactor)
    self.bindChangeToPosition(reactor: reactor)
    self.bindStartingButtonTapped()
  }
  
  private func setCollectionViewDelegate() {
    self.contentView.collectionView.rx.setDelegate(self)
      .disposed(by: self.disposeBag)
  }
  
  private func bindOnboardingImageState(reactor: Reactor) {
    reactor.state
      .map { $0.sections }
      .distinctUntilChanged()
      .asDriver(onErrorJustReturn: [])
      .drive(self.contentView.collectionView.rx.items(dataSource: self.dataSource))
      .disposed(by: self.disposeBag)
  }
  
  private func bindContentOffsetChanged(reactor: Reactor) {
    self.contentView.collectionView.rx.contentOffset
      .distinctUntilChanged()
      .filter { $0.x > 0 }
      .flatMapLatest { [weak self] offset -> Observable<Int> in
        guard let self = self else { return .empty() }
        return Observable.just(Int(offset.x / self.contentView.collectionView.frame.width))
      }
      .map { .moveToPosition($0) }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
  }
  
  private func bindPageCount(reactor: Reactor) {
    reactor.state
      .map { $0.pageCount }
      .distinctUntilChanged()
      .bind(onNext: { [weak self] currentPage in
        guard let self = self else { return }
        self.contentView.setConfigurePageControl(count: currentPage)
      })
      .disposed(by: self.disposeBag)
  }
  
  private func bindMoveToPosition(reactor: Reactor) {
    reactor.state
      .map {$0.moveToPosition }
      .distinctUntilChanged()
      .asDriver(onErrorJustReturn: 0)
      .drive(onNext: { [weak self] position in
        guard let self = self else{ return }
        self.contentView.setCurrentPageControl(position: position)
        self.contentView.setSubmitButtonIsHidden(page: position)
      })
      .disposed(by: self.disposeBag)
  }
  
  private func bindChangeToPosition(reactor: Reactor) {
    reactor.pulse(\.$changeToPosition)
      .compactMap { $0 }
      .bind(onNext: { [weak self] position in
        guard let self = self else { return }
        self.contentView.positionChanged(position: position)
      })
      .disposed(by: self.disposeBag)
  }
  
  private func bindStartingButtonTapped() {
    self.contentView.submitButton.submitButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.delegate?.onboardingViewControllerStartingButtonTapped()
      })
      .disposed(by: self.disposeBag)
  }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.frame.size
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 0, left: 0, bottom: 0, right: 0)
  }
}

extension OnboardingViewController {
  private func createDataSource() -> RxCollectionViewSectionedReloadDataSource<OnboardingSection> {
    return .init { _, collectionView, indexPath, sectionItem in
      switch sectionItem {
      case let .image(cellReactor):
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "items", for: indexPath) as? OnboardingImageCollectionViewCell else {
          return UICollectionViewCell()
        }
        cell.reactor = cellReactor
        return cell
      }
    }
  }
}
