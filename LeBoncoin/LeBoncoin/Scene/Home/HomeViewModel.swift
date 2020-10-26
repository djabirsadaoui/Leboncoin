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
    var isLoading: Box<Bool> {get}
    var filter: Category? {get set}
}

class HomeViewModel: HomeViewModelProtocol {
    //MARK: Vars
    var items: Box<[Announcement]> = Box([])
    var announcements: [Announcement] = []
    var categories: Box<[Category]> = Box([Category(id: 0, name: "All categories")])
    var errorMessage: Box<String?> = Box(nil)
    var isLoading: Box<Bool> = Box(false)
    var filter: Category? {
        didSet {
            guard let filter = filter else {
                return
            }
            self.setFilter(filter: filter.id)
        }
    }
    private let apiFetcher: APIFetchable
    
    //MARK: Initializer
    init(apifetcher: APIFetchable) {
        self.apiFetcher = apifetcher
        self.getAnnoucements()
    }
    
    // MARK: Calling Api fetcher
    internal func getAnnoucements() {
        self.isLoading.value = true
        self.apiFetcher.fetchAnnoucements { [weak self] (result) in
            switch result {
            case .success(let annoucements):
                self?.announcements = self?.sortByDate(annoucements) ?? []
                self?.setFilter(filter: 0)
                self?.getCategories()
            case .failure(let error):
                self?.isLoading.value = false
                self?.errorMessage = Box(error.localizedDescription)
            }
        }
    }
    
    internal func getCategories() {
        self.apiFetcher.fetchCategories { [weak self] (result) in
            switch result {
            case .success(let categories):
                self?.categories.value.append(contentsOf: categories)
                self?.setCategoryForAnnoucement(categories)
                self?.setFilter(filter: self?.filter?.id ?? 0)
            case .failure(let error):
                self?.errorMessage = Box(error.localizedDescription)
            }
            self?.isLoading.value = false
        }
    }
    
    // MARK: funcs
    internal func setCategoryForAnnoucement(_ categories: [Category]) {
        self.announcements = self.announcements.map({ (announcement) -> Announcement in
            var item = announcement
            let category = categories.first { return $0.id == announcement.categoryID}
            item.categoryName = category?.name
            return item
        })
    }
    
    internal func sortByDate(_ annoucements: [Announcement]) -> [Announcement] {
        return annoucements.sorted(by: {
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
    
    internal func setFilter(filter: Int) {
        if filter == 0 {
            self.items.value = self.announcements
            return
        }
        let array = self.announcements.filter({ (a) -> Bool in
            return a.categoryID == filter
        })
        self.items.value = self.sortByDate(array)
    }
}


