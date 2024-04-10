import Foundation

struct Request: Decodable {
    let area: String
    let date: Date
}

struct Response: Codable, Equatable {
    let weatherCondition: String
    let maxTemperature: Int
    let minTemperature: Int
    let date: Date
}

enum WeatherCondition: String, CaseIterable {
    case sunny
    case cloudy
    case rainy
}

public enum YumemiWeatherError: Swift.Error {
    case invalidParameterError
    case unknownError
}

final public class YumemiWeather {

    static let apiDuration: TimeInterval = 2

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter
    }()

    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()

    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }()

    /// 引数の値でResponse構造体を作成する。引数がnilの場合はランダムに値を作成する。
    /// - Parameters:
    ///   - weatherCondition: 天気状況を表すenum
    ///   - maxTemperature: 最高気温
    ///   - minTemperature: 最低気温
    ///   - date: 日付
    ///   - seed: シード値
    /// - Returns: Response構造体

    static func makeRandomResponse(weatherCondition: WeatherCondition? = nil, maxTemperature: Int? = nil, minTemperature: Int? = nil, date: Date? = nil, seed: Int? = nil) -> Response {
        return makeRandomResponse(weatherCondition: weatherCondition, maxTemperature: maxTemperature, minTemperature: minTemperature, date: date, seed: seed ?? Int.random(in: Int.min...Int.max))
    }

    private static func makeRandomResponse(weatherCondition: WeatherCondition?, maxTemperature: Int?, minTemperature: Int?, date: Date?, seed seedValue: Int) -> Response {
        var generator = SeedRandomNumberGenerator(seed: seedValue)
        let weatherCondition = weatherCondition ?? WeatherCondition.allCases.randomElement(using: &generator)!
        let maxTemperature = maxTemperature ?? Int.random(in: 10...40, using: &generator)
        let minTemperature = minTemperature ?? Int.random(in: -40..<maxTemperature, using: &generator)
        let date = date ?? Date()

        return Response(
            weatherCondition: weatherCondition.rawValue,
            maxTemperature: maxTemperature,
            minTemperature: minTemperature,
            date: date
        )
    }

    /// 擬似 天気予報 API Simple ver
    /// - Returns: 天気状況を表す文字列 "sunny" or "cloudy" or "rainy"
    public static func fetchWeatherCondition() -> String {
        return self.makeRandomResponse().weatherCondition
    }

    /// 擬似 天気予報 API Throws ver
    /// - Throws: YumemiWeatherError
    /// - Parameters:
    ///   - area: 天気予報を取得する対象地域 example: "tokyo"
    /// - Returns: 天気状況を表す文字列 "sunny" or "cloudy" or "rainy"
    public static func fetchWeatherCondition(at area: String) throws -> String {
        if Int.random(in: 0...4) == 4 {
            throw YumemiWeatherError.unknownError
        }

        return self.makeRandomResponse().weatherCondition
    }

    /// 擬似 天気予報 API JSON ver
    ///
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "area": "tokyo",
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    ///
    /// 返された天気 JSON 文字列の例：
    ///
    ///     {
    ///         "max_temperature":25,
    ///         "date":"2020-04-01T12:00:00+09:00",
    ///         "min_temperature":7,
    ///         "weather_condition":"cloudy"
    ///     }
    ///
    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameter jsonString: 地域と日付を含む JSON 文字列
    /// - Returns: Weather レスポンスの JSON 文字列
    public static func fetchWeather(_ jsonString: String) throws -> String {
        guard let requestData = jsonString.data(using: .utf8),
              let request = try? decoder.decode(Request.self, from: requestData) else {
            throw YumemiWeatherError.invalidParameterError
        }

        let response = makeRandomResponse(date: request.date)
        let responseData = try encoder.encode(response)

        if Int.random(in: 0...4) == 4 {
            throw YumemiWeatherError.unknownError
        }

        return String(data: responseData, encoding: .utf8)!
    }

    /// 擬似 天気予報 API Sync ver
    ///
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "area": "tokyo",
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    ///
    /// 返された天気 JSON 文字列の例：
    ///
    ///     {
    ///         "max_temperature":25,
    ///         "date":"2020-04-01T12:00:00+09:00",
    ///         "min_temperature":7,
    ///         "weather_condition":"cloudy"
    ///     }
    ///
    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameter jsonString: 地域と日付を含む JSON 文字列
    /// - Returns: Weather レスポンスの JSON 文字列
    public static func syncFetchWeather(_ jsonString: String) throws -> String {
        Thread.sleep(forTimeInterval: apiDuration)
        return try self.fetchWeather(jsonString)
    }


    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameter jsonString: 地域と日付を含む JSON 文字列
    /// - Returns: Weather レスポンスの JSON 文字列
    
    /// 擬似 天気予報 API Callback ver
    ///
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "area": "tokyo",
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    ///
    /// 成功に返された天気 Result の中に JSON 文字列の例：
    ///
    ///     {
    ///         "max_temperature":25,
    ///         "date":"2020-04-01T12:00:00+09:00",
    ///         "min_temperature":7,
    ///         "weather_condition":"cloudy"
    ///     }
    ///
    /// また、YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameters:
    ///   - jsonString: 地域と日付を含む JSON 文字列
    ///   - completion: 完了コールバック
    public static func callbackFetchWeather(_ jsonString: String, completion: @escaping (Result<String, YumemiWeatherError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + apiDuration) {
            do {
                let response = try fetchWeather(jsonString)
                completion(Result.success(response))
            }
            catch let error where error is YumemiWeatherError {
                completion(Result.failure(error as! YumemiWeatherError))
            }
            catch {
                fatalError()
            }
        }
    }

    /// 擬似 天気予報 API Async ver
    ///
    /// API に請求する JSON 文字列の例：
    ///
    ///     {
    ///         "area": "tokyo",
    ///         "date": "2020-04-01T12:00:00+09:00"
    ///     }
    ///
    /// 返された天気 JSON 文字列の例：
    ///
    ///     {
    ///         "max_temperature":25,
    ///         "date":"2020-04-01T12:00:00+09:00",
    ///         "min_temperature":7,
    ///         "weather_condition":"cloudy"
    ///     }
    ///
    /// - Throws: YumemiWeatherError パラメータが正常でもランダムにエラーが発生する
    /// - Parameter jsonString: 地域と日付を含む JSON 文字列
    /// - Returns: Weather レスポンスの JSON 文字列
    @available(iOS 13, macOS 10.15, *)
    public static func asyncFetchWeather(_ jsonString: String) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            callbackFetchWeather(jsonString) { result in
                continuation.resume(with: result)
            }
        }
    }
}
