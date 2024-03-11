//
//  RestMethod.swift
//  EclipseTimer
//
//  Created by CHOIJUNHYUK on 3/11/24.
//

import Foundation

class RestMethodManager {
    private var restMethods = ["화면 터치", "음량 조절", "음악 일시정지"]
    
    func getRestMethods() -> [String] {
        return self.restMethods
    }
}
