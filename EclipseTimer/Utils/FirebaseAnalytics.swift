//
//  FirebaseAnalytics.swift
//  EclipseTimer
//
//  Created by CHOIJUNHYUK on 4/8/24.
//

import FirebaseAnalytics

func setAnalytics(_ title: String) {
    Analytics.logEvent(title, parameters: nil)
}
