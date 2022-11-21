import Combine
import Foundation

public final class FootballAWS {
    // MARK: - Value Types
    public typealias Parameters = [Parameter: AnyHashable]
    public typealias Headers = [String: AnyHashable]
    // MARK: - Properties
    public static let shared = FootballAWS()
    // MARK: - Initializers
    private init() { }
    // MARK: - Unauthenticated Publishers
    public func makeUnauthenticatedPublisher<T: Decodable>(
        path: Path,
        headers: Headers? = nil,
        parameters: Parameters = [:]
    ) -> AnyPublisher<T, Error> {
        makePublisher(path: path, headers: headers, parameters: parameters)
    }
    // MARK: - URL Publisher Factory
    func makePublisher<T: Decodable>(
        accessToken: String? = nil,
        membershipId: String? = nil,
        path: Path,
        headers: Headers?,
        parameters: Parameters = [:],
        data: Data? = nil
    ) -> AnyPublisher<T, Error> {
        guard
            let request = makeRequest(
                path: path,
                accessToken: accessToken,
                headers: headers,
                parameters: parameters,
                data: data
            )
        else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        NetworkLogger.log(request: request as URLRequest)
        return URLSession.shared
            .dataTaskPublisher(for: request as URLRequest)
            .share()
            .tryMap { result -> T in
                NetworkLogger.log(response: result.response, data: result.data)
                guard let httpURLResponse = result.response as? HTTPURLResponse else {
                    throw NetworkError.nonHTTPURLResponse
                }
                let statusCode = httpURLResponse.statusCode
                guard (200..<300).contains(statusCode) else {
                    if (500..<600).contains(statusCode) {
                        throw AuthenticationError.validLoginCredentialsRequired(statusCode)
                    }
                    guard let json = try? JSONSerialization.jsonObject(with: result.data) as? [String: AnyObject] else {
                        throw NetworkError.notJSONObject(statusCode: statusCode)
                    }
                    if let message = json["message"] as? String {
                        throw NetworkError.statusCode(code: statusCode, message: message)
                    }
                    throw NetworkError.statusCode(code: statusCode)
                }
                guard !result.data.isEmpty else {
                    throw ResponseError.emptyResponse
                }
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                let value = try jsonDecoder.decode(T.self, from: result.data)
                return value
            }
            .mapError { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    private func makeRequest(
        path: Path,
        accessToken: String?,
        headers: Headers?,
        parameters: Parameters = [:],
        data: Data? = nil
    ) -> NSMutableURLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = path.host
        urlComponents.path = "/\(path.version)\(path.rawValue)"
        let parameterTuples = parameters
            .map { ($0.key.rawValue, $0.value.description) }
        if path.httpMethod == .get {
            urlComponents.queryItems = makeQueryItems(
                path: path,
                parameterTuples: parameterTuples
            )
        }
        guard let url = urlComponents.url else { return nil }
        var request = NSMutableURLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10
        )
        request.httpMethod = path.httpMethod.rawValue
        setHeadersOn(request: &request, accessToken: accessToken, headers: headers, path: path)
        if path.httpMethod == .post {
            request.httpBody = data ?? makePostData(path: path, parameterTuples: parameterTuples)
        }
        return request
    }
    // MARK: - Helpers
    private func makeQueryItems(path: Path, parameterTuples: [(String, String)]) -> [URLQueryItem] {
        guard path.httpMethod != .post else { return [] }
        return parameterTuples.map { URLQueryItem(name: $0, value: $1) }
    }
    private func makePostData(path: Path, parameterTuples: [(String, String)]) -> Data? {
        guard path.httpMethod == .post else { return nil }
        let parameterTuplesStr = parameterTuples.map { "\($0.0)=\($0.1)" }
        let parametersStr = "\(parameterTuplesStr.joined(separator: "&"))"
        let postData = parametersStr.data(using: .utf8)
        return postData
    }
    private func setHeadersOn(request: inout NSMutableURLRequest, accessToken: String?, headers: Headers?, path: Path) {
        if path.httpMethod == .get {
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value.description, forHTTPHeaderField: key)
            }
        }
        for header in path.headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        guard let accessToken = accessToken else { return }
        let authorizationValue = "Bearer \(accessToken)"
        request.setValue(authorizationValue, forHTTPHeaderField: "Authorization")
    }
}

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return dateFormatter
}()
