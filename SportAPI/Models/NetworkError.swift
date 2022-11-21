import Foundation

enum NetworkError: Error, LocalizedError {
    case nonHTTPURLResponse
    case statusCode(code: Int, message: String? = nil)
    case invalidURL
    case other(Error)
    case notJSONObject(statusCode: Int)
    case missingHTTPStatusCode
    case unknown
    static func map(_ error: Error) -> NetworkError {
        error as? NetworkError ?? .other(error)
    }
    var errorDescription: String? {
        let result: String
        switch self {
        case .nonHTTPURLResponse:
            result = "Non HTTP URL response."
        case let .statusCode(code, message):
            result = "\(message ?? "Invalid status code")\n(\(code))"
        case .invalidURL:
            result = "Invalid URL request."
        case .other(let error):
            result = error.localizedDescription
        case .notJSONObject(let statusCode):
            result = "Not a JSON object.\n(\(statusCode))"
        case .missingHTTPStatusCode:
            result = "Missing HTTP status code."
        case .unknown:
            result = "Unknown error."
        }
        return result
    }
}
