//
//  MountainInfoViewController.swift
//  MountainMan
//
//  Created by Jake Mnich on 5/1/17.
//  Copyright © 2017 Jake Mnich. All rights reserved.
//

import UIKit

class MountainInfoViewController: UIViewController {
    @IBOutlet weak var mountainLabel: UILabel!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var feetLabel: UILabel!
    @IBOutlet weak var acreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    let mapViewController = MapViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let randomMountain = Int(arc4random_uniform(UInt32(mapViewController.mountainArray.count - 1)))
        let mountain = mapViewController.mountainArray[randomMountain]
        mountainLabel.text = mountain["title"] as! String
        townLabel.text = mountain["subtitle"] as! String
        feetLabel.text = ""
        acreLabel.text = ""
        priceLabel.text = ""
        
        
    }

    
    
    
    


}
