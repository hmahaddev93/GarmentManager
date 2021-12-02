//
//  ModalPresenter.swift
//  GarmentManager
//
//  Created by Khateeb H. on 12/1/21.
//

import Foundation

import UIKit

protocol ModalPresenter_Proto {
    func present(from: UIViewController, destination: UIViewController, animated: Bool)
    func dismiss(from: UIViewController, animated: Bool)
}

class ModalPresenter: ModalPresenter_Proto {
    func dismiss(from: UIViewController, animated: Bool) {
        from.dismiss(animated: true)
    }
    
    func present(from: UIViewController, destination: UIViewController, animated: Bool) {
        from.present(destination, animated: true)
    }
    
    func presentAddGarment(from: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddGarmentViewController") as! AddGarmentViewController
        vc.delegate = from as? AddGarmentViewControllerDelegate
        present(from: from, destination: vc, animated: true)
    }
}
