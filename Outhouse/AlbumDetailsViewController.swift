//
//  AlbumDetailsViewController.swift
//  Outhouse
//
//  Created by Derek May on 8/21/16.
//  Copyright © 2016 Derek May. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {

    @IBOutlet weak var artistAlbumLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistAlbumLabel.text = "Let's scan a ticket!"
        yearLabel.text = ""
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(setLabels(_:)), name: "AlbumNotification", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func setLabels(notification: NSNotification){
        
        // Use the data from DataService.swift to initialize the Album.
        let albumInfo = Album(artistAlbum: DataService.dataService.ALBUM_FROM_DISCOGS, albumYear: DataService.dataService.YEAR_FROM_DISCOGS)
        artistAlbumLabel.text = "\(albumInfo.album)"
        yearLabel.text = "\(albumInfo.year)"
    }

}
