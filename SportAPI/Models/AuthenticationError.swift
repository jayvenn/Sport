import Foundation

enum AuthenticationError: Error {
    case validLoginCredentialsRequired(Int)
}

extension AuthenticationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case.validLoginCredentialsRequired(let statusCode):
            return "Invalid login credential.\n(\(statusCode))"
        }
    }
}
