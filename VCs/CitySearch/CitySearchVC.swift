//
//  CitySearchVC.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/1/23.
//

import UIKit

class CitySearchVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var lblSearching: UILabel!
    
    var vm = CitySearchVM()
    
    var searchTask: Task<(), Error> = Task { return }
    var addedCity: (() -> ()) = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVM()
        setupActions()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        txtSearch.becomeFirstResponder()
    }
    
    func setupVM() {
        vm.cityListUpdated = { [weak self] in
            self?.updateData()
        }
    }
    
    func setupActions() {
        btnCancel.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        txtSearch.addTarget(self, action: #selector(searchChanged), for: .editingChanged)
        txtSearch.addTarget(self, action: #selector(searchPressed), for: .primaryActionTriggered)
    }
    
    func setupTableView() {
        tableView.register(UINib.getNib(for: CityListCell.className), forCellReuseIdentifier: CityListCell.className)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func startTask() {
        let task = Task {
            try await Task.sleep(nanoseconds: 600_000_000)
            self.searchCity()
        }
        self.searchTask = task
    }
    
    @objc func cancelPressed() {
        dismiss(animated: true)
    }
    
    @objc func searchChanged() {
        searchTask.cancel()
        if (txtSearch.text != "") {
            startTask()
        } else {
            vm.clearCity()
            tableView.reloadData()
        }
    }
    
    @objc func searchPressed() {
        txtSearch.resignFirstResponder()
    }
    
    @IBAction func btnClearPressed(_ sender: Any) {
        txtSearch.text = ""
    }
}

extension CitySearchVC { // VM methods
    
    func searchCity() {
        lblSearching.isHidden = false
        vm.searchCity(text: txtSearch.text)
    }
    
    func updateData() {
        lblSearching.isHidden = true
        tableView.reloadData()
    }
}

extension CitySearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityListCell.className) as! CityListCell
        cell.setData(data: vm.cityList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        vm.addCityToUserDefaults(index: indexPath.row)
        addedCity()
        dismiss(animated: true)
    }
}

extension CitySearchVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        txtSearch.resignFirstResponder()
    }
}

