//
//  ConversionDTO.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 10/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

struct ConversionDTO: Codable {
    let terms: String
    let privacy: String
    let success: Bool
    let quotes: [String: Double]
    let source: String
    let timestamp: Int
}
