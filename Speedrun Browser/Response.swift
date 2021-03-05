// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let echo = try Echo(json)

//
// To read values from URLs:
//
//   let task = URLSession.shared.echoTask(with: url) { echo, response, error in
//     if let echo = echo {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Echo
struct Echo: Codable {
    let args: Args
    let headers: Headers
    let origin: String
    let url: String
}

// MARK: Echo convenience initializers and mutators

extension Echo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Echo.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        args: Args? = nil,
        headers: Headers? = nil,
        origin: String? = nil,
        url: String? = nil
    ) -> Echo {
        return Echo(
            args: args ?? self.args,
            headers: headers ?? self.headers,
            origin: origin ?? self.origin,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.argsTask(with: url) { args, response, error in
//     if let args = args {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Args
struct Args: Codable {
    let text: String
}

// MARK: Args convenience initializers and mutators

extension Args {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Args.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        text: String? = nil
    ) -> Args {
        return Args(
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.headersTask(with: url) { headers, response, error in
//     if let headers = headers {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Headers
struct Headers: Codable {
    let accept, acceptEncoding, acceptLanguage, host: String
    let userAgent, xAmznTraceID: String

    enum CodingKeys: String, CodingKey {
        case accept
        case acceptEncoding
        case acceptLanguage
        case host
        case userAgent
        case xAmznTraceID
    }
}

// MARK: Headers convenience initializers and mutators

extension Headers {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Headers.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        accept: String? = nil,
        acceptEncoding: String? = nil,
        acceptLanguage: String? = nil,
        host: String? = nil,
        userAgent: String? = nil,
        xAmznTraceID: String? = nil
    ) -> Headers {
        return Headers(
            accept: accept ?? self.accept,
            acceptEncoding: acceptEncoding ?? self.acceptEncoding,
            acceptLanguage: acceptLanguage ?? self.acceptLanguage,
            host: host ?? self.host,
            userAgent: userAgent ?? self.userAgent,
            xAmznTraceID: xAmznTraceID ?? self.xAmznTraceID
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func echoTask(with url: URL, completionHandler: @escaping (Echo?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
