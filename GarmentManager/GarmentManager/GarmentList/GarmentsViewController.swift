//
//  ViewController.swift
//  GarmentManager
//
//  Created by Khateeb H. on 12/1/21.
//

import UIKit

final class GarmentsViewController: UIViewController {
    
    private let viewModel = GarmentsViewModel()
    private let modalPresenter = ModalPresenter()
    
    @IBOutlet weak var sortBySegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareView()
        fetch()
    }
    
    private func prepareView() {
        self.title = "LIST"
        loadSortModeSegments()
        tableView.tableFooterView = UIView()
    }
    
    private func loadSortModeSegments() {
        sortBySegment.removeAllSegments()
        var index = 0
        for sortMode in GarmentsSortMode.allCases {
            sortBySegment.insertSegment(withTitle: sortMode.title.capitalized, at: index, animated: false)
            index = index + 1
        }
        sortBySegment.selectedSegmentIndex = 0
    }
    
    private func fetch() {
        viewModel.fetchAllItems(sortMode: GarmentsSortMode(rawValue: sortBySegment.selectedSegmentIndex)!) { result in
            switch result {
            case .success(_):
                self.update()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func update() {
        tableView.reloadData()
    }
    
    @IBAction func onAddNewGarment(_ sender: Any) {
        modalPresenter.presentAddGarment(from: self)
    }
    @IBAction func onSortModeChange(_ sender: Any) {
        fetch()
    }
}

extension GarmentsViewController: AddGarmentViewControllerDelegate {
    func didFinishAddNewGarment(garmentItem: Garment) {
        fetch()
    }
}


extension GarmentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.garments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        let garment = viewModel.garments[indexPath.row]
        cell.textLabel?.text = garment.title
        return cell
    }
    
    
}
