//
//  SearchView.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import UIKit

final class SearchView: UIViewController {
    // MARK: - Supviews
    private let searchController = UISearchController()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let cityLabel = UILabel()
    private let tempratureLabel = UILabel()
    private let weatherDescriptionLabel = UILabel()
    private let humidityLabel = UILabel()
    private let windLabel = UILabel()
    private let vStackView = UIStackView()
    private lazy var failureView = FailureView(buttonTitle: "Ok") { [weak self] in
        self?.hideFailureMessage()
    }

    // MARK: - Ints dependencies
    private var presenter: SearchPresenterProtocol?
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(view: self)
        setUpViews()
        setupConstrains()
    }
    
    // MARK: - Setup Views
    private func setUpViews() {
        view.backgroundColor = .systemBackground
        setUpSearchBar()
        tempratureLabel.font = UIFont.preferredFont(forTextStyle: .extraLargeTitle)
        cityLabel.font = UIFont.preferredFont(forTextStyle: .extraLargeTitle2)
        [cityLabel, weatherDescriptionLabel].forEach { $0.textColor = .secondaryLabel }
        weatherDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        [cityLabel, tempratureLabel, weatherDescriptionLabel, vStackView, activityIndicator, failureView].forEach {
            view.addSubview($0)
        }
        vStackView.axis = .vertical
        vStackView.spacing = 5
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title3)
        let windImageView = UIImageView(image: UIImage(systemName: "wind", withConfiguration: symbolConfiguration))
        let humidityImageView = UIImageView(image: UIImage(systemName: "humidity", withConfiguration: symbolConfiguration))
        [windLabel, humidityLabel].forEach { $0.font = UIFont.preferredFont(forTextStyle: .title3) }
        let windStack = UIStackView(arrangedSubviews: [windImageView, windLabel])
        let humidityStack = UIStackView(arrangedSubviews: [humidityImageView, humidityLabel])
        [windStack, humidityStack].forEach {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 12
            vStackView.addArrangedSubview($0)
        }
        hideWeatherData()
    }
    
    private func setupConstrains() {
        [cityLabel, tempratureLabel, weatherDescriptionLabel, vStackView, activityIndicator, failureView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [tempratureLabel, activityIndicator, failureView].forEach {
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        }
        
        NSLayoutConstraint.activate([
            failureView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.bottomAnchor.constraint(equalTo: tempratureLabel.topAnchor),
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherDescriptionLabel.topAnchor.constraint(equalTo: tempratureLabel.bottomAnchor),
            vStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStackView.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: 8)
        ])
    }
    
    private func setUpSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
}

extension SearchView: SearchViewProtocol {
    func load(weatherData: WeatherRepresentableData) {
        tempratureLabel.text = weatherData.temperature
        cityLabel.text = weatherData.cityName
        weatherDescriptionLabel.text = weatherData.weatherDescription
        windLabel.text = weatherData.windSpeed
        humidityLabel.text = weatherData.humidity
    }
    
    func hideWeatherData() {
        weatherRepresentableViews.forEach {
            $0.isHidden = true
        }
    }
    
    func showWeatherData() {
        weatherRepresentableViews.forEach {
            $0.isHidden = false
        }
    }
    
    func startLoadig() {
        activityIndicator.startAnimating()
    }
    
    func stopLoadig() {
        activityIndicator.stopAnimating()
    }
    
    func showFailureMessage(_ message: String) {
        failureView.show(message: message)
    }
    
    func hideFailureMessage() {
        failureView.hideView()
    }
    
    private var weatherRepresentableViews: [UIView] {
        [cityLabel, tempratureLabel, weatherDescriptionLabel, vStackView]
    }
}

extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        handleSearchTextChange(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text ?? ""
        handleSearchTextChange(searchText)
    }
    
    private func handleSearchTextChange(_ text: String) {
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        presenter?.didChangeSearchText(text)
    }
}
