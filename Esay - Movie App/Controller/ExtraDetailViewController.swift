//
//  VideoViewController.swift
//  Esay - Movie App
//
//  Created by admin on 1.02.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit
import Moya

class ExtraDetailViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet var tableView: UITableView!
    var review = [Review]()
    var movie: Movie!
    var video = [Video]()
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getReviews()
        getVideo()
    }
    
}
//MARK: - Review and Video Request Part
extension ExtraDetailViewController {
    func getReviews() {
        networkManager.fetchReviews(movieID: self.movie.id ?? 399566) { reviews in
            self.review = reviews
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func getVideo() {
        networkManager.fetchVideo(movieID: self.movie.id ?? 399566) { videos in
            self.video = videos
            guard let url = URL(string: "https://www.youtube.com/watch?v=\(self.video.first!.key)") else {
                return
            }
            DispatchQueue.main.async {
                self.webView.loadRequest(URLRequest(url: url))

            }
        }
    }
}
//MARK: - TableView Part
extension ExtraDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableViewCell
        cell.configureReviews(model: review[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
