//
//  LyricViewController.swift
//  mTrack
//
//  Created by Mai Le on 5/29/19.
//  Copyright © 2019 mdl160. All rights reserved.
//

import UIKit


class LyricViewController: UIViewController {
    
   var dataSource : LyricViewDataSource!
    
    private let baseURL = "https://api.musixmatch.com/ws/1.1/matcher.lyrics.get?format=json"
    private let apikeyID = "&apikey=c1bc6024923e24f1891793ce962a210e"
    var artist = "&q_artist="
    var track  = "&q_track="
    var lyric = ""
    
    
    @IBOutlet var lyricView : UITextView!
    @IBAction func backButton (_ sender : Any) {
        dismiss(animated: true, completion: nil)
    }
    

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let info = dataSource.userEnterInfo()
        
        artist = artist + info[0]
        artist = artist.replacingOccurrences(of: " ", with: "")
        
        track = track + info[1]
        track = track.replacingOccurrences(of: " ", with: "")
        
        
        print("artist : \(artist)")
        print("track : \(track)" )
        
        getLyric()
        
       
        // print("this is the content \(lyricView.text!) ")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getLyric() {
        
       
        
        let apiUrl = baseURL + artist + track + apikeyID
        
        guard let musixMatchUrl = URL(string: apiUrl) else {
            return
        }
        
        let request = URLRequest(url: musixMatchUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error )  in
            
            if let error = error {
                print (error)
                return
            }
            // Parse Json data
            if let data = data {
                
                print("parseJson : " + self.parseJsonData(data: data))
              
                
                self.updateLyricView( self.parseJsonData(data: data) )
                
                OperationQueue.main.addOperation({
                    self.lyricView.reloadInputViews()
                })
               
            }
            
        })
      
        task.resume()
        
    }
    
    func updateLyricView (_ str : String) {
        self.lyricView.text = str
    }
    
    func parseJsonData(data : Data) -> String {
        var lyric : String!
        
        let decoder = JSONDecoder()
        
        do {
            let lyricData = try decoder.decode(Lyric.self, from: data)
            lyric = lyricData.lyric
        } catch {
            updateLyricView("Cant find song")
            print(error)
        }
        
        
       // print("Lyric: \(String(describing: lyric))")
        
        return lyric
    }

}
