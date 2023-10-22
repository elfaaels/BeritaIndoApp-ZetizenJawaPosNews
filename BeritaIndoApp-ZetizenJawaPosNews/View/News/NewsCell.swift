//
//  NewsCell.swift
//  BeritaIndoApp-ZetizenJawaPosNews
//
//  Created by Elfana Anamta Chatya on 18/10/23.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        newsImage.layer.cornerRadius = 4
        newsImage.layer.masksToBounds = true
    }

}
