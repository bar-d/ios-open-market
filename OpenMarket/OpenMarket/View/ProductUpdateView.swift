//
//  ProductUpdateView.swift
//  OpenMarket
//
//  Created by groot, bard on 2022/07/30.
//

import UIKit

final class ProductUpdateView: UIView {
    // MARK: - properties
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Design.stackViewSpacing
        
        return stackView
    }()
    
    private let imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.setupBoder(cornerRadius: Design.borderCornerRadius,
                              borderWidth: Design.borderWidth,
                              borderColor: UIColor.systemGray3.cgColor)
        
        return scrollView
    }()
    
    private let imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.spacing = Design.stackViewSpacing
        
        return stackView
    }()
    
    private let productInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Design.stackViewSpacing
        
        return stackView
    }()
    
    private let segmentedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Design.stackViewSpacing
        
        return stackView
    }()
    
    private let productDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.setupBoder(cornerRadius: Design.borderCornerRadius,
                            borderWidth: Design.borderWidth,
                            borderColor: UIColor.systemGray3.cgColor)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.text = Design.productDescriptionPlaceholder
        textView.textColor = .systemGray3
        
        return textView
    }()
    
    private let productName: UITextField = {
        let textField = UITextField()
        textField.placeholder = Design.productNamePlaceholder
        textField.leftView = UIView(frame: CGRect(x: .zero,
                                                  y: .zero,
                                                  width: Design.viewFrameWidth,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.setupBoder(cornerRadius: Design.borderCornerRadius,
                             borderWidth: Design.borderWidth,
                             borderColor: UIColor.systemGray3.cgColor)
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    private let productPrice: UITextField = {
        let textField = UITextField()
        textField.placeholder = Design.productPricePlaceholder
        textField.leftView = UIView(frame: CGRect(x: .zero,
                                                  y: .zero,
                                                  width: Design.viewFrameWidth,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.setupBoder(cornerRadius: Design.borderCornerRadius,
                             borderWidth: Design.borderWidth,
                             borderColor: UIColor.systemGray3.cgColor)
        textField.keyboardType = .decimalPad
        
        return textField
    }()
    
    private let productDiscountedPrice: UITextField = {
        let textField = UITextField()
        textField.placeholder = Design.productDiscountedPricePlaceholder
        textField.leftView = UIView(frame: CGRect(x: .zero,
                                                  y: .zero,
                                                  width: Design.viewFrameWidth,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.setupBoder(cornerRadius: Design.borderCornerRadius,
                             borderWidth: Design.borderWidth,
                             borderColor: UIColor.systemGray3.cgColor)
        textField.keyboardType = .decimalPad
        
        return textField
    }()
    
    private let stock: UITextField = {
        let textField = UITextField()
        textField.placeholder = Design.stockPlaceholder
        textField.leftView = UIView(frame: CGRect(x: .zero,
                                                  y: .zero,
                                                  width: Design.viewFrameWidth,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.setupBoder(cornerRadius: Design.borderCornerRadius,
                             borderWidth: Design.borderWidth,
                             borderColor: UIColor.systemGray3.cgColor)
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    private let currencySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [Currency.krw.rawValue,
                                                          Currency.usd.rawValue])
        segmentedControl.selectedSegmentIndex = .zero
        
        return segmentedControl
    }()
    
    // MARK: - functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupView()
        setupDelegate()
        setupContent()
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(totalStackView)
        setupSubviews()
        setupSubViewsHeight()
        setupConstraints()
    }
    
    private func setupDelegate() {
        productDescriptionTextView.delegate = self
        productName.delegate = self
        productPrice.delegate = self
    }
    
    private func setupContent() {
        setupUiToolbar()
        addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                    action: #selector(endEditing(_:))))
    }
    
    private func setupSubviews() {
        [imageScrollView, productInformationStackView, productDescriptionTextView]
            .forEach { totalStackView.addArrangedSubview($0) }
        [productName, segmentedStackView, productDiscountedPrice, stock]
            .forEach { productInformationStackView.addArrangedSubview($0) }
        [productPrice, currencySegmentedControl]
            .forEach { segmentedStackView.addArrangedSubview($0) }
        imageScrollView.addSubview(imageStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [totalStackView.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor),
             totalStackView.leadingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
             totalStackView.trailingAnchor
                .constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
             totalStackView.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
        
        NSLayoutConstraint.activate([
            imageStackView.topAnchor
                .constraint(equalTo: imageScrollView.topAnchor,
                            constant: Design.imageScrollViewTopAnchorConstant),
            imageStackView.bottomAnchor
                .constraint(equalTo: imageScrollView.bottomAnchor,
                            constant: Design.imageScrollViewBottomAnchorConstant),
            imageStackView.leadingAnchor
                .constraint(equalTo: imageScrollView.leadingAnchor,
                            constant: Design.imageScrollViewLeadingAnchorConstant),
            imageStackView.trailingAnchor
                .constraint(equalTo: imageScrollView.trailingAnchor,
                            constant: Design.imageScrollViewTrailingAnchorConstant)
        ])
    }
    
    private func setupSubViewsHeight() {
        NSLayoutConstraint.activate(
            [productDescriptionTextView.heightAnchor
                .constraint(equalTo: safeAreaLayoutGuide.heightAnchor,
                            multiplier: Design.safeAreaLayoutGuideHeightAnchorMultiplier),
             productInformationStackView.heightAnchor
                .constraint(equalTo: productDescriptionTextView.heightAnchor,
                            multiplier: Design.productDescriptionTextViewHeightAnchorMultiplier)])
    }
    
    private func setupUiToolbar() {
        let keyboardToolbar = UIToolbar()
        let doneBarButton = UIBarButtonItem(title: Design.barButtonItemTitle,
                                            style: .plain,
                                            target: self,
                                            action: #selector(endEditing(_:)))
        
        keyboardToolbar.items = [doneBarButton]
        keyboardToolbar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        keyboardToolbar.sizeToFit()
        keyboardToolbar.tintColor = UIColor.systemGray
        
        productDescriptionTextView.inputAccessoryView = keyboardToolbar
    }
    
    @objc func endEditing(){
        resignFirstResponder()
    }
}

// MARK: - extensions

extension ProductUpdateView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        frame.origin.y = -productDescriptionTextView.frame.height * 1.2
        if textView.text == Design.productDescriptionPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        frame.origin.y = .zero
        if textView.text.count == 0 {
            textView.text = Design.productDescriptionPlaceholder
            textView.textColor = .lightGray
        }
    }
}

extension ProductUpdateView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let textFieldText = textField.text else { return }
        if textFieldText.count > 100 {
            textField.deleteBackward()
        }
        
        if productPrice.text!.components(separatedBy: ".").count > 2 {
            productPrice.deleteBackward()
        }
    }
}

// MARK: - Design

private enum Design {
    static let stackViewSpacing = 4.0
    static let borderCornerRadius = 10.0
    static let borderWidth = 1.5
    static let viewFrameWidth = 4.0
    static let productNamePlaceholder = "상품명 (3자 이상, 100자 이하)"
    static let productPricePlaceholder = "상품가격 (필수입력)"
    static let productDiscountedPricePlaceholder = "할인금액 (미입력 시 정상가)"
    static let stockPlaceholder = "재고수량 (미입력 시 품절)"
    static let productDescriptionPlaceholder = "상품 설명 (10자 이상, 1000자 이하)"
    static let imageScrollViewTopAnchorConstant = 8.0
    static let imageScrollViewBottomAnchorConstant = -8.0
    static let imageScrollViewLeadingAnchorConstant = 8.0
    static let imageScrollViewTrailingAnchorConstant = -8.0
    static let imageScrollViewHeightAnchorConstant = -16.0
    static let imageScrollViewHeightAnchorMultiplier = 1.0
    static let safeAreaLayoutGuideHeightAnchorMultiplier = 0.4
    static let productDescriptionTextViewHeightAnchorMultiplier = 0.5
    static let barButtonItemTitle = "Done"
    static let imageResizeWidth = 300.0
    static let imageStackViewSubviewsCount = 6
    static let imageDataCountConstraint = 300.0
    static let renderImageResizeNumber = 5.0
    static let devideImageDataCountByThousand = 1000.0
}
