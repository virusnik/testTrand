//
//  ViewController.swift
//  testTrand
//
//  Created by Sergio Veliz on 10/25/18.
//  Copyright © 2018 Sergio Veliz. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import DropDown
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceFrom: UIButton!
    @IBOutlet weak var priceTo: UIButton!
    @IBOutlet weak var loadMoreButton: UIButton!
    
    var searchResponse = SearchResponse()
    let amountDropDownFrom = DropDown()
    let amountDropDownTo = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.amountDropDownFrom,
            self.amountDropDownTo
        ]
    }()
    
    private var countItems = 10
    
    private let reuseIdentifierAdvertCell = "AdvertCell"
    fileprivate let defaultImage = UIImage(named: "empty")
    
    private let currency = NSLocalizedString(" руб.", comment: "currency rub")
    private let minute = NSLocalizedString(" мин", comment: "minute")
    private let from = NSLocalizedString("от ", comment: "from")
    
    private let isFromTappp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        setupAmountDropDown()
        
        loadMoreButton.layer.borderWidth = 1
        loadMoreButton.layer.cornerRadius = 5
        
        getListOfBuildings(countItems: countItems)
    }
    
    
    @IBAction func priceFromTapped(_ sender: AnyObject) {
        amountDropDownFrom.show()
    }
    
    @IBAction func priceToTapped(_ sender: AnyObject) {
        amountDropDownTo.show()
    }
    
    func setupAmountDropDown() {
        amountDropDownFrom.anchorView = priceFrom
        amountDropDownTo.anchorView = priceTo
        
        amountDropDownFrom.bottomOffset = CGPoint(x: 0, y: priceFrom.bounds.height)
        amountDropDownTo.bottomOffset = CGPoint(x: 0, y: priceTo.bounds.height)
        
        let (first, last, interval) = (1000000, 6000000, 500000)
        var arrayPrice = [String]()
        var n = 0
        for index in stride(from: first, to: last, by: interval) {
            n += 1
            arrayPrice.append(index.description + currency)
        }
        
        amountDropDownFrom.dataSource = arrayPrice
        
        
        // Action triggered on selection
        amountDropDownFrom.selectionAction = { [weak self] (index, item) in
            self?.priceFrom.setTitle(item, for: .normal)
            var itemRemoveText = item
            itemRemoveText.removeLast(5)
            let itemInt = Int(itemRemoveText)
            let stepItem = itemInt! + 500000
            if !item.isEmpty {
                let (first, last, interval) = (stepItem, 10000000, 500000)
                var arrayPrice = [String]()
                var n = 0
                for index in stride(from: first, to: last, by: interval) {
                    n += 1
                    arrayPrice.append(index.description + (self?.currency)!)
                }
                self?.amountDropDownTo.dataSource = arrayPrice
                
            }
        }
        
        amountDropDownTo.selectionAction = { [weak self] (index, item) in
            self?.priceTo.setTitle(item, for: .normal)
            
        }
    }
    
    
    @IBAction func loadMoreButtonTapped(_ sender: Any) {
        countItems += 10
        getListOfBuildings(countItems: countItems)
    }
    
    //MARK: - Request
    
    func getListOfBuildings(countItems: Int) {
        
        let url = "http://api.trend-dev.ru/v3_1/blocks/search"
        let params:[String: Any] = [
            "show_type": "list",
            "count": countItems,
            "offset": 0,
            "cache": false,
            "price_from": 0,
            "price_to": 0
        ]
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default)
            .validate().responseJSON {
                [weak self]
                response in
                guard let selfNotNil = self else { return }
                switch response.result {
                case .success:
                    if let responseValue = response.result.value {
                        if let response = Mapper<SearchResponse>().map(JSONObject: responseValue) {
                            selfNotNil.searchResponse = response
                            selfNotNil.tableView.reloadData()
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
        }
    }
    
}

//MARK: - Extension for tableview

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResponse.data.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdvertCell", for: indexPath) as! AdvertCell
        let row = indexPath.row
        let item = searchResponse.data.results[row]
        cell.titleLabel.text = item.name
        cell.subtitleLabel.text = item.deadline
        cell.imageAdvert.sd_setImage(
            with: item.getPictureURL(),
            placeholderImage: defaultImage,
            options: .allowInvalidSSLCertificates,
            progress: nil,
            completed: nil)
        cell.oneRoomLabel.text = item.min_prices[0].rooms
        cell.startPrice.text = from + item.min_prices[0].price.formattedWithSeparator + currency
        cell.twoRoomLabel.text = item.min_prices[1].rooms
        cell.oneFlatPrice.text = from + item.min_prices[1].price.formattedWithSeparator + currency
        if item.min_prices.count != 2 && item.min_prices.count != 3 {
            cell.threeRoomLabel.text = item.min_prices[2].rooms
            cell.twoFlatPrice.text = from + item.min_prices[2].price.formattedWithSeparator + currency
            cell.FourRoomLabel.text = item.min_prices[3].rooms
            cell.threeFlatPrice.text = from + item.min_prices[3].price.formattedWithSeparator + currency
        }
        
        cell.locationLabel.text = item.region.name
        cell.companyNameLabel.text = item.builder.name
        cell.metroNameLabel.text = item.subways[0].name
        cell.timeFromMetro.text = item.subways[0].distanceTiming.description + minute
        cell.layer.borderColor = #colorLiteral(red: 0.7567794323, green: 0.7569108009, blue: 0.7567711473, alpha: 1)
        cell.layer.borderWidth = 4
        
        return cell
    }
    
}

// MARK: - Extension for Price fromatt

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
