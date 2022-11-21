import Foundation

public extension SportAPI {
    enum Path: Hashable {
        case teams
        case matches
        var rawValue: String {
            switch self {
            case .teams:
                return "teams"
            case .matches:
                return "teams/matches"
            }
        }
        var httpMethod: HTTPMethod {
            switch self {
            default:
                return .get
            }
        }
        var version: String {
            switch self {
            default:
                return ""
            }
        }
        var headers: [String: String] {
            switch self {
            default:
                return [:]
            }
        }
        var host: String {
            switch self {
            default:
                return "jmde6xvjr4.execute-api.us-east-1.amazonaws.com"
            }
        }
    }
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
}

