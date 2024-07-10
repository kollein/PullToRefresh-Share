//
//  Logger.swift
//  PullToRefresh
//
//  Created by Vinh on 21/06/2024.
//

import Foundation

class Logger {
    private var id: String = ""
    private var section: String = ""
    private var isHideIdentifiers: Bool = false
    
    init(id: String, section: String, isHideIdentifiers: Bool = false) {
        self.id = id
        self.section = section
        self.isHideIdentifiers = isHideIdentifiers
    }
    
    func log(message: String, data: Any? = "|") -> Void {
        if isHideIdentifiers {
            if data as! String == "|" {
                print(message)
                return
            }
            print(message, "data:", data as Any)
            return
        }

        if data as! String == "|" {
            print("ID: " + self.id, "SE: " + self.section, "message: " + message)
            return
        }
        print("ID: " + self.id, "SE: " + self.section, "message: " + message, "data:", data as Any)
    }
}
