//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var tableView: UITableView!
    var tweets = [Tweet]()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        // Initialize a UIRefreshControl
        //let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        fetchTweets()
    }

    @IBAction func onLogoutButton(_ sender: Any)
    {
        APIManager.shared.logout()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tweets.count
    }
    
    func fetchTweets()
    {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets
            {
                self.tweets = tweets
                self.tableView.reloadData()
                if self.refreshControl.isRefreshing
                {
                    self.refreshControl.endRefreshing()
                }
            }
            else if let error = error
            {
                print(error.localizedDescription)
            }
        }
    }
    
    /*@objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        fetchTweets()
    }*/
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    //Friend helped me with this snippet
    func refreshControlAction(_ refreshControl: UIRefreshControl)
    {
        refreshControl.beginRefreshing()
        fetchTweets()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "tweetDetailSegue"
        {
            let cell = sender as! TweetCell
            let destination = segue.destination as! DetailViewController
            let indexPath = tableView.indexPath(for: cell)!
            destination.tweet = tweets[indexPath.row]
            cell.setSelected(false, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
