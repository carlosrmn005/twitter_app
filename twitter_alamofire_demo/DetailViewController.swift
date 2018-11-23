//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Carlos on 11/22/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController, UITextViewDelegate
{
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var wordCountLabel: UILabel!
    
    var tweet: Tweet!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        profilePicImageView.af_setImage(withURL: (tweet.user?.profilePicture)!)
        nameLabel.text = tweet.user?.name
        dateLabel.text = tweet.createdAtString
        retweetCountLabel.text = "\((tweet?.retweetCount)!)"
        replyCountLabel.text = "0"
        userNameLabel.text = "@\((tweet?.user?.screenName)!)"
        favoriteCountLabel.text = "\((tweet?.favoriteCount)!)"
        tweetLabel.text = tweet.text
        replyTextView.delegate = self
        
        replyButton.setImage(UIImage(named: "reply-icon"), for: .normal)
        
        if tweet.retweeted == true
        {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
        else
        {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
        
        favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        if tweet.favorited == true
        {
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }
        else
        {
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
        // Do any additional setup after loading the view.
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
    
    func performTweetAction(_ action: APIManager.TweetAction) {
        APIManager.shared.performTweetAction(tweet!, action) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print(error.localizedDescription)
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text!)")
            }
        }
    }
    
    //Had help with the composing of new tweets
    @IBAction func onTapReply(_ sender: Any)
    {
        let text = "\((tweet.user?.screenName)!) \((replyTextView.text)!)"
        APIManager.shared.composeTweet(text, tweet, APIManager.TweetAction.reply)
        { (tweet, error) in
            if let error = error
            {
                print(error.localizedDescription)
            }
            else if tweet != nil
            {
                self.performSegue(withIdentifier: "backHome", sender: nil)
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        wordCountLabel.text = "\(newText.count)"
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
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
