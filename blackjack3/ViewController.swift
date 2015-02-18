//
//  ViewController.swift
//  blackjack3
//
//  Created by Kushal Jogi on 2/16/15.
//  Copyright (c) 2015 Kushal Jogi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var insureButton: UIButton!
    @IBOutlet weak var bidValue: UILabel!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var scoreValue: UILabel!
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var pCard: UITextView!
    @IBOutlet weak var dCard: UITextView!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var dealerLabel: UILabel!
    
    var a = 0, mycount = 51
    var s = 100
    var sumPlayer = 0
    var sumDealer = 0
    var dCount = 0
    var aCard = "aC" ,bCard = "bC",cCard = "cC",eCard = "eC", fCard = "fC", vString = "v", jCard = "jC"
    var xIndex = 0, yIndex = 0 , pFlag = 0
    let array = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]
    let mysymbol = ["♠", "♡","♢","♣"]
    var myDeck = ["A♠","2♠","3♠","4♠","5♠","6♠","7♠","8♠","9♠","10♠","J♠","Q♠","K♠","A♡","2♡","3♡","4♡","5♡","6♡","7♡","8♡","9♡","10♡","J♡","Q♡","K♡","A♢","2♢","3♢","4♢","5♢","6♢","7♢","8♢","9♢","10♢","J♢","Q♢","K♢","A♣","2♣","3♣","4♣","5♣","6♣","7♣","8♣","9♣","10♣","J♣","Q♣","K♣"]
    var sDeck = [" "]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        standButton.enabled = false
        hitButton.enabled = false
        insureButton.enabled = false
        dealButton.enabled = false
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        let count = countElements(list)
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }

    
    @IBAction func onePressed(sender: UIButton) {
        println("1 button pressed")
        a+=1
        s-=1
        if dealButton.enabled == false && a > 0 {
            dealButton.enabled = true
        }
        self.bidValue.text = String(a)
        self.scoreValue.text = String(s)
    
    }
    @IBAction func fivePressed(sender: UIButton) {
        println("5 button pressed")
        a+=5
        s-=5
        if dealButton.enabled == false && a > 0 {
            dealButton.enabled = true
        }
        self.bidValue.text = String(a)
        self.scoreValue.text = String(s)
    }
    
    @IBAction func tenPressed(sender: UIButton) {
        println("10 button pressed")
        a+=10
        s-=10
        if dealButton.enabled == false && a > 0 {
            dealButton.enabled = true
        }
        self.bidValue.text = String(a)
        self.scoreValue.text = String(s)
    }
   
    @IBAction func dealPressed(sender: UIButton) {
        sumPlayer = 0
        sumDealer = 0
        pFlag = 0
        println("Deal Button Pressed")
        standButton.enabled = true
        hitButton.enabled = true
        dealButton.enabled = false
        if (dCount == 0){
            sDeck = shuffle(myDeck)
        }
        dCount++
        if dCount > 4
        {
            dCount == 0
        }
        aCard = sDeck[mycount--]
        bCard = sDeck[mycount--]
        cCard = sDeck[mycount--]
        eCard = sDeck[mycount--]
        sumPlayer += switchArr(aCard) + switchArr(bCard)
        sumDealer += switchArr(cCard) + switchArr(eCard)
        self.pCard.text = ("\(aCard)\n\(bCard)")
        self.dCard.text = (cCard)
    }
    
    
    @IBAction func standPressed(sender: UIButton) {
        println("STAND button pressed")
        standButton.enabled = false
        hitButton.enabled = false
        dealButton.enabled = false
        self.dCard.text = ("\(self.dCard.text)\n\(eCard)")
        randDealer()
        win()
        a = 0
        self.bidValue.text = String(a)
        
        self.scoreValue.text = String(s)
        sumPlayer = 0
    }
    
    func randDealer() {
        if sumDealer < 16 {
                jCard = sDeck[mycount--]
                self.dCard.text = ("\(self.dCard.text)\n\(jCard)")
                sumDealer += switchArr(jCard)
                randDealer()
        }
        
    }
    
    
    @IBAction func hitPressed(sender: UIButton) {
        println("HIT button pressed")
        fCard = sDeck[mycount--]
        sumPlayer += switchArr(fCard)
        if sumPlayer > 21{
            pFlag = 1
        }
        if pFlag != 0 {
             self.pCard.text = ("\(self.pCard.text)\n\(fCard)")
             self.pCard.text = ("\(self.pCard.text)\nBust!!")
             self.dCard.text = ("\(self.dCard.text)\n\(eCard)")

             newDeal()
        } else{
            self.pCard.text = ("\(self.pCard.text)\n\(fCard)")
        }
        
    }
    

    @IBAction func insurePressed(sender: UIButton) {
         println("INSURE button pressed")
        
    }
    
  
    func switchArr(myIndex: String) -> Int{
        var ret : Int
        
        switch myIndex{
        case "A♠","A♡","A♢","A♣":
            ret = 11
        case "2♠","2♡","2♢","2♣":
            ret = 2
        case "3♠","3♡","3♢","3♣":
            ret = 3
        case "4♠","4♡","4♢","4♣":
            ret = 4
        case "5♠","5♡","5♢","5♣":
            ret = 5
        case "6♠","6♡","6♢","6♣":
            ret = 6
        case "7♠","7♡","7♢","7♣":
            ret = 7
        case "8♠","8♡","8♢","8♣":
            ret = 8
        case "9♠","9♡","9♢","9♣":
            ret = 9
        case "10♠","10♡","10♢","10♣":
            ret = 10
        case "K♠","K♡","K♢","K♣","Q♠","Q♡","Q♢","Q♣","J♠","J♡","J♢","J♣":
            ret = 10
        default:
            ret = 0
        }
        return ret
    }
    
    
    func newDeal(){
        a=0
        
        pFlag = 0
        self.bidValue.text = String(a)
        standButton.enabled = false
        hitButton.enabled = false
        dealButton.enabled = false
        win()
        self.scoreValue.text = String(s)
        
    }
    func win(){
        if  sumPlayer > sumDealer && (sumPlayer < 21 || sumPlayer == 21) {
            s += a*2
            println("Won")
            self.pCard.text = ("\(self.pCard.text)\nWin \(a*2)")
        } else if sumPlayer == sumDealer{
            s += a
            println("Push")
            self.pCard.text = ("\(self.pCard.text)\nPush")
        } else if sumDealer > 21 && (sumPlayer < 21 || sumPlayer == 21) {
            s += a*2
            println("Won")
            self.pCard.text = ("\(self.pCard.text)\nWin \(a*2)")
        }else {
            println("Unlucky!!")
            self.pCard.text = ("\(self.pCard.text)\nUnlucky!!")
        }
    }
}

