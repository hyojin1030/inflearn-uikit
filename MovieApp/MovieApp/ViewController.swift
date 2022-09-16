//
//  ViewController.swift
//  MovieApp
//
//  Created by 주효진 on 2022/09/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    
    var movieModel: MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchBar.delegate = self
        
        requestMovieAPI()
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        if let hasURL = URL(string: urlString) {
            var reqeust = URLRequest(url: hasURL)
            reqeust.httpMethod = "GET"
            
            session.dataTask(with: reqeust) { data, response, error in
                print((response as! HTTPURLResponse).statusCode)
                
                if let hasData = data {
                    completion(UIImage(data: hasData))
                    return
                }
            }
        }
        
        completion(nil)
    }
    
    //network
    func requestMovieAPI() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        var components = URLComponents(string: "https://itunes.apple.com/search")
        let term = URLQueryItem(name: "term", value: "marvel")
        let media = URLQueryItem(name: "media", value: "movie")
        
        components?.queryItems = [term, media]
        
        guard let url = components?.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            print((response as! HTTPURLResponse).statusCode)
            
            if let hasData = data {
                do {
                    self.movieModel = try JSONDecoder().decode(MovieModel.self, from: hasData)
                    print(self.movieModel ?? "no data")
                    
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
            

        }
        
        task.resume()
        session.finishTasksAndInvalidate()
        
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieModel?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.titleLabel.text = self.movieModel?.results[indexPath.row].trackName
        cell.descriptionLabel.text = self.movieModel?.results[indexPath.row].shortDescription ?? ""
        
        let currency = self.movieModel?.results[indexPath.row].currency ?? ""
        let price = self.movieModel?.results[indexPath.row].trackPrice?.description ?? ""
        cell.priceLabel.text = currency + price
        
        
        if let hasUrl = self.movieModel?.results[indexPath.row].image {
            loadImage(urlString: hasUrl) { image in
                cell.movieImageView.image = image
            }

        }

        
        
        return cell
    }
    
    
}


extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}


