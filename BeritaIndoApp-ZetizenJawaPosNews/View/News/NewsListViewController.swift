//
//  NewsListViewController.swift
//  BeritaIndoApp-ZetizenJawaPosNews
//
//  Created by Elfana Anamta Chatya on 18/10/23.
//

import UIKit
import Kingfisher


class NewsListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    
    var newsData: [NewsData] = []
    var data: [Datum] = []
    let inDateFormatter = ISO8601DateFormatter()


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchNews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setup() {
    title = "ZetizenJawaPos"
    tableView.delegate = self
    tableView.dataSource = self
        
    }
    
    let outDateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy"
            df.locale = Locale(identifier: "en_US_POSIX")
            return df
        }()
    

    private func fetchNews() {
        NewsAPI.shared.getNews
        {  [weak self] (result) in
            switch result
            {
            case .success(let news):
                self?.data = news
                DispatchQueue.main.async
                {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UIImageView{
  func imageFrom(url:URL){
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url){
        if let image = UIImage(data:data){
          DispatchQueue.main.async{
            self?.image = image
          }
        }
      }
    }
  }
}


extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = self.data[indexPath.row]
        
        
        let storyboard = UIStoryboard(name: "NewsItem", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewsItemViewController") as! NewsItemViewController
        viewController.data = news
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom_news_cell", for: indexPath) as! NewsCell
        let news = self.data[indexPath.row]
        
//        let isoDate = "2023-06-14T09:29:26.000Z"
//        let isoDateFormatter = ISO8601DateFormatter()
//        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//        isoDateFormatter.formatOptions = [
//            .withFullDate,
//            .withFullTime,
//            .withDashSeparatorInDate,
//            .withFractionalSeconds]
//        if let date = isoDateFormatter.date(from: isoDate) {
//          let dateFormatter = DateFormatter()
//          dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
//          let dateFormattedString = dateFormatter.string(from: date)
//            cell.newsDate.text = dateFormattedString
//          print(dateFormattedString)
//        } else {
//            cell.newsDate.text = news.isoDate
//          print("Unknown Date")
//        }

        NewsAPI.shared.dateFormatter(dateToConvert: news.isoDate) { newDate in
            cell.newsDate.text = newDate
        }
        
        cell.newsTitle.text = news.title
        cell.newsAuthor.text = news.creator
        cell.newsImage.kf.setImage(with: URL(string: news.image))

        
        return cell
    }
    
    
}
