//
//  DateFormatter.swift
//  Bouncr
//
//  Created by Kenny Hu on 5/1/22.
//

import Foundation

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
      //formatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
static let iso8601FullOutgoing: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
      //formatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
      formatter.calendar = Calendar(identifier: .iso8601)
      formatter.timeZone = TimeZone(secondsFromGMT: 0)
      formatter.locale = Locale(identifier: "en_US_POSIX")
      return formatter
    }()
}
