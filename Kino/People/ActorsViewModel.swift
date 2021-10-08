//
//  ActorsViewModel.swift
//  Kino
//
//  Created by Alina Bilonozhko on 20.04.2021.
//

import Foundation
import UIKit

class ActorsViewModel {
    
    private var apiService = ApiService()
    private var popularActors = [Actor]()
    
    private var totalPages = 1
    private var currentPage = 0 
   
   
    
    func fetchPopularActorData(page: Int = 1, completion: @escaping () -> ()) {
        
        apiService.getPopularActorsData(page: page) { [weak self] (result) in
            
            switch result {
            case .success(let listOF):
                self?.totalPages = listOF.totalPages
                self?.currentPage = listOF.currentPage
                self?.popularActors.append(contentsOf: listOF.actors)
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }
            
        }
    }
    
    func numberOfRowsInSection (section: Int) -> Int {
        
        return popularActors.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Actor {
        return popularActors[indexPath.row]
    }
    
    func getPopularActorsCount() -> Int {
        return popularActors.count
    }
    
    func returnActors() -> [Actor] {
        return popularActors
    }
    
    // MARK: Get total and current page count
    
    func getCurrentPage() -> Int {
        return currentPage
    }
    
    func getTotalPages() -> Int {
        return totalPages
    }
    
}
