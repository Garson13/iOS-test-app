//
//  ViewController.swift
//  Тестовое задание IOS
//
//  Created by Гарик on 13.10.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, ViewControllerProtocol {
    
    private let arrayCategory = ["Пицца", "Комбо", "Десерты", "Напитки"]
    private var arrayData: [DataTask] = []
    private let viewModel = ViewModel()
    
    private lazy var headerView: UIView = {
        let view = BannerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 5.5))
        return view
    }()
    
    private lazy var categoryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 35)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .systemGray6
        view.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = 200
        view.allowsSelection = false
        view.backgroundColor = .systemGray6
        view.separatorStyle = .singleLine
        view.tableHeaderView = headerView
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.viewController = self
        viewModel.uploadData(url: "https://run.mocky.io/v3/85c6f01f-2412-4795-8af8-ed13a6fcce1d")
        setupConstraints()
    }
    
    func setDataInArray(_ arrayData: [DataTask]) {
        self.arrayData = arrayData
        self.tableView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        navigationController?.navigationBar.barTintColor = .systemGray6
        navigationController?.view.backgroundColor = .systemGray6
        categoryView.dataSource = self
        categoryView.delegate = self
        categoryView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func setupConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        let mainQueue = DispatchQueue.main
        let model = arrayData[indexPath.row]
        let fileURL = viewModel.createDirectoryURLForFile(fileName: model.name)
        cell.productName.text = model.name
        cell.productDescription.text = model.description
        cell.price.setTitle("от \(model.price) р", for: .normal)
        cell.product = model.product
        if let data = try? Data(contentsOf: fileURL) {
            mainQueue.async {
                cell.imagesView.image = UIImage(data: data)
            }
        } else {
            DispatchQueue.global(qos: .utility).async { [weak self] in
                let data = self?.viewModel.loadDataImage(url: model.image, fileName: model.name)
                guard let data = data else {return}
                let image = UIImage(data: data)
                mainQueue.async {
                    cell.imagesView.image = image
                }
            }
        }
        if indexPath.row == 0, cell.product == "pizza" {
            cell.layer.cornerRadius = 30
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.clipsToBounds = true
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return categoryView
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerHeght = headerView.bounds.maxY
        let tableOffsetY = tableView.contentOffset.y
        if tableOffsetY > headerHeght + 20 {
            categoryView.layer.shadowRadius = 5
            categoryView.layer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
            categoryView.layer.shadowOffset = CGSize(width: 0, height: 10)
            categoryView.layer.shadowOpacity = 0.1
            categoryView.clipsToBounds = false
        } else if tableOffsetY < headerHeght + 20 {
            categoryView.layer.shadowRadius = .zero
            categoryView.layer.shadowColor = .none
            categoryView.layer.shadowOffset = .zero
            categoryView.layer.shadowOpacity = .zero
            categoryView.clipsToBounds = true
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let model = arrayCategory[indexPath.row]
        cell.title.text = model
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        cell.name.backgroundColor = #colorLiteral(red: 1, green: 0.8048674464, blue: 0.5050531626, alpha: 1)
        cell.title.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        switch indexPath.row {
        case 0:
            let index = arrayData.firstIndex { data in
                data.product == "pizza"
            }
            guard let index = index else {return}
            self.tableView.scrollToRow(at: [0, index], at: .top, animated: true)
        case 1:
            let index = arrayData.firstIndex { data in
                data.product == "combo"
            }
            guard let index = index else {return}
            self.tableView.scrollToRow(at: [0, index], at: .top, animated: true)
        case 2:
            let index = arrayData.firstIndex { data in
                data.product == "desert"
            }
            guard let index = index else {return}
            self.tableView.scrollToRow(at: [0, index], at: .top, animated: true)
        case 3:
            let index = arrayData.firstIndex { data in
                data.product == "drink"
            }
            guard let index = index else {return}
            self.tableView.scrollToRow(at: [0, index], at: .top, animated: true)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        if ((collectionView.indexPathsForSelectedItems?.contains(indexPath)) != nil)  {
            cell.name.backgroundColor = .systemGray6
            cell.title.font = UIFont.systemFont(ofSize: 13)
        }
    }
    
}

