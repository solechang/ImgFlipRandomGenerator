//
//  ImgFlipViewController.swift
//  ImgFlipRandomGenerator
//
//  Created by Chang Choi on 11/17/16.
//  Copyright © 2016 solechang. All rights reserved.
//

import UIKit

class ImgFlipViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var generatedImageView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
     var memes: [Meme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.activityIndicator.hidesWhenStopped = true
        self.userTextField.delegate = self
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    


    @IBAction func submitButtonPressed(_ sender: AnyObject) {
        
         self.getRandomMeme()
        
    }
    
    func getRandomMeme () {
        self.submitButton.isEnabled = false
        self.activityIndicator.startAnimating()
        
        let request: BaseRequest = RandomGenerateMemeRequest()
        
        request.completionBlock = {
            (response, error) in
            
            if (error != nil) {
                // Error Logs
                print(error!.localizedDescription)

            } else {
                if let json = response {
                    self.memes = [] // reiniatlize array
                    
                    let values =     json["data"]["memes"].arrayValue
                    
                    for value in values {
                        let meme = Meme()
                        meme.id = value["id"].stringValue
                        meme.name = value["name"].stringValue
                        meme.height = value["height"].stringValue
                        meme.width = value["width"].stringValue
                        
                        self.memes.append(meme)
                        
                    }
                 
                }
            }
            
            self.chooseRandomMeme()

            }
            request.runRequest()
        }
    
    
    func chooseRandomMeme() {
        
        let diceRoll = Int(arc4random_uniform(    UInt32(self.memes.count)) + 1)
        
        let meme = self.memes[diceRoll]
        
        getRandomMemeImage(meme: meme)
      
    }
    
    func getRandomMemeImage (meme:Meme ) {

        // NOTE**** I WOULD NEVER HARDCODE USERNAME OR PASSWORD. For this exercise I have, but I would rather ask user to login in different view.
        let username :String = "solechang"
        let password :String = "imgflip2"
        
        let request: BaseRequest = CaptionImageRequest(template_id: meme.id, username: username, password: password, text0: self.userTextField.text!, text1:self.userTextField.text!)
        
        request.completionBlock = {
            (response, error) in
            
            if (error != nil) {
                // Error Logs
                print("3.0) ", error!.localizedDescription)
                
            } else {
                if let json = response {
                    
                    let imageurl :String = json["data"]["page_url"].stringValue
                   print("4.0) ", imageurl)
                    let url = URL(string: imageurl)
                    
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        DispatchQueue.main.async {
                            self.generatedImageView.image = UIImage(data: data!)
                        }
                    }
                    
                    print( "3.1) " , imageurl)
                }
            }
            
        self.submitButton.isEnabled = true
        self.activityIndicator.stopAnimating()

            
        }
        request.runRequest()
    }
    
  
    
}





