//
//  AddGarmentViewModel.swift
//  GarmentManager
//
//  Created by Khateeb H. on 12/1/21.
//

import Foundation

final class AddGarmentViewModel {
    
    func addNewGarment(title: String, completion: @escaping(Result<Garment, Error>) -> Void) {
        DataManager.shared.saveNewGarment(id: UUID(), title: title, createdDate: Date()) { result in
            completion(result)
        }
    }
}
