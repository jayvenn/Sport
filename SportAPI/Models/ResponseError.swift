import Foundation

enum ResponseError: Error {
    case emptyResponse
}
extension ResponseError: LocalizedError {
    var errorDescription: String? {
        let result: String
        switch self {
        case .emptyResponse:
            result = "Empty response data."
        }
        return result
    }
}
