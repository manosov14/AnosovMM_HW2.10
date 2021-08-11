//
//  Character.swift
//  AnosovMM_HW2.10
//
//  Created by Михаил on 06.08.2021.
//



// MARK: - Welcome
struct Welcome: Decodable {
    let info: Info
    let results: [Result]
}

// MARK: - Info
struct Info: Decodable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Result: Decodable {
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
}

// MARK: - Location
struct Location: Decodable {
    let name: String
    let url: String
}

// MARK: - Status
enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

// MARK: - URLS
enum URLS: String {
    case rickAndMortyApi = "https://rickandmortyapi.com/api/character"
}
