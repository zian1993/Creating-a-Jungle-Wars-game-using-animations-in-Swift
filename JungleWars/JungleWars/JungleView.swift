//
//  JungleView.swift
//  JungleWars
//
//  Created by Hassan Khan on 12/2/18.
//  Copyright © 2018 Hassan Khan. All rights reserved.
//

import UIKit
import AVFoundation

class JungleView: UIView {
    
    @IBOutlet private var title : UIImageView?
    @IBOutlet private var warzone : UIImageView?
    @IBOutlet private var lion : UIImageView?
    @IBOutlet private var rabbit : UIImageView?
    @IBOutlet private var cobra : UIImageView?
    @IBOutlet private var randanimal : UIImageView?
    
    private var lionarray : [UIImage]
    
    @IBOutlet private var textdude : UILabel?
    @IBOutlet private var score1 : UILabel?
    @IBOutlet private var score2 : UILabel?
    @IBOutlet private var playerscore : UILabel?
    @IBOutlet private var pcscore : UILabel?
    
    private var playerint : Int
    private var pcint : Int
    
    private var liontouch : Bool
    private var rabbittouch : Bool
    private var cobratouch : Bool
    
    private var pcliontouch : Bool
    private var pcrabbittouch : Bool
    private var pccobratouch : Bool

    private var lionhome : CGRect
    private var rabbithome : CGRect
    private var cobrahome : CGRect
    
    private var gameplay : Bool
    
    

    
    override func  awakeFromNib()
    {
        //Setting the background color
        self.backgroundColor = UIColor.gray
        
      //Initializing and setting up the imageviews
        imageMaker()
        
        //Animating the title
        titleMover()
    }
    
    //Initializing variables.
    required init?(coder aDecoder: NSCoder)
    {
        liontouch = false
        rabbittouch = false
        cobratouch = false
        
        pcliontouch = false
        pcrabbittouch = false
        pccobratouch = false
        
        gameplay = false
        
        lionhome = CGRect()
        rabbithome = CGRect()
        cobrahome = CGRect()
        
        playerint = 0
        pcint = 0
        
        //Setting up my lion animation array.
        lionarray = [UIImage]()
        lionarray.append(UIImage(named: "lion0.png")!)
        lionarray.append(UIImage(named: "lion1.png")!)
        lionarray.append(UIImage(named: "lion2.png")!)
        lionarray.append(UIImage(named: "lion3.png")!)
    
        super.init(coder: aDecoder)
    }
    
    func imageMaker()
    {
        //Initializing all the image views with frame sizes.
        
        title = UIImageView(frame: CGRect(x: CGFloat(self.frame.size.width/4), y: CGFloat(self.frame.origin.y/8), width: CGFloat(self.frame.width/2), height: CGFloat(self.frame.height/8)))
        
        warzone = UIImageView(frame: CGRect(x: CGFloat(self.frame.origin.x + 5), y: CGFloat(self.frame.height/5), width: CGFloat(self.frame.width*(2/3)), height: CGFloat(self.frame.height*(2/3))))
        
        lion = UIImageView(frame: CGRect(x: CGFloat((warzone?.frame.origin.x)! + (warzone?.frame.width)! + 10), y: CGFloat((warzone?.frame.origin.y)! + (warzone?.frame.height)!*(0.5/8)), width: CGFloat(self.frame.width*(1/5)), height: CGFloat((warzone?.frame.height)!*(1/4))))
        
        rabbit = UIImageView(frame: CGRect(x: CGFloat((warzone?.frame.origin.x)! + (warzone?.frame.width)! + 10), y: CGFloat((warzone?.frame.origin.y)! + (warzone?.frame.height)!*(3/8)), width: CGFloat(self.frame.width*(1/5)), height: CGFloat((warzone?.frame.height)!*(1/4))))
        
        cobra = UIImageView(frame: CGRect(x: CGFloat((warzone?.frame.origin.x)! + (warzone?.frame.width)! + 10), y: CGFloat((warzone?.frame.origin.y)! + (warzone?.frame.height)!*(6/8)), width: CGFloat(self.frame.width*(1/5)), height: CGFloat((warzone?.frame.height)!*(1/4))))
        
        //Setting up each image
        title?.image = UIImage(named: "title.png")
        warzone?.image = UIImage(named: "jungleframe.jpg")
        lion?.image = UIImage(named: "lion0.png")
        rabbit?.image = UIImage(named: "rabbit.png")
        cobra?.image = UIImage(named: "cobra.png")
        
        //Turn the rabbit around before putting it on screen.
        rabbit?.image = UIImage(cgImage: (rabbit?.image?.cgImage)!, scale: 1.0, orientation: UIImageOrientation.upMirrored)
        
        //Saving the original frames of the animals, so that we can switch back to them
        //if the user lets go of them in any odd places.
        lionhome = (lion?.frame)!
        rabbithome = (rabbit?.frame)!
        cobrahome = (cobra?.frame)!
        
        //Adding all the images to the view.
        self.addSubview(title!)
        self.addSubview(warzone!)
        self.addSubview(lion!)
        self.addSubview(rabbit!)
        self.addSubview(cobra!)
    }
    
