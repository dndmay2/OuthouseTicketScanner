//
//  Album.swift
//  Outhouse
//
//  Created by Derek May on 8/21/16.
//  Copyright © 2016 Derek May. All rights reserved.
//

import Foundation


class EventTickets {
    
    private(set) var ticketsScanned: String!
    private(set) var totalTickets: String!
    
    init(numTicketsScanned: String, numTotalTickets: String) {
        
        // Add a little extra text to the album information
        self.ticketsScanned = "\(numTicketsScanned)"
        self.totalTickets = "\(numTotalTickets)"
    }
    
}

struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0 // Use this line in Xcode 7 or newer
    }
    
}

