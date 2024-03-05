//
//  TimeRange.swift
//  EclipseTimer
//
//  Created by CHOIJUNHYUK on 3/4/24.
//

import Foundation

class TimeRangeManager {
    private var minutes: [Int] = []
    private var seconds: [Int] = []
    
    func setTimeRange() {
        self.setMinutes()
        self.setSeconds()
    }
    
    private  func setMinutes() {
        for m in 0...60 {
            self.minutes.append(m)
        }
    }
    
    private  func setSeconds() {
        for s in 0...59 {
            self.seconds.append(s)
        }
    }
    
    func getMinutes() -> [Int] {
        return self.minutes
    }
    
    func getSeconds() -> [Int] {
        return self.seconds
    }
}
