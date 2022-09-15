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

class OnboardingViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = OnboardingViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
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
    self.fetchIntroImageState(reactor: reactor)
    self.collectionViewDelegate(reactor: reactor)
    self.contentOffsetChanged(reactor: reactor)
    self.fetcheNumberOfPage(reactor: reactor)
    self.moveToPosition(reactor: reactor)
    self.bindNext(reactor: reactor)
    self.changeToMovePosition(reactor: reactor)
  }
  
  private func fetchIntroImageState(reactor: Reactor) {
    reactor.state
      .map { $0.sections }
      .distinctUntilChanged()
      .asDriver(onErrorJustReturn: [])
      .drive(self.contentView.collectionView.rx.items(dataSource: self.dataSource))
      .disposed(by: self.disposeBag)
  }
  
  private func collectionViewDelegate(reactor: Reactor) {
    self.contentView.collectionView.rx.setDelegate(self)
      .disposed(by: self.disposeBag)
  }
  
  private func contentOffsetChanged(reactor: Reactor) {
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
  
  private func fetcheNumberOfPage(reactor: Reactor) {
    reactor.state
      .map { $0.pageCount }
      .distinctUntilChanged()
      .bind(onNext: { [weak self] currentPage in
        guard let self = self else { return }
        self.contentView.setConfigurePageControl(count: currentPage)
      })
      .disposed(by: self.disposeBag)
  }
  
  private func moveToPosition(reactor: Reactor) {
    reactor.state
      .map {$0.moveToPosition }
      .distinctUntilChanged()
      .asDriver(onErrorJustReturn: 0)
      .drive(onNext: {[weak self] position in
        guard let self = self else{ return }
        self.contentView.setCurrentPageControl(position: position)
        self.contentView.setSubmitButtonIsHidden(page: position)
      })
      .disposed(by: self.disposeBag)
  }
  
  private func bindNext(reactor: Reactor) {
    self.contentView.submitButton.submitButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { [weak self] _ -> Int in
        guard let self = self else { return 0 }
        return self.visibleCurrentCellIndexPath?.item ?? 0
      }
      .map { .next($0) }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
  }
  
  private func changeToMovePosition(reactor: Reactor) {
    reactor.pulse(\.$changeToPosition)
      .compactMap { $0 }
      .bind(onNext: {[weak self] position in
        guard let self = self else { return }
        self.contentView.positionChanged(position: position)
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
