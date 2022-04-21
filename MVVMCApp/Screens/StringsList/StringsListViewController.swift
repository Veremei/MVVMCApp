//
//  StringsListViewController.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 20.04.2022.
//

import UIKit

class StringsListViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    private var viewModel: StringsListViewModel

    init(viewModel: StringsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        viewModel.fetchData()
    }
}

extension StringsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.strings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension StringsListViewController: StringsListViewDelegate {
    func didLoadData() {
        tableView.reloadData()
    }
}