    func titleAway(animationId: String?)
    {
        //Time to make the title go away again.
        UIView.beginAnimations("Fade", context: nil)
        UIView.setAnimationDuration(4.0)
        UIView.setAnimationDelegate(self)
        //UIView.setAnimationDidStop( #selector(finishedAnimation(animationId:)))
        //UIView.setAnimationRepeatCount(3.0)
        UIView.setAnimationRepeatAutoreverses(false) //Re
        
        
        //Add properties to change
        title?.alpha = 0.0
        
        //Start the animation
        UIView.commitAnimations();
        
        //Now its time to make the title fade out, and then display the labels.
        labelMaker()
 
    }
    
    func labelMaker()
    {
        //Lets make the labels and add them to the view here too.
        textdude = UILabel(frame: CGRect(x: CGFloat(2), y: (warzone?.frame.origin.y)!+(warzone?.frame.height)!+20, width: CGFloat(400), height: CGFloat(20)))
        score1 = UILabel(frame: CGRect(x: CGFloat(2), y: CGFloat(self.frame.origin.y/8)+(title?.frame.height)!+15, width: CGFloat(150), height: CGFloat(20)))
        score2 = UILabel(frame: CGRect(x: CGFloat(2), y: CGFloat(self.frame.origin.y/8)+(title?.frame.height)!+30, width: CGFloat(150), height: CGFloat(20)))
        playerscore = UILabel(frame: CGRect(x: CGFloat((score1?.frame.origin.x)! + (score1?.frame.width)!)+10, y: CGFloat(self.frame.origin.y/8)+(title?.frame.height)!+15, width: CGFloat(20), height: CGFloat(20)))
        pcscore = UILabel(frame: CGRect(x: CGFloat((score2?.frame.origin.x)! + (score2?.frame.width)!)+10, y: CGFloat(self.frame.origin.y/8)+(title?.frame.height)!+30, width: CGFloat(20), height: CGFloat(20)))
        
        self.addSubview(textdude!)
        self.addSubview(score1!)
        self.addSubview(score2!)
        self.addSubview(playerscore!)
        self.addSubview(pcscore!)
        
        textdude?.text = "Welcome User! Lets go to war!"
        score1?.text = "Player Score: "
        score2?.text = "Phone Score: "
        
        updateScore()
    }
    
    func updateScore()
    {
        playerscore!.text = String(playerint);
        pcscore!.text = String(pcint);
    }
    
