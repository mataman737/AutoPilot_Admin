//
//  Signal.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/21/23.
//

import Foundation

struct Signal: Codable {
    var id: UUID?
    var hostId: UUID?
    var enigmaId: String?
    var signalType: String?
    var asset: String?
    var orderType: String?
    var entryPrice: String?
    var takeProfit1: String?
    var takeProfit2: String?
    var takeProfit3: String?
    var stopLoss: String?
    var active: Bool
    var time: String?
    var notes: String?
    var image: String?
    var type: String?
    var added: Date?
}

struct SignalModifyRequest: Codable {
    var id: UUID?
    var hostId: UUID?
    var enigmaId: String?
    var signalType: String?
    var asset: String?
    var orderType: String?
    var entryPrice: String?
    var takeProfit1: String?
    var takeProfit2: String?
    var takeProfit3: String?
    var stopLoss: String?
    var active: Bool
    var time: String?
    var notes: String?
    var image: String?
    var type: String?
    var added: Date?
}

struct SignalRequest: Codable {
    var id: UUID?
    var hostId: UUID?
    var providerId: Int?
    var signalType: String?
    var enigmaId: String?
    var asset: String?
    var orderType: String?
    var entryPrice: String?
    var takeProfit1: String?
    var takeProfit2: String?
    var takeProfit3: String?
    var stopLoss: String?
    var active: Bool
    var time: String?
    var notes: String?
    var image: String?
    var type: String?
    var added: Date?
    var isTesting: Bool
}

struct MTInstantTradeStatus: Codable {
    let instantTrade: InstantTrade?
    let order: Order?
}

struct OrderProfitUpdate: Codable {
    let type, id: String
        let data: OrderProfitDataClass
    let livePrices: LivePrices

        enum CodingKeys: String, CodingKey {
            case type = "Type"
            case id = "Id"
            case data = "Data"
            case livePrices = "LivePrices"
        }
}

// MARK: - OrderProfitDataClass
struct OrderProfitDataClass: Codable {
    let balance, equity: Double?
    let margin: Double?
    let freeMargin, profit: Double?
    let orders: [OrderProfit]

    enum CodingKeys: String, CodingKey {
        case balance = "Balance"
        case equity = "Equity"
        case margin = "Margin"
        case freeMargin = "FreeMargin"
        case profit = "Profit"
        case orders = "Orders"
    }
}

// MARK: - OrderProfit
struct OrderProfit: Codable {
    let ticket: Int?
    let openTime, closeTime, expiration, type: String?
    let lots: Double?
    let symbol: String?
    let openPrice: Double?
    let stopLoss, takeProfit: Double?
    let closePrice: Double?
    let magicNumber: Double?
    let swap, commission: Double?
    let comment: String?
    let profit: Double?
    let rateOpen, rateClose, rateMargin: Double?
    let ex: OrderProfitEx?
    let placedType: String?

    enum CodingKeys: String, CodingKey {
        case ticket = "Ticket"
        case openTime = "OpenTime"
        case closeTime = "CloseTime"
        case expiration = "Expiration"
        case type = "Type"
        case lots = "Lots"
        case symbol = "Symbol"
        case openPrice = "OpenPrice"
        case stopLoss = "StopLoss"
        case takeProfit = "TakeProfit"
        case closePrice = "ClosePrice"
        case magicNumber = "MagicNumber"
        case swap = "Swap"
        case commission = "Commission"
        case comment = "Comment"
        case profit = "Profit"
        case rateOpen = "RateOpen"
        case rateClose = "RateClose"
        case rateMargin = "RateMargin"
        case ex = "Ex"
        case placedType = "PlacedType"
    }
}

