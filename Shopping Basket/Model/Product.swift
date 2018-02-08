//
//  Product.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 06/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//
import UIKit

class Product {
    let uuid: String
    let name: String
    let price: Money
    let image: UIImage?

    init(withUuid uuid: String, name: String,
         price: Money, image: UIImage?) {
        self.uuid = uuid
        self.name = name
        self.price = price
        self.image = image
    }

    convenience init(withName name: String,
                     price: Money, image: UIImage?) {
        let uuid = UUID().uuidString
        self.init(withUuid: uuid, name: name,
                  price: price, image: image)
    }
}
