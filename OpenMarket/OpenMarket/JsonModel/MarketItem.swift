//
//  MarketItem.swift
//  OpenMarket
//
//  Created by NAMU on 2022/07/11.
//

struct OpenMarketPage: Decodable {
    private(set) var pageNumber: Int
    private(set) var itemsPerPage: Int
    private(set) var totalCount: Int
    private(set) var offset: Int
    private(set) var limit: Int
    private(set) var pages: [MarketItem]
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page_no"
        case itemsPerPage = "items_per_page"
        case totalCount = "total_count"
        case offset
        case limit
        case pages
    }
    
    struct MarketItem: Decodable {
        private(set) var id: Int
        private(set) var venderID: Int
        private(set) var name: String
        private(set) var thumbnail: String
        private(set) var currency: String
        private(set) var price: Int
        private(set) var bargainPrice: Int
        private(set) var discountedPrice: Int
        private(set) var stock: Int
        private(set) var createdAt: String
        private(set) var issuedAt: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case venderID = "vendor_id"
            case name
            case thumbnail
            case currency
            case price
            case bargainPrice = "bargain_price"
            case discountedPrice = "discounted_price"
            case stock
            case createdAt = "created_at"
            case issuedAt = "issued_at"
        }
    }
}
