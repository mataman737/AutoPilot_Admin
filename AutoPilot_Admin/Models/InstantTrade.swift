//
//  InstantTrade.swift
//  Enigma Trading
//
//  Created by Dylan Reich on 7/7/22.
//

import Foundation

struct InstantTrade: Codable {
    var id: UUID?
    var orderId: String?
    var positionId: String?
    var signalId: UUID?
    var userId: UUID?
    var adminId: String?
    var signalType: String?
    var account: String?
    var tradingPair: String?
    var orderType: String?
    var lotSize: String?
    var entryPrice: String?
    var takeProfit1: String?
    var takeProfit2: String?
    var takeProfit3: String?
    var trailingTakeProfit: Double?
    var takeProfitSelected: String?
    var stopLoss: String?
    var trailingStopLoss: Double?
    var open: Bool?
    var added: Date?
}

struct CreateSignalResponse: Codable {
    let status: String?
    let errorMsg: ErrorMsg?
    let responseCode: Double?
}

struct ErrorMsg: Codable {
    let message, code, stackTrace: String?
}

struct MetaTradeOrderStatusResponse: Codable {
    let id, type, state, symbol: String?
    let magic: Double?
    let time, brokerTime: String?
    let openPrice, currentPrice: Double?
    let platform: String?
    let volume, currentVolume: Double?
}

struct MetaPositionStatusResponse: Codable {
    let id, type, symbol: String?
    let magic: Double?
    let time, brokerTime: String?
    let openPrice, currentPrice, currentTickValue, stopLoss: Double?
    let volume, swap, profit: Double?
    let updateTime: String?
    let commission: Double?
    let clientID: String?
    let unrealizedProfit, realizedProfit: Double?

    enum CodingKeys: String, CodingKey {
        case id, type, symbol, magic, time, brokerTime, openPrice, currentPrice, currentTickValue, stopLoss, volume, swap, profit, updateTime, commission
        case clientID = "clientId"
        case unrealizedProfit, realizedProfit
    }
}

// MARK: - OrderHistoryItem
struct OrderHistoryItem: Codable {
    let id, platform, type, state: String?
    let symbol: String?
    let magic: Double?
    let time, brokerTime: String?
    let price: Double?
    let volume, currentVolume: Double?
    let positionID, reason, fillingMode, expirationType: String?
    let doneTime, doneBrokerTime: String?
    let accountCurrencyExchangeRate: Double?
    let stopLoss, takeProfit: Double?

    enum CodingKeys: String, CodingKey {
        case id, platform, type, state, symbol, magic, time, brokerTime, volume, currentVolume
        case price = "openPrice"
        case positionID = "positionId"
        case reason, fillingMode, expirationType, doneTime, doneBrokerTime, accountCurrencyExchangeRate, stopLoss, takeProfit
    }
}

struct MetaCreateAccountRequest: Codable {
    let login: String
    let password: String
    let name: String
    let server: String
    let platform: String
    let magic: Int
}


struct AutotradeCreateAccountRequest: Codable {
    let login: String
    let password: String
    let name: String
    let server: String
    let platform: String
    let magic: Int
    let trailingStopLoss: Double
}



struct InstantTradeStatus: Codable {
    let instantTrade: InstantTrade?
    let orderStatus: MetaTradeOrderStatusResponse?
    let positionStatus: MetaPositionStatusResponse?
    let history: [OrderHistoryItem]?
    
    var openOrder: OrderHistoryItem? {
        guard let instantTrade = instantTrade, let history = history, history.count > 1 else {
            return history?.sorted(by: {(stringToDate(stringTime: $0.time ?? String()) ) < (stringToDate(stringTime: $1.time ?? String()) )}).first
        }
        
        if instantTrade.orderType?.starts(with: "Buy") ?? false {
            guard let openOrder = history.first(where: {$0.type == "ORDER_TYPE_BUY"}) else {
                print("we should have a matching start order...")
                return nil
            }
            
            return openOrder
        } else if instantTrade.orderType?.starts(with: "Sell") ?? false {
            guard let openOrder = history.first(where: {$0.type == "ORDER_TYPE_SELL"}) else {
                print("we should have a matching start order...")
                return nil
            }
            
            return openOrder
        } else {
            print("unrecognized order type to fetch order for")
            print(instantTrade.orderType ?? "")
            return nil
        }
    }
    
    var closeOrder: OrderHistoryItem? {
        guard let instantTrade = instantTrade, let history = history, history.count > 1 else {
            return history?.sorted(by: {(stringToDate(stringTime: $0.time ?? String()) ) > (stringToDate(stringTime: $1.time ?? String()) )}).first
        }
        
        if instantTrade.orderType?.starts(with: "Buy") ?? false {
            guard let closeOrder = history.first(where: {$0.type == "ORDER_TYPE_SELL"}) else {
                print("we should have a matching order...")
                return nil
            }
            
            return closeOrder
        } else if instantTrade.orderType?.starts(with: "Sell") ?? false {
            guard let closeOrder = history.first(where: {$0.type == "ORDER_TYPE_BUY"}) else {
                print("we should have a matching close order...")
                return nil
            }
            
            return closeOrder
        } else {
            print("unrecognized order type to fetch close price for")
            print(instantTrade.orderType ?? "")
            return nil
        }
    }
    
    private func stringToDate(stringTime: String) -> Date {
        //if let time = signal.openOrder?.time {
        
        //First Separate components received from MetaAPI
        //into a string that is formatted into a way that
        //can be converted into a date
        let splitTime = stringTime.components(separatedBy: "T")
            let datePart = splitTime[0]
        let timePart = splitTime[1].replacingOccurrences(of: ".000Z", with: "")
        let timeString = "\(datePart) \(timePart)"
        
        //Convert time string into a date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from:timeString) {
            return date
        } else {
            return Date()
        }
            
            //Change the format of the string
            //into one that is readable and matches the 'All' tab
        /*
            if let sigDate = date {
                let formatter = DateFormatter()
                formatter.timeZone = NSTimeZone.local
                formatter.dateFormat = "h:mmaa M/dd/yy"
                cell.signalTimeLabel.text = formatter.string(from: sigDate)
            }
        */
        //}
    }
}
