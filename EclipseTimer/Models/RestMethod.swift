//
//  RestMethod.swift
//  EclipseTimer
//
//  Created by CHOIJUNHYUK on 3/11/24.
//

import Foundation

class RestMethodManager {
    private var restMethods = [String(localized: "Touch Screen"), String(localized: "Control Volume"), String(localized: "Pause Music")]
    
    func getRestMethods() -> [String] {
        return self.restMethods
    }
}
