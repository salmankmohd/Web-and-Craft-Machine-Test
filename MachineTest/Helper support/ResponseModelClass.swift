//
//  ResponseModelClass.swift
//  MachineTest
//
//  Created by Apple on 05/11/22.
//

import Foundation


struct HomeDatas: Decodable {
    let status: Bool
    let homeData: [HomeData]
}

struct HomeData: Decodable {
    let type: String
    let values: [Value]
}


struct Value: Decodable {
    let id: Int
    let name: String?
    let imageURL, bannerURL: String?
    let image: String?
    let actualPrice, offerPrice: String?
    let offer: Int?
    let isExpress: Bool?

    enum CodingKeys: String, CodingKey {
        case actualPrice = "actual_price"
        case offer
        case image
        case imageURL = "image_url"
        case offerPrice = "offer_price"
        case id, name
        case isExpress = "is_express"
        case bannerURL = "banner_url"
    }
}













