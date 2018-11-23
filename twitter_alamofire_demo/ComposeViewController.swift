//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Carlos on 11/22/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate
{
    
    @IBOutlet weak var TweetTextView: UITextView!
    @IBOutlet weak var charCountLabel: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        TweetTextView.delegate = self
        charCountLabel.text = "0"
        // Do any additional setup after loading the view.
    }
    
    //Classmate helped me out on compose post code
    @IBAction func didTapPost(_ sender: Any)
    {
        let tweet = TweetTextView.text
        
        APIManager.shared.getCurrentAccount { (user, error) in
            if let user = user
            {
                APIManager.shared.composeNewTweet(tweet!, user, APIManager.TweetAction.composeNew, completion:
                    { (user, error) in
                        if user != nil
                    {
                        print("Compose Tweet Success!")
                    }
                })
            }
        }
        performSegue(withIdentifier: "backHome", sender: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        let characterLimit = 140
        let newText = NSString(string: TweetTextView.text!).replacingCharacters(in: range, with: text)
        charCountLabel.text = "\(newText.count)"
        return newText.count < characterLimit
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
