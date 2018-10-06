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
    var musicImage = [MusicImage]()
    
    var object: [String] = []
    var feed: [String] = []
    var entry: [String] = []
    var entryIndex: [String] = []
    
    var inObject = false
    var inFeed = false
    var inEntry = false
    var inEntryIndex = false
    
    var title = ""
    var updated = ""
    var image = ""
    var imageURL : [String] = []
    
    var imageC: UIImage?
    
    var inTitle = false
    var inUpdated = false
    var inImage = false
    var inImageText = false
    var inImageURL = false
    
    //NSURL *url = [NSURL URLWithString: @escaping];
    
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
            print("Title: \(m.title), Updated: \(m.updated), ImageURL: \(m.image)")
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
        } else if elementName == "updated" {
            inUpdated = true
            updated = ""
        } else if elementName == "im:image" {
            inImageURL = true
            image = ""
            //image = attributeDict["__text"]!
            //imageURL.append(contentsOf: attributeDict["__text"]!)
            //imageURL.append(attributeDict["__text"]!
            //image = imageURL[0]
            //downloadImage(urlString: image, completion: UIImage)
            
        }
        
        //object.append(attributeDict["object"]!)
        
        /*if elementName == "object" {
            inObject = true
            object.append(attributeDict["feed"]!)
            if elementName == "feed" {
                inFeed = true
                for _ in feed {
                    feed.append(attributeDict["entry"]!)
                    if elementName == "entry" {
                        inEntry = true
                        for index in entry {
                            entry.append(attributeDict["\(index)"]!)
                            if entryIndex == ["\(index)"] {
                                inEntryIndex = true
                                entryIndex.append(attributeDict["title"]!)
                                entryIndex.append(attributeDict["updated"]!)
                                entryIndex.append(attributeDict["image"]!)
                            } else if elementName == "title" {
                                inTitle = true
                                title = ""
                            } else if elementName == "updated" {
                                inUpdated = true
                                updated = ""
                            } else if elementName == "image" {
                                inImageText = true
                                image.append(attributeDict["__text"]!)
                                if elementName == "__text" {
                                    inImageURL = true
                                }
                            }
                        }
                    }
                }
            }*/
        
        
        /*if elementName == "object" {
            inObject = true
            object.append(attributeDict["feed"]!)
        }; if elementName == "feed" {
            inFeed = true
            for _ in feed {
                feed.append(attributeDict["entry"]!)
            }
        }; if elementName == "entry" {
            inEntry = true
            for index in entry {
                entry.append(attributeDict["\(index)"]!)
                if entryIndex == ["\(index)"] {
                    inEntryIndex = true
                    entryIndex.append(attributeDict["title"]!)
                    entryIndex.append(attributeDict["updated"]!)
                    entryIndex.append(attributeDict["image"]!)
                }; if elementName == "title" {
                    inTitle = true
                    title = ""
                } else if elementName == "updated" {
                    inUpdated = true
                    updated = ""
                } else if elementName == "image" {
                    inImageText = true
                    image.append(attributeDict["__text"]!)
                    if elementName == "__text" {
                        inImageURL = true
                    };
                }
            }
        }*/
        
        /*if elementName == "feed" {
            inFeed = true
            for _ in feed {
                feed.append(attributeDict["entry"]!)
            }
        }; if elementName == "entry" {
            inEntry = true
            for index in entry {
                entry.append(attributeDict["\(index)"]!)
            }
            
        }; if entryIndex == ["\(index)"] {
            inEntryIndex = true
            entryIndex.append(attributeDict["title"]!)
            entryIndex.append(attributeDict["updated"]!)
            entryIndex.append(attributeDict["image"]!)
        }; if elementName == "title" {
            inTitle = true
            title = ""
        }; if elementName == "updated" {
            inUpdated = true
            updated = ""
        }; if elementName == "image" {
            inImageText = true
            image.append(attributeDict["__text"]!)
            if elementName == "__text" {
                inImageURL = true
            };
        }*/
        
        /*if entryIndex == ["\(index)"] {
         inEntryIndex = true
         entryIndex.append(attributeDict["title"]!)
         entryIndex.append(attributeDict["updated"]!)
         entryIndex.append(attributeDict["image"]!)
         } else if elementName == "title" {
         inTitle = true
         title = ""
         } else if elementName == "updated" {
         inUpdated = true
         updated = ""
         } else if elementName == "image" {
         inImageText = true
         image.append(attributeDict["__text"]!)
         };if elementName == "__text" {
         inImageURL = true
         //music
         //image.append(contentsOf: image)
         
         }*/
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("Found characters: \(string)")
        /*if inObject {
            object = object + [string]
        } else if inFeed {
            feed = feed + [string]
        } else if inEntry {
            entry = entry + [string]
        } else if inEntryIndex {
            entryIndex = entryIndex + [string]
        } else*/ if inTitle {
            title = title + string
        } else if inUpdated {
            updated = updated + string
        } else if inImageText {
            image = image + string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("End of element: \(elementName)")
        
        //let imageURL: String?
        //let musicImage = MusicImage.init(__text: imageURL!)
        //let image: UIImage
        
        //downloadImage(urlString: elementName, completion: image)
        
        if elementName == "title" {
            inTitle = false
            
        } else if elementName == "updated" {
            inUpdated = false
            
        }
        
        //var imageURL: String?
        //let musicImage = MusicImage.init(__text: imageURL)!
        //var image = MusicImage(title: title, updated: updated, image: MusicImage (__text: musicImage))
        
        /*if elementName == "title" {
            music.append(MusicTop(title: title, updated: updated, image: musicImage))
        } else if elementName == "updated" {
            inTitle = false
         } */else if elementName == "im:image" {
            inImageURL = false
            music.append(MusicTop(title: title, updated: updated, image: MusicImage (__text: image) ))
            //[UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:mydata.imglink]]];
        } /*else if elementName == "age" {
            inAge = false
            age = Int(ageString) ?? 0
        }*/
        
        /*if elementName == "object" {
            inObject = true
            music.append(MusicTop(title: title, updated: updated, image: MusicImage(__text: image)))
            if elementName == "feed" {
                inObject = false
                inFeed = true
                if elementName == "entry" {
                    inFeed = false
                    inEntry = true
                    for index in entry {
                        entry.append(index)
                        if entryIndex == ["\(index)"] {
                            inEntry = false
                            inEntryIndex = true
                            if elementName == "title" {
                                inEntryIndex = false
                                inTitle = true
                            } else if elementName == "updated" {
                                inEntryIndex = false
                                inUpdated = true
                            } else if elementName == "image" {
                                inEntryIndex = false
                                inImage = true
                                if elementName == "__text" {
                                    inImageText = true
                                }
                            }
                        }
                    }
                }
            }
        }*/
        
        /*if elementName == "object" {
            inObject = true
            music.append(MusicTop(title: title, updated: updated, image: MusicImage(__text: image)))
        }; if elementName == "feed" {
            inObject = false
        }; if elementName == "entry" {
            inFeed = false
        };for index in entry {
            entry.append(index)
        }; if entryIndex == ["\(index)"] {
            inEntry = false
        } else if elementName == "title" {
            inEntryIndex = false
        } else if elementName == "updated" {
            inTitle = false
        }; if elementName == "image" {
            inUpdated = false
        } else if elementName == "__text" {
            inImageText = false
            //inImageURL = true
        }*/
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("XML parse error: " + parseError.localizedDescription)
    }
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print("XML parse error: " + validationError.localizedDescription)
    }

    //let imageCache = NSCache<AnyObject, AnyObject>()
    let imageCache = NSCache<NSString, UIImage>()
    
    // Gets an image. Arguments are the image URL as a string, and
    // a closure to execute if the image is successfully obtained.
    func downloadImages(initWithContentsOfURL: String, options: UIImage?)
    {
        
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
    /*
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
    }*/
    
}

extension UIImageView {
    func downloadImage(urlString: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
    
        guard let imageURL = URL(string: urlString) else {
            // Perform some error handling
            print("Invalid URL string")
            //mode(UIImage(named: "default.png"))
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
}

