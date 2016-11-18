# ImgFlipRandomGenerator
README:
In this exercise, I have created a random meme generator with ImgFlip’s API via Swift 3.0. The view consists of 2 textfields, top and bottom texts, that needs to be filled before generating a meme. If user does not fill all the textfields, an alert will pop up prompting them to do so.

In addition, the user will have to press the “Submit” button to generate the meme. An activity indicator will popup to show that an meme is randomly being generated, and has completely loaded the meme image.

I have insured that when the “Submit” button is pressed, the user cannot spam it and call to the ImgFlip API multiple times at once. This is done by disabling the “Submit” button when first pressed and then enabling again when the meme image is completely generated and loaded.

As for the meme’s image, it is autoscaled on the screen depending on the size of the image. I have made sure to make the meme fit in other iPhone sizes through AutoLayout. Check out the Main.storyboard to see the AutoLayout constraints I have made.

This project uses a BaseRequest via Alamofire which connects to ImgFlip’s API. As for specific endpoints, I have created 2 other requests that inherits BaseRequest. RandomGenerateMemeRequest is utilized to get the top 100 memes so that I can choose one meme randomly. CaptionImageRequest generates the meme image with the random meme I have chosen, and with the user’s entered top and bottom texts.

Also, I have created a Meme object to extract the top 100 memes for modeling.

NOTE* I WOULD NEVER HARDCODE USERNAME OR PASSWORD. For this exercise purposes, but I would rather ask user to login to get crendentials and store in keychain (depending on functionality)

Cocoapods used:
- Alamofire
- SwiftyJSON