    //War function.
    func itBegins(animationId: String?)
    {
        //Game Rules:
        //1. Lion defeats rabbit (lion can catch rabbit)
        //2. Cobra defeats lion (cobra can bite lion)
        //3. Rabbit defeats cobra (rabbit can outrun cobra)
        
        //Setting up some variables.
        var userchoice = UIImageView()
        var userhome = frame
        var winner = UIImageView()
        var string1 = String()
        var string2 = String()
        
        //Setting up the user choice
        if (liontouch)
        {
            userchoice = lion!
            userhome = lionhome
        }
        else if (rabbittouch)
        {
            userchoice = rabbit!
            userhome = rabbithome
        }
        else
        {
            userchoice = cobra!
            userhome = cobrahome
        }
        
        //If the user input and the random animal are the same
        if ((liontouch&&pcliontouch)||(rabbittouch&&pcrabbittouch)||(cobratouch&&pccobratouch))
        {
            //Set Winner
            winner = UIImageView()
            string1 = "Tie"
            string2 = "!"
        }
        
        if ((liontouch)&&(pcrabbittouch))
        {
            //Set Winner
            winner = userchoice
            string1 = "You Win! "
            string2 = "Lion defeats rabbit!"
        }
        if ((rabbittouch)&&(pcliontouch))
        {
            //Set Winner
            winner = randanimal!
            string1 = "You Lose! "
            string2 = "Lion defeats rabbit!"
        }
        
        if ((cobratouch)&&(pcliontouch))
        {
            //Set Winner
            winner = userchoice
            string1 = "You Win! "
            string2 = "Cobra defeats lion!"
        }
        if ((liontouch)&&(pccobratouch))
        {
            //Set Winner
            winner = randanimal!
            string1 = "You Lose! "
            string2 = "Cobra defeats lion!"
        }
        
        if ((rabbittouch)&&(pccobratouch))
        {
            //Set Winner
            winner = userchoice
            string1 = "You Win! "
            string2 = "Rabbit defeats cobra!"

        }
        if ((cobratouch)&&(pcrabbittouch))
        {
            //Set Winner
            winner = randanimal!
            string1 = "You Lose! "
            string2 = "Rabbit defeats cobra!"
        }

         //Building the game scenarios.
        //If pc is the winner
        if (winner == randanimal)
        {
            let randframe = randanimal?.frame
            
            //Setting up animation to move the pc over to the user's side.
            UIView.beginAnimations("Move", context: nil)
            UIView.setAnimationDuration(3.5)
            UIView.setAnimationDelegate(self)
           // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
            
            //Add propety changes here
            //Move to top
            randanimal?.frame = userchoice.frame
            UIView.commitAnimations()
            
            //Setting up animation to fade user.
            //Add initial conditions here
            userchoice.alpha = 1.0
            
            UIView.beginAnimations("Fade", context: nil)
            UIView.setAnimationDuration(3.5)
            UIView.setAnimationDelegate(self)
            //UIView.setAnimationDidStop( #selector(finishedAnimation(animationId:)))
            
            //Add properties to change here
            userchoice.alpha = 0.0
            UIView.commitAnimations()
            
            //Moving the pc animal back to its place and fading it
            
            //Setting up animation to move the pc over to the user's side.
            UIView.beginAnimations("Move", context: nil)
            UIView.setAnimationDuration(3.5)
            UIView.setAnimationDelay(2.0)
            UIView.setAnimationDelegate(self)
            // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
            
            //Add propety changes here
            //Move to top
            randanimal?.frame = randframe!
            UIView.commitAnimations()
            
            //Setting up animation to move the pc over to the user's side.
            UIView.beginAnimations("Fade", context: nil)
            UIView.setAnimationDuration(3.5)
            UIView.setAnimationDelay(2.0)
            UIView.setAnimationDelegate(self)
            // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
            
            //Add propety changes here
            //Move to top
            randanimal?.alpha = 0.0
            UIView.commitAnimations()
            
            //Moving the user back to their home turf
            
            //Setting up animation to move the pc over to the user's side.
            UIView.beginAnimations("Fade", context: nil)
            UIView.setAnimationDuration(3.5)
            UIView.setAnimationDelay(2.0)
            UIView.setAnimationDelegate(self)
            // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
            
            //Add propety changes here
            //Move to top
            userchoice.alpha = 1.0
            UIView.commitAnimations()
            
            //Setting up animation to move the pc over to the user's side.
            UIView.beginAnimations("Move", context: nil)
            UIView.setAnimationDuration(3.5)
            UIView.setAnimationDelay(2.0)
            UIView.setAnimationDelegate(self)
            // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
            
            //Add propety changes here
            //Move to top
            userchoice.frame = userhome
            UIView.commitAnimations()
            
            //Update Scores.
            pcint = pcint+1
            updateScore()
        }
            
        //Else if player is the winner
        else if (winner == userchoice)
        {
            //Setting up animation to move the user over to the pc side.
            UIView.beginAnimations("Move", context: nil)
            UIView.setAnimationDuration(3.5)
            UIView.setAnimationDelegate(self)
            // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
            
            //Add propety changes here
            //Move to top
            userchoice.frame=(randanimal?.frame)!
            UIView.commitAnimations()
            
            //Setting up animation to fade pc.
            //Add initial conditions here
            randanimal?.alpha = 1.0
            
            UIView.beginAnimations("Fade", context: nil)
            UIView.setAnimationDuration(3.5)
            UIView.setAnimationDelegate(self)
            //UIView.setAnimationDidStop( #selector(finishedAnimation(animationId:)))
            
            //Add properties to change here
            randanimal?.alpha = 0.0
            UIView.commitAnimations()
            
            //Moving the user animal back to its home place and fading pc
            
            //Setting up animation to move the pc over to the user's side.
            UIView.beginAnimations("Move", context: nil)
            UIView.setAnimationDuration(3.5)
            UIView.setAnimationDelay(2.0)
            UIView.setAnimationDelegate(self)
            // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
            
            //Add propety changes here
            //Move to top
            userchoice.frame = userhome
            UIView.commitAnimations()
            
            //Setting up animation to fade pc
            UIView.beginAnimations("Fade", context: nil)
            UIView.setAnimationDuration(3.5)
            UIView.setAnimationDelay(2.0)
            UIView.setAnimationDelegate(self)
            // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
            
            //Add propety changes here
            //Move to top
            randanimal?.alpha = 0.0
            UIView.commitAnimations()
            
            //Update Scores.
            playerint = playerint+1
            updateScore()
        }
        
        //Else if its a draw
        else
        {
            randanimal?.alpha = 1.0
            userchoice.alpha = 1.0

            //Fading out both the player and the pc
            //Setting up animation to fade pc
            UIView.beginAnimations("Fade", context: nil)
            UIView.setAnimationDuration(3.5)
            //UIView.setAnimationDelay(2.0)
            UIView.setAnimationDelegate(self)
            // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
            
            //Add propety changes here
            //Move to top
            randanimal?.alpha = 0.0
            userchoice.alpha = 0.0
            UIView.commitAnimations()
            
            //Moving the user back home and fading them back in.
            
            UIView.beginAnimations("Move", context: nil)
            UIView.setAnimationDuration(3.5)
            UIView.setAnimationDelay(2.0)
            UIView.setAnimationDelegate(self)
            // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
            
            //Add propety changes here
            //Move to top
            userchoice.frame = userhome
            UIView.commitAnimations()
            
            //Setting up animation to fade pc
            UIView.beginAnimations("Fade", context: nil)
            UIView.setAnimationDuration(3.5)
            UIView.setAnimationDelay(2.0)
            UIView.setAnimationDelegate(self)
            // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
            
            //Add propety changes here
            //Move to top
            userchoice.alpha = 1.0
            UIView.commitAnimations()

        }
        
        
        
        
        
        //Finishing game
        //Set all the touches to false before exitting out of game.
        liontouch = false;
        cobratouch = false;
        rabbittouch = false;
        pcliontouch = false;
        pccobratouch = false;
        pcrabbittouch = false;
        gameplay = false;
        
        //Update the text.
        textdude?.text = string1 + string2;
        textdude?.alpha = 0.0
        fadeText()
    }
    
