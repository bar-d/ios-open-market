# 오픈 마켓 README.md

## 프로젝트 저장소
> 프로젝트 기간: 2022-07-11 ~ 2022-08-05</br>
> 팀원: [바드](https://github.com/bar-d), [그루트](https://github.com/Groot-94)</br>
리뷰어: [@Charlie](https://github.com/kcharliek)</br>
그라운드롤: [GroundRule - Wiki](https://github.com/bar-d/ios-open-market/wiki/Ground-Rules)

## 📑 목차
- [개발자 소개](#개발자-소개)
- [프로젝트 소개](#프로젝트-소개)
- [UML](#UML)
- [폴더 구조](#폴더-구조)
- [구현화면](#구현내용)
- [키워드](#키워드)
- [참고문서](#참고문서)
- [핵심경험](#핵심경험)
- [기능설명](#기능설명)
- [TroubleShooting](#TroubleShooting_Wiki)
- [1️⃣ Step1](#1️⃣-Step1_Wiki)
- [2️⃣ Step2](#2️⃣-Step2_Wiki)
- [3️⃣ Step3](#3️⃣-Step3_Wiki)
## 개발자 소개
|바드|그루트|
|:---:|:---:|
| <img src = "https://i.imgur.com/k9hX1UH.png" width="250" height="250">| <img src = "https://i.imgur.com/onBeySC.jpg" width="250" height="250"> |
|[바드](https://github.com/bar-d)|[그루트](https://github.com/Groot-94)|


## 프로젝트 소개
-  URL Session을 활용한 서버와의 통신을 통해 전달받은 JSON 데이터와 매핑할 모델을 활용
-  Modern CollectionView를 이용해 List, Grid 방식으로 마켓의 물품을 표시하도록 구현

## UML
### [ClassDiagram]
![](https://i.imgur.com/Uqx3FVq.jpg)

## 폴더 구조
```
├── OpenMarket
│   ├── OpenMarket
│   │   ├── DataManager
│   │   │   ├── ImageCacheManager.swift
│   │   │   └── OpenMarketManager.swift
│   │   ├── Enum
│   │   │   ├── Currency.swift
│   │   │   └── NameSpace.swift
│   │   ├── Error
│   │   │   ├── CodableError.swift
│   │   │   ├── DataError.swift
│   │   │   └── NetworkError.swift
│   │   ├── Extension
│   │   │   ├── Data+extension.swift
│   │   │   ├── Double+extension.swift
│   │   │   ├── UIImage+extension.swift
│   │   │   └── UIView+extension.swift
│   │   ├── JSONModel
│   │   │   ├── ProductDetail.swift
│   │   │   ├── ProductImage.swift
│   │   │   ├── ProductInformation.swift
│   │   │   ├── ProductsList.swift
│   │   │   ├── RegisterationProduct.swift
│   │   │   ├── SecretProducts.swift
│   │   │   └── Vendors.swift
│   │   ├── Network
│   │   │   ├── APIRequest.swift
│   │   │   ├── MyURLSession.swift
│   │   │   └── SessionProtocol.swift
│   │   ├── OpenMarketRequest
│   │   │   ├── ImageGetRequest.swift
│   │   │   ├── ProductDeleteRequest.swift
│   │   │   ├── ProductGetRequest.swift
│   │   │   ├── ProductPatchRequest.swift
│   │   │   ├── ProductPostRequest.swift
│   │   │   └── RequestConfiguration
│   │   │       ├── HTTPHeaders.swift
│   │   │       ├── URLAdditionalPath.swift
│   │   │       └── URLHost.swift
│   │   ├── Protocol
│   │   │   └── DataSendable.swift
│   │   ├── Resources
│   │   │   ├── AppDelegate.swift
│   │   │   └── SceneDelegate.swift
│   │   │   ├──  Info.plist
│   │   │   Assets.xcassets
│   │   │       └── MockData.dataset
│   │   │           ├── Contents.json
│   │   │           └── MockData.json
│   │   ├── Scene
│   │   │   ├── Model
│   │   │   ├── ProductDetail
│   │   │   │   ├── ProductDetailViewController.swift
│   │   │   │   └── View
│   │   │   │       ├── ProductDetailView.swift
│   │   │   │       └── ProductImageCell.swift
│   │   │   ├── ProductList
│   │   │   │   ├── Controller
│   │   │   │   │   └── ProductListViewController.swift
│   │   │   │   ├── Model
│   │   │   │   │   └── Enum
│   │   │   │   │       ├── ProductListNameSpace.swift
│   │   │   │   │       └── Section.swift
│   │   │   │   └── View
│   │   │   │       ├── GridCollecntionView.swift
│   │   │   │       ├── GridCollectionViewCell.swift
│   │   │   │       ├── ListCollectionView.swift
│   │   │   │       └── ListCollectionViewCell.swift
│   │   │   ├── ProductRegistration
│   │   │   │   ├── Controller
│   │   │   │   │   └── ProductRegistrationViewController.swift
│   │   │   │   ├── Model
│   │   │   │   │   └── ProductRegistrationManager.swift
│   │   │   │   └── View
│   │   │   │       └── ProductRegistrationView.swift
│   │   │   └── ProductUpdate
│   │   │       └── Model
│   │   │           ├── ProductUpdateManager.swift
│   │   │           ├── ProductUpdateView.swift
│   │   │           └── ProductUpdateViewController.swift
│   │   └── TestDouble
│   │       └── MockSession.swift
│   └── OpenMarketTests
│       ├── ParsingTests.swift
│       └── RequestTests.swift
└── README.md
```
## 구현화면
|||
|:---:|:---:|
|레이아웃 변경 화면|화면 스크롤|
| <img src = "https://i.imgur.com/9OxGWib.gif" width="300" height="600">| <img src = "https://i.imgur.com/nYey8oC.gif" width="300" height="600"> |
|리스트 화면 새로고침|그리드 화면 새로고침|
| <img src = "https://i.imgur.com/1TMvjwp.gif" width="300" height="600">| <img src = "https://i.imgur.com/VRFrIcf.gif" width="300" height="600"> |
|새 상품 등록|상품 설명 키보드 내 키보드 내리는 버튼 구현|
| <img src = "https://i.imgur.com/kBW2zhO.gif" width="300" height="600">| <img src = "https://i.imgur.com/HDMGd5o.gif" width="300" height="600"> |
|사진 등록 스크롤뷰 구현|등록 형식을 못맞췄을 때|
| <img src = "https://i.imgur.com/GJhqacZ.gif" width="300" height="600">| <img src = "https://i.imgur.com/UqO0PZa.gif" width="300" height="600"> |
|상품 삭제 구현|상품 수정 구현|
|<img src = "https://i.imgur.com/5U1bgBG.gif" width="300" height="600">|<img src = "https://i.imgur.com/OJpYfei.gif" width="300" height="600">|
|상품삭제 비밀번호 틀렸을 때|수정할 때 형식 못맞췃을때|
|<img src = "https://i.imgur.com/WLYIcMC.gif" width="300" height="600">|<img src = "https://i.imgur.com/iLY8who.gif" width="300" height="600">|

## 키워드
- JSON Decoder
- URLSession
- MockSession
- Unit Test
- Asynchronous Tests
- Collection View
- Mordern Collection View
- Compositional Layout
- List Configuration
- UISegmentedControl
- UIActivityIndicatorView
- UICollectionViewDiffableDataSource
- NSMutableAttributedString
- asynchronous data fetching
- UIImagePickerController
- UITextView
- UITextViewDelegate
- Keyboard
- UIAlertController
- multipart-form/data
- UICollectionView Pagination
## 참고문서
- [URLSession](https://developer.apple.com/documentation/foundation/urlsession)
    - [Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
    - [Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
    - [Lists in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10026)
    - [Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
- [Data Entry - iOS - Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/patterns/entering-data/)
- [UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller)
## 핵심경험
- [x] 프로토콜을 이용하여 네트워크 구성을 파악하고 추상화 하는 경험을 할 수 있었다.
- [x] 네트워크가 없는 상황에서 Unit Test를 위하여 MockSession Test 구현해서 테스트하는 경험을 할 수 있었다.
- [x] URLSession을 위한 네트워크 타입을 구현해서 실제 서버와의 통신을 통해 데이터를 받아오는 경험을 할 수 있었다.
- [x] JSONParsing을 통해 JSON 파일을 데이터로 불러오는 경험을 할 수 있었다.
- [x] Modern CollectionView를 활용하여 뷰를 구성하는 경험을 할 수 있었다.
- [x] SegmentedControl을 활용하여 뷰의 내용을 실시간으로 변경하는 경험을 할 수 있었다.
- [x] UIActivityIndicatorView를 활용하여 로딩화면을 구현하는 경험을 할 수 있었다.
- [x] UIRefreshControl을 활용하여 화면의 데이터를 변경하는 새로고침 하는 기능을 구현하는 경험을 할 수 있었다.
- [x] 데이터 비동기 처리를 통한 앱 성능 최적화 경험을 할 수 있었다.
- [x] multipart/form-data의 구조를 사용해서 POST 하여 데이터를 서버로 올리는 경험을 할 수 있었다. 
- [x] TextField, TextView로 키보드를 사용하는 경험을 할 수 있었다.
- [X] UICollectionView를 활용해 여러가지 스크롤 방식을 경험할 수 있었다. 
## 기능설명
### Network
- **`네트워크 통신을 하는데 필요한 타입들 구현`**
    - APIRequest
    - MyURLSession
    - SessionProtocol


### JSONModel
- **`Json Data decoding, encoding을 위한 타입들 구현`**
    - Currency
    - ProductDetail
    - ProductImage
    - ProductInformation
    - ProductsList
    - RegistrationProduct
    - SecretProducts
    - Vendors

### Error
- **`Error 처리를 하기 위해 각 타입별로 Error 타입들 구현`**
    - CodableError
    - DataError
    - NetworkError

### TestDouble
- **`URLSession 테스트를 하기위한 MockSession 타입 구현`**
    - MockSession
### OpenMarketTests
- **`OpenMarket 모듈들의 Unit Test를 위한 타입 구현`**
    - ParsingTests
    - RequestTests
### DataSendable
- **`delegate 패턴을 이용해 Controller 간 데이터를 전달하기 위한 Protocol 구현`**
### Scene
#### 1. ProductList
##### ProductListView
- **`상품을 표시하는 컬렉션 뷰`**
    - Mordern Collection View 방식의 List Configuration을 활용한 List layout 컬렉션 뷰
    - Mordern Collection View 방식의 Compositional Layout 활용한 Grid layout 컬렉션 뷰
##### UISegmentedControl
- **`UISegmentedControl을 통한 List, Grid 레이아웃 화면 전환`**
##### UIActivityIndicatorView
- **`로딩 상태를 나타내기 위한 비동기식 뷰 구현`**
##### UIRefreshControl
- **`데이터의 새로고침 기능을 구현하기 위한 UIRefreshControl 사용`**

#### 2. ProductRegistration
##### ProductRegistrationManager
- **`서버로 상품정보를 보내기 위한 Post 모델 구현`**
##### ProductRegistrationView
- **`상품정보를 입력받는 뷰 구현`**
##### UIImagePickerController
- **`사진첩에서 이미지를 가져오는 기능을 구현`**

#### 3. ProductUpdate
##### ProductUpdateManager
- **`상품정보를 수정하기 위한 Patch 모델 구현`**
##### ProductUpdateView
- **`수정이 필요한 상품정보를 입력받는 뷰 구현`**

#### 4. ProductDetail
##### UIAlertController
- **`상품의 시크릿 넘버를 입력받아 상품을 삭제할 수 있는 경고창 구현`**
##### ProductDetailView
- **`상품의 상세정보를 보여주기 위한 뷰 구현`**
##### ProductImageCell
- **`상품의 image들을 페이지 넘김으로 보여주기 위한 UICollectionCell 구현`**
## [TroubleShooting_Wiki](https://github.com/bar-d/ios-open-market/wiki/TroubleShooting)
## [1️⃣ Step1_Wiki](https://github.com/bar-d/ios-open-market/wiki/Step1)
## [2️⃣ Step2_Wiki](https://github.com/bar-d/ios-open-market/wiki/Step2)
## [3️⃣ Step3_Wiki](https://github.com/bar-d/ios-open-market/wiki/Step3)