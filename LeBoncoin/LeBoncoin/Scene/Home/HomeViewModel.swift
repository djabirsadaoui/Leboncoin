//
//  AnnocementViewModel.swift
//  LeBoncoin
//
//  Created by dsadaoui on 22/10/2020.
//

import Foundation
protocol HomeViewModelProtocol {
    
    var items: Box<[Announcement]> {get}
    var categories: Box<[Category]> {get}
    var errorMessage: Box<String?> {get}
    
    func getAnnoucements()
    func getCategories()
    func setFilter(for category: Category)
}

class HomeViewModel: HomeViewModelProtocol {
    var items: Box<[Announcement]> = Box([])
    var annoucements: [Announcement] = []
    var categories: Box<[Category]> = Box([])
    var errorMessage: Box<String?> = Box(nil)
    
    private let apiFetcher: APIFetchable
    init(apifetcher: APIFetchable) {
        self.apiFetcher = apifetcher
    }
    
    func getAnnoucements() {
        self.apiFetcher.fetchAnnoucements { [weak self] (result) in
            switch result {
            case .success(let annoucements):
                self?.annoucements = annoucements.sorted(by: {
                    if $0.isUrgent == $1.isUrgent {
                        guard  let date1 = $0.creationDate.toDate() else {
                            return false
                        }
                        guard let date2 = $1.creationDate.toDate() else {
                            return true
                        }
                        return date1 > date2
                    } else if $0.isUrgent {
                        return true
                    } else {
                        return false
                    }
                })
                self?.items.value = self?.annoucements ?? []
            case .failure(let error):
                self?.errorMessage = Box(error.localizedDescription)
            }
        }
    }
    
    func setFilter(for category: Category) {
        self.items.value = self.annoucements.filter({ (a) -> Bool in
            return a.categoryID == category.id
        }).sorted(by: {
            if $0.isUrgent == $1.isUrgent {
                guard  let date1 = $0.creationDate.toDate() else {
                    return false
                }
                guard let date2 = $1.creationDate.toDate() else {
                    return true
                }
                return date1 > date2
            } else if $0.isUrgent {
                return true
            } else {
                return false
            }
        })
    }
    func getCategories() {
        self.apiFetcher.fetchCategories { [weak self] (result) in
            switch result {
            case .success(let categories):
                self?.categories.value = categories
            case .failure(let error):
                self?.errorMessage = Box(error.localizedDescription)
            }
        }
    }
}
