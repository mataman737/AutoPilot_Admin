//
//  Order.swift
//  SpainFX
//
//  Created by Dylan Reich on 7/8/23.
//

import Foundation

// MARK: - Order
struct Order: Codable {
    let ticket: Int?
    let openTime, closeTime, expiration: String?
    let typeInt: Int?
    let lots: Double?
    let symbol: String?
    let openPrice, stopLoss, takeProfit, closePrice: Double?
    let magicNumber: Int?
    let swap, commission: Double?
    let comment: String?
    let profit, rateOpen, rateClose, rateMargin: Double?
    let ex: Ex?
    let placedType: String?
    
    var type: String? {
        guard let typeInt = typeInt else { return nil }
        
        switch (typeInt) {
        case 0:
            return "Buy"
        case 1:
            return "Sell"
        case 2:
            return "Buy Limit"
        case 3:
            return "Sell Limit"
        case 4:
            return "Buy Stop"
        case 5:
            return "Sell Stop"
        case 6:
            return "Balance"
        case 7:
            return "Credit"
        default:
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case ticket
        case openTime
        case closeTime
        case expiration
        case typeInt = "type"
        case lots
        case symbol
        case openPrice
        case stopLoss
        case takeProfit
        case closePrice
        case magicNumber
        case swap
        case commission
        case comment
        case profit
        case rateOpen
        case rateClose
        case rateMargin
        case ex
        case placedType
    }
}

// MARK: - Ex
struct Ex: Codable {
    let order, login: Int?
    let symbol: String?
    let digits, cmd, openTime: Int?
    let volume: Double?
    let state: Double?
    let openPrice, sl, tp: Double?
    let closeTime, valueDate, expiration, placeType: Int?
    let convRates: [Double]?
    let commission, commissionAgent, storage: Double?
    let closePrice: Double?
    let profit, taxes: Double?
    let magic: Int?
    let comment: String?
    let internalID, activation, spread: Double?
    let marginRate: Double?
    let timestamp: Int?
    let reserved: [Int]?
    let next: Int?
    
    enum CodingKeys: String, CodingKey {
        case order, login, symbol, digits, cmd, volume
        case openTime = "open_time"
        case state
        case openPrice = "open_price"
        case sl, tp
        case closeTime = "close_time"
        case valueDate = "value_date"
        case expiration
        case placeType = "place_type"
        case convRates = "conv_rates"
        case commission
        case commissionAgent = "commission_agent"
        case storage
        case closePrice = "close_price"
        case profit, taxes, magic, comment
        case internalID = "internal_id"
        case activation, spread
        case marginRate = "margin_rate"
        case timestamp, reserved, next
    }
}

struct TickerPriceUpdate: Codable {
    let symbol: String
    let price: Double
}
