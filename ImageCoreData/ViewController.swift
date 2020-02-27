//
//  ViewController.swift
//  ImageCoreData
//
//  Created by Osvaldo Murillo on 2/26/20.
//  Copyright © 2020 Osvaldo Murillo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class ViewController: UIViewController {
    var imageUrl: String = ""
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let shareInstance = DataBaseHelper()
    
    @IBOutlet weak var imgPokemon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        getInfo()
        // Do any additional setup after loading the view.
    }
    
    func getInfo(){
        let url = "https://pokeapi.co/api/v2/pokemon-form/25/"
        request(url, method: .get).responseJSON {
            response in
            debugPrint(response)
            if response.result.isSuccess {
                let a: JSON = JSON(response.result.value!)
                let info = a["sprites"]
                self.imageUrl = info["back_default"].stringValue
                if let data = NSData(contentsOf: NSURL(string:self.imageUrl )! as URL) {
                    print(data)
                    DataBaseHelper.shareInstance.saveImage(data: data as Data)
                    let arr = DataBaseHelper.shareInstance.fetchImage()
                    self.imgPokemon.image = UIImage(data: arr[0].img!)
                }
                print(self.imageUrl)
            }
        }
    }
    

}

