//
//  MasterViewController.swift
//  Assignment2
//
//  Created by Joshua Aaron Flores Stavedahl on 9/26/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import UIKit
import Foundation

class MasterViewController: UITableViewController, XMLParserDelegate {
    
    var detailViewController: DetailViewController? = nil
    var musicObjects = [MusicTop]()
    var downloader = Downloader()
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        
        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        //navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        downloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = musicObjects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.downloader = downloader
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MusicCell
        
        /// Create instance of "President" type.
        let musicObject : MusicTop
        
        musicObject = musicObjects[indexPath.row]
        
        /*downloader.downloadImage(urlString: episodeObject.image.medium) {
            (image: UIImage?) in
            cell.logoImageView!.image = image
        }*/
        
        cell.titleLabel!.text = musicObject.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            musicObjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // Download JSON data, decode it, and populate table view
    func downloadData() {
        
        weak var weakSelf = self
 
        downloader.downloadData(urlString: "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/10/explicit.atom") {
            (data) in
            
            guard let dataXML = data else {
                weakSelf!.presentAlert(title: "Error", message: "Unable to download XML data")
                return
            }
            
            do {
                let parserXML = Downloader()
                parserXML.parseXMLData(data: dataXML)
                
                weakSelf!.musicObjects = parserXML.music
                
                weakSelf!.tableView.reloadData()
            } catch {
                weakSelf!.presentAlert(title: "Error", message: "Invalid XML downloaded")
            }
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
