//
//  Downloader.swift
//  Assignment2
//
//  Created by Joshua Aaron Flores Stavedahl on 9/26/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import Foundation
import UIKit

class Downloader: NSObject, XMLParserDelegate{
    
    var music = [MusicTop]()
    
    var object: [String] = []
    var feed: [String] = []
    var entry: [String] = []
    var entryIndex: [String] = []
    
    var inObject = false
    var inFeed = false
    var inEntry = false
    var inEntryIndex = false
    var inTitle = false
    var inReleaseDate = false
    var inImageURL = false
    
    var title = ""
    var releaseDate = ""
    var imageURL = ""
    
    func parseXMLData(data: Data) {
        let parser = XMLParser(data: data)
        parser.delegate = self
        if (!parser.parse()) {
            print("Error: XML data not parsed")
        } else {
            printMusic()
        }
    }
    
    func printMusic() {
        for m in music {
            print("Title: \(m.title), Release Date: \(m.releaseDate), Image URL: \(m.image)")
        }
    }
    
    // XMLParserDelegate methods
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("Start of element: \(elementName)")
        
        if elementName == "object" {
            inObject = true
            object.append(attributeDict["feed"]!)
        } else if elementName == "feed" {
            inFeed = true
            for _ in feed {
                feed.append(attributeDict["entry"]!)
            }
        } else if elementName == "entry" {
            inEntry = true
            for index in entry {
                entry.append(attributeDict["\(index)"]!)
            }
        } else if entryIndex == ["\(index)"] {
            inEntryIndex = true
            entryIndex.append(attributeDict["title"]!)
        } else if elementName == "title" {
            inTitle = true
            title = ""
        } else if elementName == "im:releaseDate" {
            inReleaseDate = true
            releaseDate = ""
        } else if elementName == "im:image" {
            inImageURL = true
            imageURL = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("Found characters: \(string)")
        if inTitle {
            title = title + string
        } else if inImageURL {
            imageURL = imageURL + string
        } else if inReleaseDate {
            releaseDate = releaseDate + string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("End of element: \(elementName)")
        
        if elementName == "title" {
            inTitle = false
        } else if elementName == "im:image" {
            inImageURL = false
        } else if elementName == "im:releaseDate" {
            inReleaseDate = false
            music.append(MusicTop(title: title, releaseDate: releaseDate, image: imageURL))
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("XML parse error: " + parseError.localizedDescription)
    }
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print("XML parse error: " + validationError.localizedDescription)
    }
    
    func downloadData(urlString: String, completion: @escaping (_ data: Data?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            // Perform some error handling
            print("Invalid URL string")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            let httpResponse = response as? HTTPURLResponse
            
            if httpResponse!.statusCode != 200 {
                // Perform some error handling
                DispatchQueue.main.async {
                    print("HTTP Error: status code \(httpResponse!.statusCode).")
                    completion(nil)
                }
            } else if (data == nil && error != nil) {
                // Perform some error handling
                DispatchQueue.main.async {
                    print("No data downloaded for \(urlString).")
                    completion(nil)
                }
            } else {
                // Download succeeded, attempt to decode JSON
                DispatchQueue.main.async {
                    print("Success")
                    completion(data)
                }
            }
        }
        task.resume()
    }
    
    let imageCache = NSCache<NSString, UIImage>()
    
    // Gets an image. Arguments are the image URL as a string, and
    // a closure to execute if the image is successfully obtained.
    func downloadImage(urlString: String, completion: @escaping (_ image: UIImage?) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cachedImage)
        } else {
            guard let url = URL(string: urlString) else {
                // Perform some error handling
                print("Invalid URL string")
                completion(UIImage(named: "default.png"))
                return
            }
            
            // Otherwise, try to download the image from the provided URL
            weak var weakSelf = self
            
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                
                let httpResponse = response as? HTTPURLResponse
                
                if httpResponse!.statusCode != 200 {
                    // Perform some error handling
                    DispatchQueue.main.async {
                        print("HTTP Error: status code \(httpResponse!.statusCode).")
                        completion(UIImage(named: "default.png"))
                    }
                } else if (data == nil && error != nil) {
                    // Perform some error handling
                    DispatchQueue.main.async {
                        print("No image data downloaded for \(urlString).")
                        completion(UIImage(named: "default.png"))
                    }
                } else {
                    // Download succeeded, attempt to decode image
                    if let image = UIImage(data: data!) {
                        DispatchQueue.main.async {
                            print("Success")
                            weakSelf!.imageCache.setObject(image, forKey: urlString as NSString)
                            completion(image)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
