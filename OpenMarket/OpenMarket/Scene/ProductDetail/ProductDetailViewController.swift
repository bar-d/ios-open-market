//
//  ProductDetailViewController.swift
//  OpenMarket
//
//  Created by groot, bard on 2022/08/09.
//

import UIKit

final class ProductDetailViewController: UIViewController {
    // MARK: - properties
    
    private var productID: String?
    private var images = [UIImage]()
    private lazy var productImageCollectionView = UICollectionView(frame: .zero,
                                                                   collectionViewLayout: setupLayout())
    private let productDetailView = ProductDetailView()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis  = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationController()
        fetchData()
        setupProductImageCollectionView()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - functions
    
    private func fetchData() {
        guard let productID = productID else { return }
        
        let request = ProductGetRequest(headers: nil,
                                        query: nil,
                                        body: nil,
                                        productID: "/" + productID)
        
        let session = MyURLSession()
        session.dataTask(with: request) { (result: Result<Data, Error>) in
            switch result {
            case .success(let success):
                guard let decodedData = success.decodeData(type: ProductDetail.self) else { return }
                
                decodedData.images.forEach
                {
                    OpenMarketImageManager.setupImage(key: $0.thumbnail) { image in
                        self.images.append(image)
                        DispatchQueue.main.async {
                            self.productImageCollectionView.reloadData()
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.navigationItem.title = decodedData.name
                    self.productDetailView.setupViewItems(decodedData)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    private func setupNavigationController() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self,
                                             action: #selector(rightBarButtonDidTap))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    
    private func setupSubviews() {
        view.addSubview(totalStackView)
        [productImageCollectionView, productDetailView].forEach
        {
            totalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                totalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                totalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: 10),
                totalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                         constant: -10),
                totalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    private func setupLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width - 16,
                                 height: view.safeAreaLayoutGuide.layoutFrame.height/2)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    private func setupProductImageCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width,
                                 height: view.safeAreaLayoutGuide.layoutFrame.height/2.5)
        layout.scrollDirection = .horizontal
        
        productImageCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: layout)
        
        productImageCollectionView.register(ProductImageCell.self,
                                             forCellWithReuseIdentifier: ProductImageCell.identifier)
        
        productImageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        productImageCollectionView.showsHorizontalScrollIndicator = false
        productImageCollectionView.isPagingEnabled = false
        productImageCollectionView.decelerationRate = .fast
        productImageCollectionView.dataSource = self
        productImageCollectionView.delegate = self
    }
    
    @objc private func rightBarButtonDidTap() {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        let updateAlertAction = UIAlertAction(title: "수정",
                                              style: .default) { _ in
            let productUpdateViewController = ProductUpdateViewController()
            self.navigationController?.pushViewController(productUpdateViewController,
                                                          animated: true)
        }
        let deleteAlertAction = UIAlertAction(title: "삭제",
                                              style: .destructive) { _ in
            print("삭제")
        }
        let cancelAlertAction = UIAlertAction(title: "취소",
                                              style: .cancel)
        
        alertController.addAction(updateAlertAction)
        alertController.addAction(deleteAlertAction)
        alertController.addAction(cancelAlertAction)
        
        present(alertController, animated: true)
    }
}

// MARK: - extensions

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImageCell.identifier,
                                                            for: indexPath) as? ProductImageCell
        else { return UICollectionViewCell() }
        
        cell.imageView.image = images[indexPath.row]
        
        return cell
    }
}

extension ProductDetailViewController: DataSendable {
    func setupData<T>(_ data: T) {
        productID = data as? String
    }
}

extension ProductDetailViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.productImageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
        let index: Int
        
        if velocity.x > 0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }
        
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        productDetailView.setupPageCountLabel(text: "\(indexPath.row + 1)/\(images.count)")
    }
}
