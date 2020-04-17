//
//  EditArtistViewController.swift
//  CDcollection
//
//  Created by Van Quang Nguyen on 31/03/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import UIKit
import CoreData

class EditArtistViewController: UIViewController {
    var currentArtist:Artist?
    @IBOutlet weak var textArtistName: UITextField!
    
    @IBOutlet weak var textArtistNotes: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textArtistName.text = self.currentArtist?.name
        textArtistNotes.text = self.currentArtist?.notes
    }
    
    @IBAction func updateArtist(_ sender: UIButton) {
        //update artist detail
        currentArtist?.name = textArtistName.text
        currentArtist?.notes = textArtistNotes.text
        //save the update
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
