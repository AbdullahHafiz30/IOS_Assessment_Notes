//
//  TimeService.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 01/08/2025.
//

import Foundation

struct TimeService {
    enum ServiceError: Error { case badHTTP(Int), badDate }

    func current() async throws -> Date {
        let ip = try await publicIPv4()
        let url = URL(string: "https://timeapi.io/api/Time/current/ip")!
            .appending(queryItems: [URLQueryItem(name: "ipAddress", value: ip)])

        return try await fetchAndDecode(url: url)
    }

    private func publicIPv4() async throws -> String {
        struct IPDTO: Decodable { let ip: String }
        let (data, _) = try await URLSession.shared.data(
            from: URL(string: "https://api.ipify.org?format=json")!)
        return try JSONDecoder().decode(IPDTO.self, from: data).ip
    }

    private func fetchAndDecode(url: URL) async throws -> Date {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200
        else { throw ServiceError.badHTTP((response as? HTTPURLResponse)?.statusCode ?? -1) }

        let dto = try JSONDecoder().decode(CurrentTimeDTO.self, from: data)
        guard let date = dto.asDate else { throw ServiceError.badDate }
        return date
    }
}

private struct CurrentTimeDTO: Decodable {
    let year, month, day, hour, minute, seconds, milliSeconds: Int

    var asDate: Date? {
        var comps = DateComponents()
        comps.calendar = Calendar(identifier: .gregorian)
        comps.timeZone = TimeZone.current
        comps.year        = year
        comps.month       = month
        comps.day         = day
        comps.hour        = hour
        comps.minute      = minute
        comps.second      = seconds
        comps.nanosecond  = milliSeconds * 1_000_000
        return comps.date
    }
}

private extension URL {
    func appending(queryItems: [URLQueryItem]) -> URL {
        var comps = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        comps.queryItems = (comps.queryItems ?? []) + queryItems
        return comps.url!
    }
}


