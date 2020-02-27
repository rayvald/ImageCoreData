//
//  DataBaseHelper.swift
//  ImageCoreData
//
//  Created by Osvaldo Murillo on 2/27/20.
//  Copyright © 2020 Osvaldo Murillo. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataBaseHelper {
    
    static let shareInstance = DataBaseHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveImage(data: Data) {
        let imageInstance = Image(context: context)
        imageInstance.img = data
        do {
            try context.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage() -> [Image] {
        var fetchingImage = [Image]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [Image]
        } catch {
            print("Error while fetching the image")
        }
        return fetchingImage
    }
    
    
}
