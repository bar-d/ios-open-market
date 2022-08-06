//
//  ListCollectionView.swift
//  OpenMarket
//
//  Created by groot, bard on 2022/07/19.
//

import UIKit

final class ListCollectionView: UICollectionView {
    // MARK: - properties
    
    private var listViewDataSource: UICollectionViewDiffableDataSource<Section, ProductDetail>? = nil
    private let listViewCellRegistration = UICollectionView.CellRegistration<ListCollectionViewCell, ProductDetail> {
        (cell, indexPath, product) in
        cell.setViewItems(product)
    }
    
    // MARK: - initializers
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - functions
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        setupDataSource()
    }
    
    private func setupDataSource() {
        listViewDataSource = UICollectionViewDiffableDataSource<Section, ProductDetail>(collectionView: self) { [weak self]
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             identifier: ProductDetail) -> UICollectionViewCell? in
            
            guard let listViewCellRegistration = self?.listViewCellRegistration
            else { return UICollectionViewCell() }
            
            return collectionView.dequeueConfiguredReusableCell(using: listViewCellRegistration,
                                                                for: indexPath,
                                                                item: identifier)
        }
    }
    
    func setSnapshot(productsList: [ProductDetail]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ProductDetail>()
        snapshot.appendSections([.list])
        snapshot.appendItems(productsList)
        
        listViewDataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func deleteSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ProductDetail>()
        snapshot.deleteAllItems()
        
        listViewDataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - image size
    
    private enum ImageSize {
        static let width = 70
        static let height = 70
    }
}
