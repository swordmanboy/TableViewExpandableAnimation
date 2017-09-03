//
//  MainViewController.swift
//  TableViewExpandableAnimation
//
//  Created by Apinun Wongintawang on 9/3/17.
//  Copyright © 2017 Apinun Wongintawang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var models : NSArray! = NSArray.init()
    var expands : [Bool]! = []
    
    override func loadView() {
        super.loadView()
        //init data
        let numberOfSection : Int! = 10
        let numberOfData : Int! = 20
        expands = []
        let models : NSMutableArray! = NSMutableArray.init()
        for section in 0..<numberOfSection{
            let mainData : NSMutableArray! = NSMutableArray.init()
            for row in 0..<numberOfData{
                let strData : String! = "data " + String(section) + " " + String(row)
                mainData.insert(strData, at: mainData.count)
            }
            models.insert(mainData, at: models.count)
            expands.append(false)
        }
        
        
        self.models = models.copy() as! NSArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MainViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = models[section] as? NSArray
        return data == nil ? 0 : data!.count
    }
    
    func handleTap(getureRecognizer : UIGestureRecognizer){
        if let tagNumber = getureRecognizer.view?.tag{
            self.expands[tagNumber] = !self.expands[tagNumber]
        }
        
        //key word for animation
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.expands[indexPath.section]{
            return 45
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        label.text = "    Section" + String(section)
        label.tag = section
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.handleTap(getureRecognizer:))))
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib.init(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MainTableViewCell{
            let textData =  (self.models[indexPath.section] as! NSArray)[indexPath.row] as! String
            cell.labelTitle.text = textData
            return cell
        }else{
            return UITableViewCell.init()
        }
    }
}
