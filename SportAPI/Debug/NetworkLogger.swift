import Foundation

enum NetworkLogger {
    static func log(request: URLRequest) {
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlAbsoluteString = request.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlAbsoluteString)
        let method = request.httpMethod ?? ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        var logOutput =
            """
            \(urlAbsoluteString)
            \(method) \(path)?\(query) HTTP/1.1
            HOST: \(host)
            """
        logOutput += "\nHEADERS:\n"
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        logOutput += "HTTP BODY:"
        if let body = request.httpBody, let bodyStr = String(data: body, encoding: .utf8) {
            logOutput += "\n \(bodyStr)"
        }
        print(logOutput)
    }
    static func log(response: URLResponse, data: Data) {
        print("RESPONSE:")
        if let httpURLResponse = response as? HTTPURLResponse {
            print(httpURLResponse.statusCode)
        }
        guard
            let json = try? JSONSerialization.jsonObject(
                with: data, options: []) as? [String: Any] else { return print("Empty response JSON") }
        print("RESPONSE JSON")
        print(json)
    }
}
