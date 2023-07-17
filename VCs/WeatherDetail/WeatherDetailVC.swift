//
//  WeatherDetailVC.swift
//  Weather App
//
//  Created by Codigo Thura Oo on 6/1/23.
//

import UIKit

class WeatherDetailVC: BaseViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblWeatherDesc: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblClouds: UILabel!
    @IBOutlet weak var lblFetching: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConst: NSLayoutConstraint!
    
    var cityListIndex = 0
    var vm = WeatherDetailVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVM()
        setupTableView()
        setupCurrentWeather()
        fetchForecastData()
    }
    
    // MARK: functions
    
    @IBAction func btnCancelPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btnUnsubscribePressed(_ sender: Any) {
        CommonData.removeCityList(index: cityListIndex)
        dismiss(animated: true)
    }
    
    // MARK: Setup
    
    func setupVM() {
        vm.foreCastUpdated = { [weak self] in
            self?.loadDataToTableView()
        }
    }
    
    func setupTableView() {
        tableView.register(UINib.getNib(for: ForecastCell.className), forCellReuseIdentifier: ForecastCell.className)
        tableView.register(UINib.getNib(for: ForecastHeaderView.className), forCellReuseIdentifier: ForecastHeaderView.className)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 40
        tableView.rowHeight = 68
        tableView.sectionHeaderTopPadding = 0
    }
    
    func setupCurrentWeather() {
        lblCityName.text = vm.cityData.name
        lblWeatherDesc.text = vm.currentWeatherData.description?.capitalized
        lblTemp.text = vm.currentWeatherData.temp != nil ? "\(vm.currentWeatherData.temp ?? 0)°C" : "-"
        lblHumidity.text = vm.currentWeatherData.humidity != nil ? "\(vm.currentWeatherData.humidity ?? 0)%" : "-"
        lblWind.text = vm.currentWeatherData.windSpeed != nil ? "\(vm.currentWeatherData.windSpeed ?? 0)m/s" : "-"
        lblPressure.text = vm.currentWeatherData.pressure != nil ? "\(vm.currentWeatherData.pressure ?? 0)hPa" : "-"
        lblClouds.text = vm.currentWeatherData.cloudValue != nil ? "\(vm.currentWeatherData.cloudValue ?? 0)%" : "-"
        
        if let iconName = vm.currentWeatherData.icon?.replacingOccurrences(of: "n", with: "d", options: .literal, range: nil), iconName != "" {
            let urlString = APIManager.Routs.weatherIcon(iconName: iconName)
            imgWeather.setWebImage(urlString: urlString)
        }
    }
}

// MARK: VM Methods

extension WeatherDetailVC {
    
    func fetchForecastData() {
        lblFetching.isHidden = false
        vm.fetchForecastWeather(lat: vm.cityData.lat ?? 0, lon: vm.cityData.lon ?? 0)
    }
    
    func loadDataToTableView() {
        lblFetching.isHidden = true
        self.tableView.reloadData()
        self.tableViewHeightConst.constant = CGFloat(self.vm.weatherCount) * self.tableView.rowHeight + CGFloat(self.vm.weatherGroup.count) * self.tableView.sectionHeaderHeight
    }
}

// MARK: TableView

extension WeatherDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.weatherGroup.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.weatherGroup[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.className) as! ForecastCell
        cell.setupData(weatherData: vm.weatherGroup[indexPath.section][indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed(ForecastHeaderView.className, owner: self, options: nil)?.first as! ForecastHeaderView
        view.setup(date: vm.weatherGroup[section].first?.dateDaily ?? "")
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
