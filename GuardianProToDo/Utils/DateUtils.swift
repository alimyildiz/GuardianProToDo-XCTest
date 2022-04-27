//
//  DateUtils.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit

class DateUtils: NSObject {

    public static var instance: DateUtils = DateUtils()
    
    func convertStringToDate(dateString:String) -> Date {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from:dateString)!
    }
    
    /// Returns the amount of hours from another date
     func calculateHours(from date: Date) -> Int {
         return Calendar.current.dateComponents([.hour], from: date, to: self.convertStringToDate(dateString: self.getCurrentDate())).hour ?? 0
     }
    
    func getCurrentDate() -> String {
          let date = Date()
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
          return formatter.string(from: date)
      }

}
