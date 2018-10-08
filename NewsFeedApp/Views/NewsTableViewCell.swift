//
//  NewsTableViewCell.swift
//  NewsFeedApp
//
//  Created by Muneer KK on 06/10/18.
//  Copyright © 2018 Muneer KK. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet var linkView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //set the values for top,left,bottom,right margins

        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsetsMake(0, 0, 10, 0)
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, margins)
      
       
        
    }
    func configureNewsCell(with newsObject: News?) {
        if let newsObject = newsObject {
            titleLabel.text = newsObject.title
            authorLabel.text = "\(NewsConstants.authorTitle): \(newsObject.author)"
            descriptionLabel.text = newsObject.description
            timeLabel.text = newsObject.publishedAt.getDateFromString().getElapsedInterval()
            newsImageView?.sd_setImage(with: URL(string:newsObject.urlToImage), placeholderImage:#imageLiteral(resourceName: "placeholder"))
           
            let attributedString = NSMutableAttributedString(string: NewsConstants.readMore)
            attributedString.addAttribute(.link, value: newsObject.url, range: NSRange(location: 0, length: 9))
            linkView.attributedText = attributedString
            
        } 
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
