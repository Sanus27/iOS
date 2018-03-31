//
//  ChatController.swift
//  Sanus
//
//  Created by Luis on 03/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class MessengerDrController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableData: UITableView!
    private var listItems = [Contact]()
    private var uid: String = ""
    private var model = MessengeDrModel()
    private var getRef:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData.delegate = self
        tableData.dataSource = self
        self.getRef = Firestore.firestore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showData()
    }
    
    private func showData(){
        self.model.showData( getRef:self.getRef, completionHandler: { resp in
            self.listItems.removeAll()
            self.tableData.reloadData()
            self.listItems = self.model.listItems
            self.tableData.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableData.dequeueReusableCell( withIdentifier: "cell", for: indexPath ) as! MessageDrCell
        let contact:Contact
        contact = listItems[indexPath.row]
        cell.txtPaciente?.text = contact.nombre!
        cell.avatar.layer.masksToBounds = false
        cell.online.layer.cornerRadius = cell.online.frame.height / 2
        cell.online.clipsToBounds = true
        if contact.estado == "1"{
            cell.online.backgroundColor = UIColor.green
        }
        
        if let urlFoto = contact.avatar {
            Storage.storage().reference(forURL: urlFoto).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                if let error = error?.localizedDescription {
                    print("fallo al traer imagenes", error)
                    cell.avatar?.image = #imageLiteral(resourceName: "user")
                } else {
                    cell.avatar?.image = UIImage(data: data!)
                    cell.avatar.layer.masksToBounds = false
                    cell.avatar.layer.cornerRadius = cell.avatar.frame.height / 2
                    cell.avatar.clipsToBounds = true
                    cell.avatar.layer.borderWidth = 1
                }
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goMessengerDoctor", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goMessengerDoctor" {
            if let id = tableData.indexPathForSelectedRow {
                let fila = listItems[id.row]
                let destino = segue.destination as! MessegeClientController
                destino.showMessenger = fila.autor
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
}
