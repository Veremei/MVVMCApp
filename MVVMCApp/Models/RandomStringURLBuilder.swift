//
//  RandomStringURLBuilder.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 21.04.2022.
//

import Foundation

struct RandomStringURLBuilder {
    enum Parameters: String {
        case num
        case len
        case digits
        case upperalpha
        case loweralpha
        case unique
        case format
        case rnd
    }

    static func build(num: Int = 10,
                      len: Int = 8,
                      digits: Bool = true,
                      upperalpha: Bool = true,
                      loweralpha: Bool = true,
                      unique: Bool = true,
                      format: String = "plain",
                      rnd: String = "new"
    ) -> Endpoint {
        let params: [URLQueryItem] = [
            URLQueryItem(name: Parameters.num.rawValue, value: "\(num)"),
            URLQueryItem(name: Parameters.len.rawValue, value: "\(len)"),
            URLQueryItem(name: Parameters.digits.rawValue, value: digits ? "on" : "off"),
            URLQueryItem(name: Parameters.upperalpha.rawValue, value: upperalpha ? "on" : "off"),
            URLQueryItem(name: Parameters.loweralpha.rawValue, value: loweralpha ? "on" : "off"),
            URLQueryItem(name: Parameters.unique.rawValue, value: unique ? "on" : "off"),
            URLQueryItem(name: Parameters.format.rawValue, value: format),
            URLQueryItem(name: Parameters.rnd.rawValue, value: rnd)
        ]

        return Endpoint(host: "www.random.org",
                        path: "/strings/",
                        queryItems: params)
    }
}
