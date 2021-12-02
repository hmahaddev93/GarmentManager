//
//  GarmentsViewModel.swift
//  GarmentManager
//
//  Created by Khateeb H. on 12/1/21.
//

import Foundation

enum GarmentsSortMode: Int, CaseIterable {
    case title, createdDate
    var title: String {
        switch self {
        case .title:
            return "Alphabet"
        case .createdDate:
            return "Creation Date"
        }
    }
}

final class GarmentsViewModel {
    var garments: [Garment] = [Garment]()

    func fetchAllItems(sortMode: GarmentsSortMode, completion: @escaping(Result<[Garment], Error>) -> Void) {
        let result = DataManager.shared.fetchGarments()
        switch result {
        case .success(let items):
            if sortMode == .title {
                self.garments = items.sorted(by: { $0.title.lowercased() < $1.title.lowercased()})
            } else if sortMode == .createdDate {
                self.garments = items.sorted(by: { $0.createdDate > $1.createdDate })
            } else {
                self.garments = items
            }
            
            completion(.success(items))
            return
        case .failure(let error):
            completion(.failure(error))
            return
        }
    }
    
    func deleteItem(item: Garment) {
        DataManager.shared.deleteGarment(by: item.id)
    }
}
