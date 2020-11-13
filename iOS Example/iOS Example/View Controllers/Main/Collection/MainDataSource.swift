//
//  MainDataSource.swift
//  iOS Example
//
//  Created by Greg Pape on 11/8/20.
//

import RxCocoa
import RxSwift
import UIKit

final class MainDataSource: NSObject {

    private let bag = DisposeBag()
    private var diffable: Diffable!
    fileprivate let selection = PublishRelay<MainViewModel.Demo>()

    init(_ collectionView: UICollectionView, vm: MainViewModel) {
        super.init()
        configure(collectionView)
        configureRx(for: vm)
    }

}

// MARK: - Collection

private extension MainDataSource {

    typealias Item = MainViewModel.Demo

    typealias Diffable = UICollectionViewDiffableDataSource<Section, Item>

    enum Section: Hashable { case all }

    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    func configure(_ view: UICollectionView) {

        view.delegate = self
        view.register(.init(nibName: "MainDemoCell", bundle: nil), forCellWithReuseIdentifier: "MainDemoCell")

        diffable = .init(collectionView: view) { [weak self] view, indexPath, item in
            self?.dequeueCell(for: item, at: indexPath, in: view)
        }

    }

    func dequeueCell(for item: Item, at indexPath: IndexPath, in view: UICollectionView) -> UICollectionViewCell? {
        let cell = view.dequeueReusableCell(withReuseIdentifier: "MainDemoCell", for: indexPath) as! MainDemoCell
        cell.demo = item
        return cell
    }

    func update(with items: [Item]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.all])
        snapshot.appendItems(items, toSection: .all)
        diffable.apply(snapshot, animatingDifferences: true)
    }

}

// MARK: - Rx

extension Reactive where Base: MainDataSource {

    var selection: Signal<MainViewModel.Demo> {
        base.selection.asSignal()
    }

}

private extension MainDataSource {

    func configureRx(for vm: MainViewModel) {

        vm.$demos
            .drive { [weak self] demos in
                self?.update(with: demos)
            }
            .disposed(by: bag)

    }

}

// MARK: - <UICollectionViewDelegate>

extension MainDataSource: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = diffable.itemIdentifier(for: indexPath) else {
            preconditionFailure()
        }
        selection.accept(item)
    }

}
