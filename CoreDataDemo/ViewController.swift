//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by agilemac-19 on 3/20/18.
//  Copyright © 2018 agilemac-19. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var manageObjectContext : NSManagedObjectContext!
    let imageView : UIImageView! = UIImageView()
    var persons = [Person]()
    @IBOutlet var tblView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.loadData()
    }
    
    fileprivate func setupNavigationBar() {
        let leftBarButton : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAction(_:)))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.tblView.rowHeight = UITableViewAutomaticDimension
        self.tblView.estimatedRowHeight = 44
        
        self.navigationItem.title = "List Of Users"
    }
    

    @IBAction func buttonAction(_ sender : AnyObject) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picker.dismiss(animated: true, completion: {
                self.createRepresetItem(image)
            })
        }
    }
    
    func createRepresetItem(_ image : UIImage) {
        let personItem = Person(context: manageObjectContext)
        personItem.image = UIImageJPEGRepresentation(image, 0.3)
        
        let inputAlert : UIAlertController = UIAlertController(title: "Add", message: "Add new friend.", preferredStyle: .alert)
        
        inputAlert.addTextField { (textField) in
            textField.placeholder = "Person"
        }
        inputAlert.addTextField { (textField) in
            textField.placeholder = "Gift"
        }
        
        inputAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            let personTextField = inputAlert.textFields?.first
            let giftTextField = inputAlert.textFields?.last
            
            if personTextField?.text != "" && giftTextField?.text != "" {
                personItem.name = personTextField?.text
                personItem.mobile = giftTextField?.text
                
                do {
                    try self.manageObjectContext.save()
                    self.persons.append(personItem)
                    self.tblView.reloadData()
                }catch {
                    print("Could not save data \(error.localizedDescription)")
                }
            }
            
        }))
        inputAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        self.present(inputAlert, animated: true, completion: nil)
    }
    
    fileprivate func loadData() {
        let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
        
        do{
            persons = try self.manageObjectContext.fetch(fetchRequest)
            tblView.reloadData()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PersonCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PersonCell
        cell.txtName.text = persons[indexPath.row].name
        cell.txtMobile.text = persons[indexPath.row].mobile
        cell.imgView.image = UIImage(data: persons[indexPath.row].image!)
        return cell
    }
  
}



class PersonCell: UITableViewCell {
    
    @IBOutlet var txtName : UILabel!
    @IBOutlet var txtMobile : UILabel!
    @IBOutlet var imgView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func updateCell() {
        
    }
    
    
}
