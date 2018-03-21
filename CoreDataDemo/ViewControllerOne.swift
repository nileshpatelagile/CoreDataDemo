//
//  ViewControllerOne.swift
//  CoreDataDemo
//
//  Created by agilemac-19 on 3/21/18.
//  Copyright © 2018 agilemac-19. All rights reserved.
//

import UIKit

class ViewControllerOne: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.dataSource = self
        self.tblView.delegate = self
        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
