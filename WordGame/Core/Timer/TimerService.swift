//
//  TimerService.swift
//  WordGame
//
//  Created by muhammad Yawar on 7/10/23.
//

import Foundation

protocol TimerService {
    
    func startService()
    func stopService()
    var eventInterval: Double { get set }
    var eventHandler: (() -> Void) { get }
}

public struct TimerServiceImpl: TimerService {
    var eventInterval: Double
    var eventHandler: (() -> Void)
    private let timerPublisher: Timer.TimerPublisher
    
    public init(eventInterval: Double, eventHandler: @escaping () -> Void) {
        
        self.eventInterval = eventInterval
        self.eventHandler = eventHandler
        self.timerPublisher = Timer.publish(every: self.eventInterval,
                                            on: .current, in: .common)
    }
    func startService() {
        
    }
    
    func stopService() {
    }
}
