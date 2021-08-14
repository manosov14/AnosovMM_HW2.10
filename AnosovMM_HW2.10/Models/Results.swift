//
//  Character.swift
//  AnosovMM_HW2.10
//
//  Created by Михаил on 06.08.2021.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let info: Info
    let results: [Result]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin, location: Location
    let image: String
    let air_date: String?
    let episode: [String]
    let characters: [String]?
    let url: String
    let created: String
    
    var discription: String {
        """
            Status: \(status ?? "Unknown")
            Gender: \(gender ?? "Unknown")
            Origin: \(origin.name)
        """
    }
    
    init(value: [String : Any]) {
        id = value["id"] as? Int ?? 0
        
        name = value["name"] as? String ?? ""
        
        status = value["status"] as? String ?? ""
        
        species = value["species"] as? String ?? ""
        
        type = value ["type"] as? String ?? ""
        
        gender = value["gender"] as? String ?? ""
        
        let originDict = value["origin"] as? [String : String] ?? [:]
        origin = Location(value: originDict)
        
        let locationDict = value["location"] as? [String : String] ?? [:]
        location = Location(value: locationDict)
        
        image = value["image"] as? String ?? ""
        
        air_date = value["air_date"] as? String ?? ""
        
        episode = value["episode"] as? [String] ?? [""]
        
        characters = value["characters"] as? [String] ?? [""]
        
        url = value["url"] as? String ?? ""
        
        created = value["created"] as? String ?? ""
    }
    
    static func getEpisodes(from value: Any) -> [Result]? {
        guard let value = value as? [String : Any] else { return [] }
        guard let results = value["results"] as? [[String : Any]] else { return [] }
        return results.compactMap { Result(value: $0) }
    }
}

// MARK: - Location
struct Location: Codable {
    let name, url: String
    
    init(value: [String : String]) {
        name = value["name"] ?? ""
        url = value["url"] ?? ""
    }
    
}

// MARK: - URLS
enum URLS: String {
    case rickAndMortyApi = "https://rickandmortyapi.com/api/character"
    case baseUrl = "https://rickandmortyapi.com/api/"
}

enum endpoints: String {
    case character = "character"
    case episodes = "episode"
}

