//
//  ArtistDetailViewController.swift
//  CDcollection
//
//  Created by Van Quang Nguyen on 31/03/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    @IBOutlet weak var LabelArtist: UILabel!
    @IBOutlet weak var textViewArtistNotes: UITextView!
    var textNotes = ""
    var artistName = ""
    var artist:Artist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LabelArtist.text = artistName
        textViewArtistNotes.text = textNotes

        // Do any additional setup after loading the view.
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
