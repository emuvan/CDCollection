//
//  AddAlbumViewController.swift
//  CDcollection
//
//  Created by Van Quang Nguyen on 07/04/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import UIKit
import CoreData

class AddAlbumViewController: UIViewController {
    @IBOutlet weak var LabelArtist: UILabel!
    @IBOutlet weak var textAlbumName: UITextField!
    @IBOutlet weak var textGerne: UITextField!
    var artist:Artist?
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LabelArtist.text = self.artist?.name

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveAlbum(_ sender: UIButton) {
        
        // new album object
        let album = Album(context: context)
        album.artist = artist?.name
        album.name = textAlbumName.text
        album.genre = textGerne.text
        artist?.addToAlbums(album)
        (UIApplication.shared.delegate as!
            AppDelegate).saveContext()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