    func fadeText()
    {
        textdude?.alpha = 0.0
        //Setting up animation to fade pc
        UIView.beginAnimations("Fade", context: nil)
        UIView.setAnimationDuration(3.5)
        UIView.setAnimationDelay(2.0)
        UIView.setAnimationDelegate(self)
        // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
        
        //Add propety changes here
        //Move to top
        textdude?.alpha = 1.0
        UIView.commitAnimations()
        
        
        textdude?.alpha = 1.0
        //Setting up animation to fade pc
        UIView.beginAnimations("Fade", context: nil)
        UIView.setAnimationDuration(3.5)
        UIView.setAnimationDelay(4.0)
        UIView.setAnimationDelegate(self)
        // UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
        
        //Add propety changes here
        //Move to top
        textdude?.alpha = 0.0
        UIView.commitAnimations()
    }
    
    
    func titleMover()
    {
        //Creating the zoom animation for the title.
        //Add initial conditions here
        let frame = title?.frame
        
        let x = (frame?.origin.x)! + (frame?.size.width)!/2.0
        let y = (frame?.origin.y)! + (frame?.size.height)!/2.0
        
        let x_new = x-(frame!.width/2)*0.1
        let y_new = y-(frame!.height/2)*0.1
        
        title?.frame = CGRect(x: x_new , y: y_new, width: (frame?.width)!*0.1, height: (frame?.height)!*0.1)

        
        UIView.beginAnimations("Zoom", context: nil)
        UIView.setAnimationDuration(6.5)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop( #selector(titleAway(animationId:)))
        //UIView.setAnimationRepeatCount(3.0)
        UIView.setAnimationRepeatAutoreverses(false) //Re
        
        
        //Add properties to change
        title?.frame = CGRect(x: frame!.origin.x, y: frame!.origin.y, width: frame!.size.width, height: frame!.size.height)
        
        //Start the animation
        UIView.commitAnimations();
        
    }
    
    func startWar(animationId: String?)
    {
        if (gameplay)
        {
            //Randomly selecting an animal to play against the user.
            let animalchooser = arc4random_uniform(3);
            
            if (animalchooser == 0)
            {
                //If random number 0, choose lion
                pcliontouch = true
                
                randanimal = UIImageView(frame: CGRect(x: (warzone?.frame.origin.x)!+(1/5)*(warzone?.frame.width)!, y: (warzone?.frame.origin.y)!+(1/2)*(warzone?.frame.height)!, width: CGFloat(self.frame.width*(1/5)), height: CGFloat((warzone?.frame.height)!*(1/4))))
                
                //Set up image and frame.
                randanimal?.image = UIImage(named: "lion0.png")
                
                //Turn the animal around before putting it on screen.
                randanimal?.image = UIImage(cgImage: (randanimal?.image?.cgImage)!, scale: 1.0, orientation: UIImageOrientation.upMirrored)

                //Set up animation so that the image fades in
                //Add initial conditions here
                
                //Set the alpha of the image to zero
                randanimal?.alpha = 0.0
                
                UIView.beginAnimations("Fade", context: nil)
                UIView.setAnimationDuration(2.5)
                UIView.setAnimationDelegate(self)
                UIView.setAnimationDidStop( #selector(itBegins(animationId:)))
                
                //Add properties to change here
                randanimal?.alpha = 1.0
                
                UIView.commitAnimations()
            }
            
            if (animalchooser == 1)
            {
                
                //If random number 1, choose rabbit
                pcrabbittouch = true
                
                randanimal = UIImageView(frame: CGRect(x: (warzone?.frame.origin.x)!+(1/5)*(warzone?.frame.width)!, y: (warzone?.frame.origin.y)!+(1/2)*(warzone?.frame.height)!, width: CGFloat(self.frame.width*(1/5)), height: CGFloat((warzone?.frame.height)!*(1/4))))

                randanimal?.image = UIImage(named: "rabbit.png")
                
                //Dont need to turn this one around!
                
                //Set up animation so that the image fades in
                //Add initial conditions here
                
                //Set the alpha of the image to zero
                randanimal?.alpha = 0.0
                
                UIView.beginAnimations("Fade", context: nil)
                UIView.setAnimationDuration(2.5)
                UIView.setAnimationDelegate(self)
                UIView.setAnimationDidStop( #selector(itBegins(animationId:)))
                
                //Add properties to change here
                randanimal?.alpha = 1.0
                
                UIView.commitAnimations()
            }
            
            if (animalchooser == 2)
            {
                
                //If random number 2, choose cobra
                pccobratouch = true
                
                randanimal = UIImageView(frame: CGRect(x: (warzone?.frame.origin.x)!+(1/5)*(warzone?.frame.width)!, y: (warzone?.frame.origin.y)!+(1/2)*(warzone?.frame.height)!, width: CGFloat(self.frame.width*(1/5)), height: CGFloat((warzone?.frame.height)!*(1/4))))
              
                randanimal?.image = UIImage(named: "cobra.png")
                
                //Turn the animal around before putting it on screen.
                randanimal?.image = UIImage(cgImage: (randanimal?.image?.cgImage)!, scale: 1.0, orientation: UIImageOrientation.upMirrored)
                
                //Set up animation so that the image fades in
                //Add initial conditions here
                
                //Set the alpha of the image to zero
                randanimal?.alpha = 0.0
                
                UIView.beginAnimations("Fade", context: nil)
                UIView.setAnimationDuration(2.5)
                UIView.setAnimationDelegate(self)
                UIView.setAnimationDidStop( #selector(itBegins(animationId:)))
                
                //Add properties to change here
                randanimal?.alpha = 1.0
                
                UIView.commitAnimations()
            }
            
            //Add to view
            self.addSubview(randanimal!)
        }
    }
    
    
    //Implementing the touch functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //Getting the touch object out of the array
        let all_touches = Array(touches)
        let finger = all_touches[0] as! UITouch
        
        //Checking what on earth the user touched.
        if (lion?.frame.contains(finger.location(in: self)))!
        {
            liontouch = true
            print ("lion touched!")
            
            //Starting lion animation here.
            lionAnimate()
            
            //Playing the lion roar sound on tap!
            lionRoar()
        }
        
        if (rabbit?.frame.contains(finger.location(in: self)))!
        {
            rabbittouch = true
            print ("rabbit touched!")
        }
        
        if (cobra?.frame.contains(finger.location(in: self)))!
        {
            cobratouch = true
            print ("cobra touched!")
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //Getting the finger object out of the array
        let all_touches = Array(touches)
        let finger = all_touches[0] as! UITouch
        
        if (liontouch)
        {
            //Moving the lion with the touch of the finger, assuming the first
            //object in the array is the right finger.
            
            //Calculating the offset
            //let offset = CGPoint(x: finger.location(in: self).x-(lion?.frame.origin.x)!, y: finger.location(in: self).y-(lion?.frame.origin.y)!)
            
            //Move the lion with the touch of the finger.
            lion?.frame = CGRect(x: finger.location(in: self).x, y: finger.location(in: self).y, width:(lion?.frame.size.width)!, height:(lion?.frame.size.height)!);
        
        }
        
        else if (cobratouch)
        {
            //Calculating the offset
            //let offset = CGPoint(x: finger.location(in: self).x-(lion?.frame.origin.x)!, y: finger.location(in: self).y-(lion?.frame.origin.y)!)
            
            //Move the cobra with the touch of the finger.
            cobra?.frame = CGRect(x: finger.location(in: self).x, y: finger.location(in: self).y, width:(lion?.frame.size.width)!, height:(lion?.frame.size.height)!);
            
        }
        
        else if (rabbittouch)
        {
            
            //Calculating the offset
            //let offset = CGPoint(x: finger.location(in: self).x-(lion?.frame.origin.x)!, y: finger.location(in: self).y-(lion?.frame.origin.y)!)
            
            //Move the rabbit with the touch of the finger.
            rabbit?.frame = CGRect(x: finger.location(in: self).x, y: finger.location(in: self).y, width:(lion?.frame.size.width)!, height:(lion?.frame.size.height)!);
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //Stop lion animation
        lion?.stopAnimating()
        
        //Setting animals back to their homespot if they have been let go anywhere that
        //isnt inside the blue circle
        if (liontouch)
        {
            //Check where the animal was at when the touch ended.
            //If outside the jungle box, move it back to its home spot.
            if (warzone?.frame.contains((lion?.frame)!))!
            {
                
                //If any of the other animal options are already in there, or game is already being played,
                //then take this animal back home
                if ((warzone?.frame.contains((rabbit?.frame)!))! || (warzone?.frame.contains((cobra?.frame)!))! || gameplay)
                {
                    UIView.beginAnimations("Move", context: nil)
                    UIView.setAnimationDuration(2.0)
                    UIView.setAnimationDelegate(self)
                    //UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
                    
                    //Add propety changes here
                    lion?.frame = lionhome;
                    
                    UIView.commitAnimations()
                }
                    
              //Otherwise, animal can play
                else
                {
                //If animal is inside the warzone, then set it to the playing position
                //via animation
                
                UIView.beginAnimations("Move", context: nil)
                UIView.setAnimationDuration(2.0)
                UIView.setAnimationDelegate(self)
                    UIView.setAnimationDidStop(#selector(startWar(animationId: )))
                
                //Add property changes here
                lion?.frame = CGRect(x: (3/5)*(warzone?.frame.width)!, y: (warzone?.frame.origin.y)!+(1/2)*(warzone?.frame.height)!, width:(lion?.frame.size.width)!, height:(lion?.frame.size.height)!);
                
                UIView.commitAnimations()
                
                //Animal is in spot. Now turn gameplay on
                gameplay = true
                }
            }
            
            //Otherwise, animate it back to its starting home position.
            else
            {
                UIView.beginAnimations("Move", context: nil)
                UIView.setAnimationDuration(2.0)
                UIView.setAnimationDelegate(self)
                //UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
                
                //Add property changes here
                lion?.frame = lionhome;
                
                UIView.commitAnimations()
                
                
            }
        }
        
        else if (cobratouch)
        {
            //Check where the animal was at when the touch ended.
            //If outside the jungle box, move it back to its home spot.
            if (warzone?.frame.contains((cobra?.frame)!))!
            {
                    
                //If any of the other animal options are already in there, or game is already being played,
                //then take this animal back home
                if ((warzone?.frame.contains((rabbit?.frame)!))! || (warzone?.frame.contains((lion?.frame)!))! || gameplay)
                {
                    UIView.beginAnimations("Move", context: nil)
                    UIView.setAnimationDuration(2.0)
                    UIView.setAnimationDelegate(self)
                    //UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
                        
                    //Add property changes here
                    cobra?.frame = cobrahome;
                        
                    UIView.commitAnimations()
                }
                        
                //Otherwise, animal can play
                else
                {
                //If animal is inside the warzone, then set it to the playing position
                //via animation
                
                UIView.beginAnimations("Move", context: nil)
                UIView.setAnimationDuration(2.0)
                UIView.setAnimationDelegate(self)
                UIView.setAnimationDidStop(#selector(startWar(animationId: )))
                
                //Add propety changes here
                cobra?.frame = CGRect(x: (3/5)*(warzone?.frame.width)!, y: (warzone?.frame.origin.y)!+(1/2)*(warzone?.frame.height)!, width:(cobra?.frame.size.width)!, height:(cobra?.frame.size.height)!);
                
                UIView.commitAnimations()
                
                //Animal is in spot. Now turn gameplay on
                gameplay = true
                }
            }
                
                //Otherwise, animate it back to its starting home position.
            else
            {
                UIView.beginAnimations("Move", context: nil)
                UIView.setAnimationDuration(2.0)
                UIView.setAnimationDelegate(self)
                //UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
                
                //Add property changes here
                cobra?.frame = cobrahome;
                
                UIView.commitAnimations()
                
            }

        }
        
        else if (rabbittouch)
        {
            //Check where the animal was at when the touch ended.
            //If outside the jungle box, move it back to its home spot.
            if (warzone?.frame.contains((rabbit?.frame)!))!
            {
                //If any of the other animal options are already in there, or game is already being played,
                //then take this animal back home
                if ((warzone?.frame.contains((cobra?.frame)!))! || (warzone?.frame.contains((lion?.frame)!))! || gameplay)
                {
                    UIView.beginAnimations("Move", context: nil)
                    UIView.setAnimationDuration(2.0)
                    UIView.setAnimationDelegate(self)
                    //UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
                    
                    //Add property changes here
                    rabbit?.frame = rabbithome;
                    
                    UIView.commitAnimations()
                }
                    
                    //Otherwise, animal can play
                else
                {
                //If animal is inside the warzone, then set it to the playing position
                //via animation
                
                UIView.beginAnimations("Move", context: nil)
                UIView.setAnimationDuration(2.0)
                UIView.setAnimationDelegate(self)
                UIView.setAnimationDidStop(#selector(startWar(animationId: )))
                
                //Add property changes here
                rabbit?.frame = CGRect(x: (3/5)*(warzone?.frame.width)!, y: (warzone?.frame.origin.y)!+(1/2)*(warzone?.frame.height)!, width:(rabbit?.frame.size.width)!, height:(rabbit?.frame.size.height)!);
                
                UIView.commitAnimations()
                
                //Animal is in spot. Now turn gameplay on
                gameplay = true
                }}
                
                //Otherwise, animate it back to its starting home position.
            else
            {
                UIView.beginAnimations("Move", context: nil)
                UIView.setAnimationDuration(2.0)
                UIView.setAnimationDelegate(self)
                //UIView.setAnimationDidStop(#selector(finishedAnimation(animationId:)))
                
                //Add propety changes here
                rabbit?.frame = rabbithome;
                
                UIView.commitAnimations()
            }

        }
    }
    
    func lionAnimate()
    {
        //Animating the lion
        lion?.animationImages = lionarray
        lion?.animationDuration = 1.0
        lion?.animationRepeatCount = 0
        lion?.startAnimating()
    }
    
    func lionRoar()
    {
        
        //From StackOverflow:
        
        let player = AVQueuePlayer()
        
        if let url = Bundle.main.url(forResource: "LionRoar", withExtension: "m4a") {
            player.removeAllItems()
            player.insert(AVPlayerItem(url: url), after: nil)
            player.play()
        }}

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    
        //Drawing a blue line around the frame of the jungle
        //image.
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setStrokeColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        ctx?.stroke(CGRect(x: (warzone?.frame.origin.x)!, y: (warzone?.frame.origin.y)!, width: (warzone?.frame.width)!, height: (warzone?.frame.height)!));
        
        
    }
    

}
