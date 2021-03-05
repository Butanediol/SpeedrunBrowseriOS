// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let runsResult = try? newJSONDecoder().decode(RunsResult.self, from: jsonData)

import Foundation

// MARK: - RunsResult
struct RunsResult: Codable {
    let data: [Run]
    let pagination: Pagination
}

// MARK: - Datum
struct Run: Codable {
    let id: String
    let weblink: String
    let game: String
//    let level: NSNull
    let category: String
    let videos: Videos?
    let comment: String?
    let status: Status
    let players: [Player]
    let date: String?
    let submitted: Date?
    let times: Times
    let system: System
//    let splits: Splits
    let values: [String: String]
    let links: [DatumLink]
}

// MARK: - DatumLink
struct DatumLink: Codable {
    let rel: String
    let uri: String
}

// MARK: - Player
struct Player: Codable {
    let rel: String
    let id: String?
    let uri: String
}

// MARK: - Status
struct Status: Codable {
    let status: String
    let examiner: String?
    let verifyDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case status, examiner
        case verifyDate = "verify-date"
    }
}

// MARK: - System
struct System: Codable {
    let platform: String?
    let emulated: Bool
//    let region: String
}

// MARK: - Times
struct Times: Codable {
    let primary: String
    let primaryT: Double
    let realtime: String?
    let realtimeT: Double
    let realtimeNoloads: String?
    let realtimeNoloadsT: Double
//    let ingame: Int
    let ingameT: Double
    
    enum CodingKeys: String, CodingKey {
        case primary
        case primaryT = "primary_t"
        case realtime
        case realtimeT = "realtime_t"
        case realtimeNoloads = "realtime_noloads"
        case realtimeNoloadsT = "realtime_noloads_t"
//        case ingame
        case ingameT = "ingame_t"
    }
}

// MARK: - Values
struct Values: Codable {
    let dlo26Eno: String
}

// MARK: - Videos
struct Videos: Codable {
    let links: [VideosLink]?
}

// MARK: - VideosLink
struct VideosLink: Codable {
    let uri: String
}
