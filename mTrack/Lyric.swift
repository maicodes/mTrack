//
//  Lyric.swift
//  mTrack
//
//  Created by Mai Le on 5/29/19.
//  Copyright © 2019 mdl160. All rights reserved.
//

import Foundation

struct Lyric {
    
    var lyric : String = ""
    
    enum CodingKeys : String, CodingKey {
        case message
    }
    
    enum MessageKeys : String, CodingKey {
        case body
    }
    
    enum BodyKeys : String, CodingKey {
        case lyrics
    }
    
    enum LyricsKeys: String, CodingKey {
        case lyric = "lyrics_body"
    }
    

    
}

extension Lyric : Decodable {
init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    
    let message = try values.nestedContainer(keyedBy: MessageKeys.self, forKey: .message)
    
    let body = try message.nestedContainer(keyedBy: BodyKeys.self, forKey: .body)
    
    let lyrics = try body.nestedContainer(keyedBy: LyricsKeys.self, forKey: .lyrics)
    
    lyric = try lyrics.decode(String.self, forKey: .lyric)
}
}
