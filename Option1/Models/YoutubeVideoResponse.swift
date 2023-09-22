//
//  YoutubeVideo.swift
//  Option1
//
//  Created by temp on 21/09/23.
//

import Foundation


struct YoutubeVideoResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String?
    let videoId: String?
}
