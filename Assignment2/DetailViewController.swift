//
//  DetailViewController.swift
//  Assignment2
//
//  Created by Joshua Aaron Flores Stavedahl on 9/26/18.
//  Copyright © 2018 Northern Illinois University. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var summaryWebView: WKWebView!
    
    var downloader: Downloader?
    
    func configureView() {
        
        // let imageURL = musicImage?.__text
        // Update the user interface for the detail item.
        
        if let detail = detailItem {
            if let image = imageItem {
                if let imageView = self.imageView {
                    //downloader.downloadImage(urlString: image.__text) {
                      //  (image: UIImage?) in
                        //imageView.image = image
                    //}
                }
            }
            
            if let webView = summaryWebView {
                let htmlString = "<html><head><meta name=\"viewport\" content=\"initial-scale=1.0\" /><style>body { font-family: -apple-system;font-size:12pt }</style></head><body>" + detail.updated + "</body></html>"
                webView.loadHTMLString(htmlString, baseURL: nil)
            }
            if let label = titleLabel {
                label.text = detail.title
            }
            if let label = airDateLabel {
                label.text = detail.updated
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let imageV = UIImageView(frame: CGRect(x: 90, y: 200, width: 200, height: 200))
        imageV.layer.borderWidth = 5
        imageV.layer.borderColor = UIColor.red.cgColor
        //imageV.downloadImage(link: , contentMode: .scaleAspectFill)
        self.view.addSubview(imageV)
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var detailItem: MusicTop? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    var imageItem: MusicImage? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
}


