//
//  WeatherListVC.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/1/23.
//

import UIKit

class WeatherListVC: BaseViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblSearching: UILabel!
    @IBOutlet weak var lblNoCity: UILabel!
    
    var vm = WeatherListVM()
    var router = WeatherListRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVM()
        setupRouter()
        setupActions()
        setupTableView()
        searchWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: functions
    
    @objc func addCity() {
        router.goToAddCity()
    }
    
    // MARK: Setup
    
    func setupVM() {
        vm.weatherUpdated = { [weak self] in
            self?.updateData()
        }
        vm.finishedFetching = { [weak self] in
            self?.finishSearchingCity()
        }
    }
    
    func setupRouter() {
        router.viewController = self
        router.vm = vm
    }
    
    func setupActions() {
        btnAdd.addTarget(self, action: #selector(addCity), for: .touchUpInside)
    }
    
    func setupTableView() {
        tableView.register(UINib.getNib(for: WeatherMainCell.className), forCellReuseIdentifier: WeatherMainCell.className)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: VM Methods

extension WeatherListVC {
    
    func searchWeather() {
        lblSearching.isHidden = false
        vm.fetchWeathersForIndividualCities()
    }
    
    func updateData() {
        tableView.reloadData()
    }
    
    func finishSearchingCity() {
        lblSearching.isHidden = true
        lblNoCity.isHidden = vm.cityList.count > 0
    }
    
    func unsubscribeCity(indexPath: IndexPath) {
        vm.removeCity(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        lblNoCity.isHidden = vm.cityList.count > 0
    }
}

// MARK: TableView

extension WeatherListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherMainCell.className) as! WeatherMainCell
        cell.setupData(cityData: vm.cityList[indexPath.row], weatherData: vm.weatherList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router.goToDetails(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath) as! WeatherMainCell
        cell.highLightView()
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath) as! WeatherMainCell
        cell.unhighLightView()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Unsubscribe", handler: {action, swipeButtonView, completion in
            self.unsubscribeCity(indexPath: indexPath)
            completion(true)
        })
        return UISwipeActionsConfiguration(actions: [action])
    }
}

// MARK: Routing

//extension WeatherListVC {
//
//    func goToAddCity() {
//        let vc = StoryboardManager.citySearchVC as! CitySearchVC
//        vc.addedCity = {
//            self.searchWeather()
//            self.tableView.reloadData()
//        }
//        present(vc, animated: true)
//    }
//
//    func goToDetails(index: Int!) {
//        let vc = StoryboardManager.weatherDetailVC as! WeatherDetailVC
//        vc.vm.currentWeatherData = vm.weatherList[index]
//        vc.vm.cityData = vm.cityList[index]
//        vc.cityListIndex = index
//        present(vc, animated: true)
//    }
//}
