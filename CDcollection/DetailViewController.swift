//
//  DetailViewController.swift
//  CDcollection
//
//  Created by Van Quang Nguyen on 24/03/2020.
//  Copyright © 2020 Van Quang Nguyen. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController,
    UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate
{
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    let cellColour:UIColor = UIColor(red:0.0 , green: 1.0, blue: 0.0, alpha: 0.1)
    let cellSelColour:UIColor = UIColor(red:0.0 , green: 1.0, blue: 0.0, alpha: 0.2)
    override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view.
       // tableView.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
          configureView()
      }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        let sectionInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for:
                indexPath)
            //configure the cell here
            self.configureCell(cell,indexPath: indexPath)
            let backgroundView = UIView()
            backgroundView.backgroundColor = cellSelColour
            cell.selectedBackgroundView = backgroundView
            return cell
    }
    
    //configure the cell here
    func configureCell(_ cell: UITableViewCell, indexPath: IndexPath){
        let title = self.fetchedResultsController.fetchedObjects?[indexPath.row].name
        cell.textLabel?.text = title
        cell.backgroundColor = cellColour
        if let gerneText = self.fetchedResultsController.fetchedObjects?[indexPath.row].genre
        {
            cell.detailTextLabel?.text = gerneText
            
        }
        else{
            cell.detailTextLabel?.text = ""
            
        }
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = artist {
            if let label = detailDescriptionLabel {
                label.text = detail.name
            }
        }
    }
    
    var artist: Artist? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
    
    // MARK: - Fetched results controller
    var _fetchedResultsController: NSFetchedResultsController<Album>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<Album> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        let currentArtist = self.artist
        let fetchRequest: NSFetchRequest<Album> = Album.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true, selector:
            #selector(NSString.localizedStandardCompare(_:)))
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if(self.artist != nil)
        {
            let predicate = NSPredicate(format: "recordArtist = %@", currentArtist!)
            fetchRequest.predicate = predicate
        
            
            
        }
      //  else{
            
         //   let predicate = NSPredicate(format: "Artist","Lady Gaga")
           // fetchRequest.predicate = predicate
            
            
            
     //   }
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController<Album>(
            fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: #keyPath(Album.artist),
        cacheName: nil)
        
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             // Replace this implementation with code to handle the error appropriately.
             // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // <#code#>
        
        if let identifier = segue.identifier {
            switch identifier
            {
            case "artistDetail":
                let destCD = segue.destination as! ArtistDetailViewController
                //set artits name
                if let name = self.artist?.name
                {
                    destCD.artistName = name
                }
                else
                {
                    destCD.artistName = "Artist"
                }
                if let notes = self.artist?.notes
                {
                    destCD.textNotes = notes
                }
                else
                {
                    destCD.textNotes = "notes..."
                }
            default:
            break
            }
        }
        if segue.identifier == "addAlbum"
        {
            let object = self.artist
            let controller = segue.destination as! AddAlbumViewController
            controller.artist = object
            
        }
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
          switch type {
              case .insert:
                  tableView.insertRows(at: [newIndexPath!], with: .fade)
              case .delete:
                  tableView.deleteRows(at: [indexPath!], with: .fade)
              case .update:
                  configureCell(tableView.cellForRow(at: indexPath!)!, indexPath: newIndexPath!)
              case .move:
                self.configureCell(tableView.cellForRow(at: indexPath!)!, indexPath: newIndexPath!)
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
              default:
                  return
          }
      }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))
                
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
     func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}

