//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Carlos on 11/22/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController
{
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetNumberLabel: UILabel!
    @IBOutlet weak var followerNumberLabel: UILabel!
    @IBOutlet weak var followingNumberLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        APIManager.shared.getCurrentAccount{ (user, error) in
            if let user = user
            {
                self.profilePicImageView.af_setImage(withURL: user.profilePicture!)
                self.nameLabel.text = user.name
                self.userNameLabel.text = user.screenName
                self.tweetNumberLabel.text = "Number of Tweets: \(user.statuses_count!)"
                self.followerNumberLabel.text = "Number of Followers: \(user.followers_count!)"
                self.followingNumberLabel.text = "Number of Followings: \(user.friends_count!)"
                self.tagLineLabel.text = user.description
            }
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapLogout(_ sender: Any)
    {
        APIManager.shared.logout()
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
