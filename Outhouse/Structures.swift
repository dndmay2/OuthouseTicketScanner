//
//  Structures.swift
//  Outhouse
//
//  Created by Derek May on 8/21/16.
//  Copyright © 2016 Derek May. All rights reserved.
//

import Foundation


class UpcomingEvent {
    
    fileprivate(set) var eventId: String!
    fileprivate(set) var eventName: String!
    fileprivate(set) var eventDate: String!
    
    init(id: String, name: String, date: String) {
        self.eventId = "\(id)"
        self.eventName = "\(name)"
        self.eventDate = "\(date)"
    }
    
}

struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0 // Use this line in Xcode 7 or newer
    }
    
}

