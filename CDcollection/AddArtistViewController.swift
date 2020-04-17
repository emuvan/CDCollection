//
//  AddArtistViewController.swift
//  CDcollection
//
//  Created by Van Quang Nguyen on 24/03/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import UIKit

class AddArtistViewController: UIViewController {
    @IBOutlet weak var textArtist: UITextField!
    @IBOutlet weak var textNotes: UITextField!
    // get a handle to the context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        let newArtist = Artist(context: context)
        if self.textArtist.text != ""
        {
            newArtist.name = self.textArtist.text
            newArtist.notes = self.textNotes.text
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        else{
        //Alert
            let alert = UIAlertController(title: "Missing artist name", message:"Please enter a name",preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        }
        
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
