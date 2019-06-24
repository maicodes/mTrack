//
//  ViewController.swift
//  mTrack
//
//  Created by Mai Le on 5/29/19.
//  Copyright © 2019 mdl160. All rights reserved.
//

import UIKit

protocol LyricViewDataSource {
   // var lyricContent : String {get set}
//    var singer : String {get set}
//    var song : String { get set }
    
    func userEnterInfo () -> [String]
    
  //  func touchedButton () -> Bool
}

class ViewController: UIViewController, LyricViewDataSource {

    
 //    var delegate : LyricViewDataSource!
    
  //  var lyricContent = ""
    
    
    @IBOutlet var artistName : UITextField!{
        didSet{
        }
    }
    @IBOutlet var songTitle  : UITextField! {
        didSet{
        }
    }
   
    
    @IBOutlet var searchButton : UIButton! {
        didSet{
            searchButton.layer.cornerRadius = 10
            searchButton.layer.masksToBounds = true
           
        }
//        if let  lyricContentTemp = getLyric() {
//            lyricContent = lyricContentTemp
//        } else {
//            lyricContent = "Could not find lyric!"
//        }
        
    }
    

    func userEnterInfo() -> [String] {
        let artist = artistName.text!
        let songName = songTitle.text!
        var result = [String]()
        
        result.insert(artist, at: 0)
        result.insert(songName, at: 1)
        
        return (result)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search" {
            let segueDestination = segue.destination as! LyricViewController
            segueDestination.dataSource = self
            
        }
        
    }
}

