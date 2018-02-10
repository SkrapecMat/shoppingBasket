//
//  NetworkingError.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 07/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

enum NetworkingErrorType {
    case ServerError
    case JSONParsingError
    case ResponseError
    case ParametersError
}

struct NetworkingError {
    var errorMsg: String = ""
    var errorCode: Int = -1
    var errorType: NetworkingErrorType = .ServerError


    init(_ errorType: NetworkingErrorType,
         errorMsg: String = "",
         errorCode: Int = -1) {
        self.errorMsg = errorMsg
        self.errorCode = errorCode
        self.errorType = errorType
    }
}
