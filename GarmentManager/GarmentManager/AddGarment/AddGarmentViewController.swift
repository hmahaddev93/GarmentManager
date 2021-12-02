//
//  AddGarmentViewController.swift
//  GarmentManager
//
//  Created by Khateeb H. on 12/1/21.
//

import UIKit

protocol AddGarmentViewControllerDelegate: AnyObject {
    func didFinishAddNewGarment(garmentItem: Garment)
}

class AddGarmentViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    private let viewModel = AddGarmentViewModel()
    private let alertPresenter = AlertPresenter()
    private let modalPresenter = ModalPresenter()
    
    weak var delegate: AddGarmentViewControllerDelegate?
    private var actionButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func validateAndSave() {
        if titleTextField.text?.replacingOccurrences(of: " ", with: "") == "" {
            self.alertPresenter.present(from: self, title: nil, message: "Input title", dismissButtonTitle: "OK")
            return
        }
        viewModel.addNewGarment(title: titleTextField.text!) { [unowned self]result in
            switch result {
            case .success(let item):
                delegate?.didFinishAddNewGarment(garmentItem: item)
                self.modalPresenter.dismiss(from: self, animated: true)
            case .failure(let error):
                self.alertPresenter.present(from: self, title: "Error", message: error.localizedDescription, dismissButtonTitle: "OK")
            }
        }
    }
    
    @IBAction func onAddNew(_ sender: Any) {
        validateAndSave()
    }
}
