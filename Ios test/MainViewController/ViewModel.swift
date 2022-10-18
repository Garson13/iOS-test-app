//
//  ViewModel.swift
//  Ios test
//
//  Created by Гарик on 18.10.2022.
//

import Foundation
import CoreData


protocol ViewControllerProtocol: AnyObject {
    func setDataInArray(_ arrayData: [DataTask])
}

protocol ViewModelProtocol: AnyObject {
    var viewController: ViewControllerProtocol? {get set}
    var coreData: CoreDataFoodTest {get set}
    func loadDataImage(url: String, fileName: String) -> Data?
    func createDirectoryURLForFile(fileName: String) -> URL
    func uploadData(url: String)
}

class ViewModel: ViewModelProtocol {
    
    var coreData: CoreDataFoodTest = CoreDataFoodTest()
    
    
    weak var viewController: ViewControllerProtocol?
    
    
    func loadDataImage(url: String, fileName: String) -> Data? {
        uploadFileInCaches(url: url, fileName: fileName)
        let url = URL(string: url)
        guard let url = url else {return nil}
        let data = try? Data(contentsOf: url)
        return data
    }
    
    func createDirectoryURLForFile(fileName: String) -> URL {
        let cachePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let filesPath = cachePath.appendingPathComponent("Files")
        try? FileManager.default.createDirectory(at: filesPath, withIntermediateDirectories: false, attributes: nil)
        let fileURL = filesPath.appendingPathComponent(fileName)
        return fileURL
    }
    
    func uploadFileInCaches(url: String?, fileName: String) {
        let fileURL = createDirectoryURLForFile(fileName: fileName)
            guard let url = url else { return }
            guard let url2 = URL(string: url) else { return  }
            let request = URLRequest(url: url2)
            let task = URLSession.shared.downloadTask(with: request) { localURL, _, _ in
                guard let localURL = localURL else { return }
                do {
                    try FileManager.default.copyItem(at: localURL, to: fileURL)
                } catch let error {
                    print("Copy Error: \(error.localizedDescription)")
                }
        }
        task.resume()
    }
    
    func uploadData(url: String) {
        let url = URL(string: url)
        guard let url = url else {return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, resp, error in
            guard let data = data else {
                if let fetchedObjects = self?.coreData.resultController.fetchedObjects {
                    let arrayData = fetchedObjects.map({ foods in
                        DataTask(sort: foods.sort, name: foods.productName, product: foods.product, description: foods.descriptionProduct, price: foods.price, image: foods.image)
                    })
                    DispatchQueue.main.async {
                        self?.viewController?.setDataInArray(arrayData)
                    }
                }
                return
            }
            if let fetcedObjects = self?.coreData.resultController.fetchedObjects {
                fetcedObjects.forEach { foods in
                    self?.coreData.persistentContainer.viewContext.delete(foods)
                }
            }
            
            do {
                let datas = try JSONDecoder().decode(Products.self, from: data)
                datas.products.forEach { datas in
                    let object = Foods.init(entity: NSEntityDescription.entity(forEntityName: "Foods", in: (self?.coreData.persistentContainer.viewContext)!)!, insertInto: self?.coreData.persistentContainer.viewContext)
                    object.productName = datas.name
                    object.product = datas.product
                    object.descriptionProduct = datas.description ?? ""
                    object.price = datas.price
                    object.image = datas.image
                    object.sort = datas.sort
                }
                try? self?.coreData.persistentContainer.viewContext.save()
                DispatchQueue.main.async {
                    self?.viewController?.setDataInArray(datas.products)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
