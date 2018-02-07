//
//  ProductRepository.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 07/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

protocol ProductRepository {
    func getAll() -> [Product]
}
