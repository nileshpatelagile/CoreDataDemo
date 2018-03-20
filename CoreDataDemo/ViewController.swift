//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by agilemac-19 on 3/20/18.
//  Copyright © 2018 agilemac-19. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var manageObjectContext : NSManagedObjectContext!
    let imageView : UIImageView! = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "1.jpeg")
        
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        self.createRepresetItem()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func createRepresetItem() {
        let personItem = Person(context: manageObjectContext)
        
        personItem.image = UIImagePNGRepresentation(imageView.image!)
        personItem.name = "Nilesh"
        personItem.mobile = "9636373449"
        
        do {
            try self.manageObjectContext.save()
        }catch {
            print(error.localizedDescription)
        }
    }
    

    @IBAction func buttonAction(_ sender : AnyObject) {
        let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
        
        do{
            let presrnt = try self.manageObjectContext.fetch(fetchRequest)
            print(presrnt.first?.name)
            print(presrnt.first?.mobile)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

