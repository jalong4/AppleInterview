//
//  ViewController.swift
//  AppleInterview
//
//  Created by Jim Long on 12/21/17.
//  Copyright © 2017 Jim Long. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    
    var videos: [Video]?
    let cellId = "cellId"
    let cellSpacing: CGFloat = 2.0
    let layout = UICollectionViewFlowLayout()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Apple Interview Problem"
        view.backgroundColor = .white
        collectionView?.backgroundColor = .clear
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchFeed()
        
    }
    
    fileprivate func fetchFeed() {
        
        //  This is meant to simulate the API call for the feed.  See sample feed.json file for a look at the response I mocked up
        
        if let path = Bundle.main.path(forResource: "feed", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String:String]] {  // API returns an Array of Dictionary key/value pairs.  All values are strings
                    videos = [Video]()
                    for json in jsonResult {
                        videos?.append(Video(json: json))
                    }
                    
                    self.collectionView?.reloadData()
                }
            } catch {
            }
        }
    }
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 280)
    }
}

