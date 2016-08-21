//
//  Album.swift
//  Outhouse
//
//  Created by Derek May on 8/21/16.
//  Copyright © 2016 Derek May. All rights reserved.
//

import Foundation

class Album {
    
    private(set) var album: String!
    private(set) var year: String!
    
    init(artistAlbum: String, albumYear: String) {
        
        // Add a little extra text to the album information
        self.album = "Album: \n\(artistAlbum)"
        self.year = "Released in: \(albumYear)"
    }
    
}