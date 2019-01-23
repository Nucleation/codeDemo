//
//  ViewController.swift
//  code
//
//  Created by zhishen－mac on 2018/6/1.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let path: String = Bundle.main.path(forResource: "LJPlist", ofType: "plist") ?? ""
    var dataArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArr = NSArray(contentsOfFile: path) as? [String] ?? []
        self.tableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataArr.count)
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tbCell")
        cell?.textLabel?.text = dataArr[indexPath.row]
        return cell ?? UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let textFieldView = TextTieldViewController()
            self.navigationController?.pushViewController(textFieldView, animated: true)
        }else if indexPath.row == 1{
            let login = LoginViewViewController()
            self.navigationController?.pushViewController(login, animated: true)
        }else if indexPath.row == 2{
            let login = TextViewViewController()
            self.navigationController?.pushViewController(login, animated: true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

