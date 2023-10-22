//
//  NewsItemViewController.swift
//  BeritaIndoApp-ZetizenJawaPosNews
//
//  Created by Elfana Anamta Chatya on 20/10/23.
//

import UIKit
import Kingfisher

class NewsItemViewController: UIViewController {
    
    var data: Datum!


    @IBOutlet weak var dataNewsImage: UIImageView!
    @IBOutlet weak var dataNewsAuthor: UILabel!
    @IBOutlet weak var dataNewsTItle: UILabel!
    @IBOutlet weak var dataNewsDescription: UILabel!
    @IBOutlet weak var dataNewsDate: UILabel!
    @IBOutlet weak var dataNewsCategory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    @IBAction func selengkapnyaButton(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: data.link)! as URL)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setup() {
        NewsAPI.shared.dateFormatter(dateToConvert: data.isoDate) { newDate in
            self.dataNewsDate.text = "Published at: \(newDate ?? "Unknown Date")"
        }
        
        dataNewsImage.kf.setImage(with: URL(string: data.image))
        dataNewsAuthor.text = "Author: \(data.creator)"
        dataNewsTItle.text = data.title
        dataNewsDescription.text = data.content
        dataNewsCategory.text = "Category: \( data.categories.first ?? "")"
    }

}
