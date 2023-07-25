//
//  UserProfile.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 6/27/23.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let explicit_content:[String: Bool]
    let external_urls: [String: String]
    let email:String
    //let followers:[String: Codable?]
    let id:String
    let product:String
    let images:[APIImage]
}
