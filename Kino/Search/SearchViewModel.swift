//
//  SearchViewModel.swift
//  Kino
//
//  Created by Alina Bilonozhko on 22.04.2021.
//
import Foundation
import UIKit

class SearchViewModel {
    
    
    private var filteredActors = [Actor]()
    private var apiService = ApiService()
    private var popularActors = [Actor]()
    private var actorDetail = [DetailActor]()
    
    func fetchSearchPopularActorData(query: String, page: Int, completion: @escaping () -> ()) {
        
        apiService.searchPopularActorsData(query: query, page: page) { [weak self] (result) in
            
            switch result {
            case .success(let listOF):
                self?.popularActors.removeAll()
                self?.popularActors.append(contentsOf: listOF.actors)
                completion()
            case .failure(let error):
                print("Error procesing json data: \(error)")
            }
            
        }
    }
    
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
    
    func numberOfRowsInSection (section: Int) -> Int {
        
        return popularActors.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Actor {
        return popularActors[indexPath.row]
    }
    
    func getPopularActorsCount() -> Int {
        return popularActors.count
    }
    
//    func filtr(ifSearch: Bool, searchText: String) {
//        filteredActors = popularActors
//        if ifSearch == true {
//            filteredActors = popularActors.filter({
//                $0.name.contains(searchText)
//            })
//        } else {
//            return
//        }
//        }
    }
    

