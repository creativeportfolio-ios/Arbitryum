//
//  IceCreamDetailViewController.swift
//
//  Created by Nick on 09/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class IceCreamDetailViewController: BaseViewController<IceCreamDetailInteractor>, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets

    ///
    @IBOutlet weak var iceCreamDetailListTableView: UITableView!

    ///
    var iceCreamDetailRouter: IceCreamDetailRouter?

    // MARK: - Variables

    ///
    var databaseRefer: DatabaseReference!
    ///
    var databaseHandle: DatabaseHandle!
    ///
    var nameListArr: [[String: String]] = []


    // MARK: - Lifecycle Methods

    override func viewDidLoad() {

        super.viewDidLoad()
        setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        fetchDataFromFireBase()
    }

    func setUpUI() {

        databaseRefer = Database.database().reference()
        iceCreamDetailListTableView.delegate = self
        iceCreamDetailListTableView.dataSource = self

    }

    /// featch data fro9m firebase
    func fetchDataFromFireBase() {

        databaseRefer.child("IceCreamDetail").observe(DataEventType.value, with: { (data) in
            self.nameListArr.removeAll()
            let nameList = data.value as? [String: Any]
            let keys = nameList?.keys
            if let listOfKeys = keys {
                listOfKeys.forEach({ (key) in
                    self.nameListArr.append(nameList?[key] as? [String : String] ?? [:])
                    self.nameListArr[self.nameListArr.count - 1]["userId"] = key
                    print(self.nameListArr[self.nameListArr.count - 1])
                })
            }
            self.iceCreamDetailListTableView.reloadData()
        })
    }

    // MARK: -  TableView Methord


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameListArr.count
    }

    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.iceCreamDetailCell, for: indexPath) else { return UITableViewCell() }

        cell.iceCreamNameLabel?.text = nameListArr[indexPath.row]["name"]
        cell.iceCreamColorLabel?.text = nameListArr[indexPath.row]["color"]
        cell.iceCreamFlavourLabel?.text = nameListArr[indexPath.row]["flavor"]
        cell.iceCreamTemperatureLabel?.text = nameListArr[indexPath.row]["temperature"]

        return cell
    }

}
