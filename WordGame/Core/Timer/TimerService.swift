//
//  TimerService.swift
//  WordGame
//
//  Created by muhammad Yawar on 7/10/23.
//

import Foundation
import Combine

protocol TimerService {
        
    func stopService()
    var eventInterval: Double { get set }
}

public struct TimerServiceImpl: TimerService {
    var eventInterval: Double
    private var timerCancellable: Cancellable?
    
    
    public init(eventInterval: Double, eventHandler: @escaping (Date) -> Void) {
        
        self.eventInterval = eventInterval
        self.timerCancellable = Timer.publish(every: eventInterval,
                                              on: .main,
                                              in: .common)
        .autoconnect()
        .sink(receiveValue: eventHandler)
    }
    func stopService() {
        
        self.timerCancellable?.cancel()
    }
}
