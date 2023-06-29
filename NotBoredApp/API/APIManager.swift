//
//  APIManager.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 08/09/22.
//

import Foundation

protocol BoredManagerDelegate {
    func didUpdateBored(_ boredManager: BoredManager, bored: BoredModel)
    func didFailWithError(error: Error)
}

struct BoredManager {
    let boredURL = "http://www.boredapi.com/api/activity/"
    
    var delegate: BoredManagerDelegate?
    
    func fetchBored(of participants: Int, type: String) {
        let finalURL = "\(boredURL)?type=\(type)&participants=\(participants)"
        performRequest(with: finalURL)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let random = self.parseJSON(safeData) {
                        self.delegate?.didUpdateBored(self, bored: random)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ boredData: Data) -> BoredModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(BoredModel.self, from: boredData)
            let activity = decodedData.activity
            let type = decodedData.type
            let participants = decodedData.participants
            
            let bored = BoredModel(activity, type, participants)
            return bored
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

