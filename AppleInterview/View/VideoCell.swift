//
//  VideoCell.swift
//  AppleInterview
//
//  Created by Jim Long on 12/21/17.
//  Copyright © 2017 Jim Long. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {

    var video: Video? {
        didSet {
            guard let video = video  else { return }
            self.title.text = video.title
            self.provider.text = "Provider: \(video.provider.rawValue)"
            video.getImage { (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var title: UILabel = {
        let label = UILabel()
        return label;
    }()
    
    var provider: UILabel = {
        let label = UILabel()
        return label;
    }()
    
    func sharedInit() {
        addSubview(imageView)
        addSubview(title)
        addSubview(provider)
        addSubview(separator)
        
        
        

        imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 12).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: bounds.width - 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        //  anchor is an extension I defined in Extensions.swift
        separator.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: bounds.width - 24, height: 1)
        
        title.anchor(top: nil, left: leftAnchor, bottom: separator.topAnchor, right: nil, paddingTop: 4, paddingLeft: 12, paddingBottom: 12, paddingRight: 0, width: 0, height: 0)
        
        provider.anchor(top: nil, left: nil, bottom: separator.topAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 12, paddingRight: 12, width: 0, height: 0)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
}


