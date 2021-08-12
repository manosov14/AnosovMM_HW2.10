//
//  NetworkManager.swift
//  AnosovMM_HW2.10
//
//  Created by Михаил on 09.08.2021.
//
import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with complition: @escaping (Welcome) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let rickAndMorty = try JSONDecoder().decode(Welcome.self, from: data)
                print(rickAndMorty)
                DispatchQueue.main.async {
                    complition(rickAndMorty)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchCharacterInfo(from url: String?, characterId index: Int?, with complition: @escaping (Result) -> Void)  {
        guard let url = URL(string: "\(URLS.rickAndMortyApi.rawValue)/\(index ?? 0)") else {
            return
        }
                      
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response { print(response)}
            guard let data = data else {
                print(error?.localizedDescription ?? "No description message")
                print(data ?? "no data")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let characterData = try decoder.decode(Result.self, from: data)
                DispatchQueue.main.async {
                    complition(characterData)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
//    func fetchAllEpisodes(for url: String?, with compition: @escaping (Result) -> Void) {
//        AF.request(URLS.rickAndMortyApi.rawValue)
//            .validate()
//            .responseJSON {
//            
//            dataResponse in
//                switch dataResponse.result  {
//        
//                case .success(let value):
//                    print(value)
//                    
//                case .failure(let error):
//                    print(error)
//                }
//                
//                
//
//        }
//    }
}

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringUrl = url else { return nil }
        guard let ImageUrl = URL(string: stringUrl) else { return nil }
        return try? Data(contentsOf: ImageUrl)
    }
}
