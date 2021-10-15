//
//  DatailPeopleViewModel.swift
//  Kino
//
//  Created by Alina Bilonozhko on 24.04.2021.
//

import UIKit

class DatailPeopleViewModel {
    private var apiService = ApiService()
    private var actorDetail = [DetailActor]()
    private var movieCredits = [MovieCredit]()
    
    
    func fetchForActorData(id: Int, completion: @escaping () -> ()) {
        
        apiService.searchForActorData(id: id) { [weak self] (result) in
            
            switch result {
            case .success(let listOF):
                self?.actorDetail.removeAll()
                self?.actorDetail.append(listOF)
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }
        }
    }
    
    func fetchForActorMovieCredits(id: Int, completion: @escaping () -> ()) {
        
        apiService.searchForMovieCredits(id: id) { [weak self] (result) in
            
            switch result {
            case .success(let listOF):
                self?.movieCredits.append(contentsOf: listOF.cast)
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }
        }
    }
    
    
    func getDetail() -> [DetailActor] {
        let actor = actorDetail
        return actor
    }
    
    func numberOfRowsInSection (section: Int) -> Int {
        return movieCredits.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> MovieCredit {
        return movieCredits[indexPath.row]
    }
    
    func getMovieCount() -> Int {
        return movieCredits.count
    }
    
 
    
   
    
    
    
}
