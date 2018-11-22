//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Carlos on 11/21/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell
{
 
    
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet?
    {
        didSet
        {
            nameLabel.text = tweet?.user?.name
            userNameLabel.text = "@\((tweet?.user?.screenName)!)"
            dateLabel.text = tweet?.createdAtString
            tweetLabel.text = tweet?.text
            replyCountLabel.text = "0"
            retweetCountLabel.text = "\((tweet?.retweetCount)!)"
            favoriteCountLabel.text = "\((tweet?.favoriteCount)!)"
            profilePicImageView.af_setImage(withURL: (tweet?.user?.profilePicture)!)
        }
        
    }
    //Classmates helped me wit the favoriting and retweeting part of this project code snippets came from them
    func performTweetAction(_ action: APIManager.TweetAction) {
        APIManager.shared.performTweetAction(tweet!, action) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text!)")
            }
        }
    }
    
    
    //Classmates helped me out with favoriting and retweeting part.  They provided me with this snippet as well as the snippet in the APIManager class
    @IBAction func didTapFavorite(_ sender: Any)
    {
        if tweet?.favorited == true
        {
            tweet?.favorited = false
            tweet?.favoriteCount! -= 1
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
            performTweetAction(APIManager.TweetAction.unfavorite)
        }
        else
        {
            tweet?.favorited = true
            tweet?.favoriteCount! += 1
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            performTweetAction(APIManager.TweetAction.favorite)
        }
        favoriteCountLabel.text = "\((tweet?.favoriteCount)!)"
    }
    
    @IBAction func didTapRetweet(_ sender: Any)
    {
        if tweet?.retweeted == true
        {
            tweet?.retweeted = false
            tweet?.retweetCount! -= 1
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            performTweetAction(APIManager.TweetAction.unretweet)
        }
        else
        {
            tweet?.retweeted = true
            tweet?.retweetCount! += 1
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            performTweetAction(APIManager.TweetAction.retweet)
        }
        retweetCountLabel.text = "\((tweet?.retweetCount)!)"
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
