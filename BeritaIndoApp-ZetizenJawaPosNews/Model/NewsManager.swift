//
//  NewsManager.swift
//  BeritaIndoApp-ZetizenJawaPosNews
//
//  Created by Elfana Anamta Chatya on 17/10/23.
//

import Foundation

final class NewsAPI
{
    static let shared = NewsAPI()
    
    struct Constants
    {
        static let newsURL = URL(string: "https://berita-indo-api-next.vercel.app/api/zetizen-jawapos-news/techno#")
    }
    
    private init() {}
    
    public func getNews(completion: @escaping (Result<[Datum], Error>) -> Void)
    {
        guard let url = Constants.newsURL else
        {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url)
        {   data, _, error in
            if let error = error
            {
                completion(.failure(error))
            }
            else if let data = data
            {
                do
                {
                    let result = try JSONDecoder().decode(NewsData.self, from: data)
                    print(result.data.count)
                    completion(.success(result.data))
                }
                catch
                {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    
    func dateFormatter(dateToConvert: String, completion: @escaping (String?) -> Void) {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds]
        if let date = isoDateFormatter.date(from: dateToConvert) {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
          let dateFormattedString = dateFormatter.string(from: date)
          completion(dateFormatter.string(from: date))
          print(dateFormattedString)
        } else {
          completion(nil)
          print("Unknown Date")
        }
    }
    
}


// MARK: - NewsData
struct NewsData: Codable {
    let message: String
    let total: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let creator, title: String
    let link: String
    let content: String
    let categories: [String]
    let isoDate: String
    let image: String
}