// MARK: - OrderProfitEx
struct OrderProfitEx: Codable {
    let order, login: Double?
    let symbol: String?
    let digits, cmd, volume, openTime: Double?
    let state: Double?
    let openPrice: Double?
    let sl, tp, closeTime, valueDate: Double?
    let expiration, placeType: Double?
    let convRates: [Double]?
    let commission: Double?
    let commissionAgent: Double?
    let storage, closePrice, profit: Double?
    let taxes, magic: Double?
    let comment: String?
    let internalID, activation, spread, marginRate: Double?
    let timestamp: Double?
    let reserved: [Double]?
    let next: Double?

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

struct LivePrices: Codable {
    let AUDCAD: Double?
    let AUDCHF: Double?
    let AUDJPY: Double?
    let AUDNZD: Double?
    let AUDUSD: Double?
    let CADCHF: Double?
    let CADJPY: Double?
    let CHFJPY: Double?
    let EURAUD: Double?
    let EURCAD: Double?
    let EURCHF: Double?
    let EURGBP: Double?
    let EURJPY: Double?
    let EURNOK: Double?
    let EURNZD: Double?
    let EURPLN: Double?
    let EURSEK: Double?
    let EURTRY: Double?
    let EURUSD: Double?
    let GBPAUD: Double?
    let GBPCAD: Double?
    let GBPCHF: Double?
    let GBPJPY: Double?
    let GBPNZD: Double?
    let GBPUSD: Double?
    let NZDCAD: Double?
    let NZDCHF: Double?
    let NZDJPY: Double?
    let NZDUSD: Double?
    let SGDJPY: Double?
    let USDCAD: Double?
    let USDCHF: Double?
    let USDCNH: Double?
    let USDHKD: Double?
    let USDJPY: Double?
    let USDMXN: Double?
    let USDNOK: Double?
    let USDPLN: Double?
    let USDRUB: Double?
    let USDSEK: Double?
    let USDSGD: Double?
    let USDTRY: Double?
    let USDZAR: Double?
    let US100: Double?
    let US30: Double?
    let US500: Double?
    let SPX500: Double?
    let NAS100: Double?
    let WTI: Double?
    let XAGUSD: Double?
    let XAUUSD: Double?
    let XPTUSD: Double?
    let XPDUSD: Double?
    let BTCUSD: Double?
    let ETHUSD: Double?
    let GER30: Double?
    
    func priceForSymbol(symbol: String) -> Double? {
        switch symbol {
            case "AUDCAD":
                return AUDCAD
            case "AUDCHF":
                return AUDCHF
            case "AUDJPY":
                return AUDJPY
            case "AUDNZD":
                return AUDNZD
            case "AUDUSD":
                return AUDUSD
            case "CADCHF":
                return CADCHF
            case "CADJPY":
                return CADJPY
            case "CHFJPY":
                return CHFJPY
            case "EURAUD":
                return EURAUD
            case "EURCAD":
                return EURCAD
            case "EURCHF":
                return EURCHF
            case "EURGBP":
                return EURGBP
            case "EURJPY":
                return EURJPY
            case "EURNOK":
                return EURNOK
            case "EURNZD":
                return EURNZD
            case "EURPLN":
                return EURPLN
            case "EURSEK":
                return EURSEK
            case "EURTRY":
                return EURTRY
            case "EURUSD":
                return EURUSD
            case "GBPAUD":
                return GBPAUD
            case "GBPCAD":
                return GBPCAD
            case "GBPCHF":
                return GBPCHF
            case "GBPJPY":
                return GBPJPY
            case "GBPNZD":
                return GBPNZD
            case "GBPUSD":
                return GBPUSD
            case "NZDCAD":
                return NZDCAD
            case "NZDCHF":
                return NZDCHF
            case "NZDJPY":
                return NZDJPY
            case "NZDUSD":
                return NZDUSD
            case "SGDJPY":
                return SGDJPY
            case "USDCAD":
                return USDCAD
            case "USDCHF":
                return USDCHF
            case "USDCNH":
                return USDCNH
            case "USDHKD":
                return USDHKD
            case "USDJPY":
                return USDJPY
            case "USDMXN":
                return USDMXN
            case "USDNOK":
                return USDNOK
            case "USDPLN":
                return USDPLN
            case "USDRUB":
                return USDRUB
            case "USDSEK":
                return USDSEK
            case "USDSGD":
                return USDSGD
            case "USDTRY":
                return USDTRY
            case "USDZAR":
                return USDZAR
            case "US100": //US100.cash - Prevail only
                return US100
            case "US30": //US30.cash - Prevail only
                return US30
            case "US500": //US500.cash - Prevail only
                return US500
            case "SPX500": //SPX500.cash - Prevail only
                return SPX500
            case "NAS100": //NAS100.cash - Prevail only
                return NAS100
            case "WTI":
                return WTI
            case "XAGUSD":
                return XAGUSD
            case "XAUUSD":
                return XAUUSD
            case "XPTUSD":
                return XPTUSD
            case "XPDUSD":
                return XPDUSD
            case "BTCUSD":
                return BTCUSD
            case "ETHUSD":
                return ETHUSD
            case "GER30": //GER30.cash - Prevail only
                return GER30
        default:
            return nil
        }
    }
}


struct MTServerBroker: Codable {
    let broker: String
    let servers: [String]
}


struct MTCreateAccountRequest: Codable {
    let login: String
    let password: String
    let name: String
    let server: String
    let platform: String
    let magic: Int
    let lotSize: Double
}
