//
//  ChatController.swift
//  Sanus
//
//  Created by Luis on 03/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class ChatController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableData: UITableView!
    var getRef:Firestore!
    var ref:DocumentReference!
    var listItems = [Contact]()
    var uid: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData.delegate = self
        tableData.dataSource = self
        getRef = Firestore.firestore()
        self.uid = (Auth.auth().currentUser?.uid)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.listItems.removeAll()
        self.tableData.reloadData()
        showData()
    }
    
    private func showData(){

        self.getRef.collection("contactos").whereField("autor", isEqualTo: self.uid ).getDocuments { (result, error) in
            if let error = error {
                print("se ha producido un error \(error)")
            } else {

                self.listItems.removeAll()
                self.tableData.reloadData()
                
                for doc in result!.documents {
                    let id = doc.documentID
                    let valCont = doc.data()
                    let author = valCont["autor"] as? String
                    let doctor = valCont["doctor"] as? String

                    self.ref = Firestore.firestore().collection("usuarios").document( doctor! )
                    self.ref.getDocument { (resp, error) in
                        if let error = error {
                            print("se ha producido un error \(error)")
                        } else {

                            if let resp = resp {
                                let valUser = resp.data()
                                var avatar = valUser!["avatar"] as? String
                                let name = valUser!["nombre"] as? String
                                let lastname = valUser!["apellido"] as? String
                                let estado = valUser!["estado"] as? String
                                avatar = "gs://sanus-27.appspot.com/avatar/" + avatar!
                                let contact = Contact( id:id, avatar:avatar!, autor:author!, doctor:doctor!, nombre:name!, apellidos: lastname!, estado:estado! )
                                self.listItems.append(contact)
                                self.tableData.reloadData()
                            }

                        }
                    }

                }
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableData.dequeueReusableCell( withIdentifier: "cell", for: indexPath ) as! ChatCell
        let contact:Contact
        contact = listItems[indexPath.row]
        cell.txtNameUser?.text = contact.nombre!
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
        performSegue(withIdentifier: "goMessengerPacient", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goMessengerPacient" {
            if let id = tableData.indexPathForSelectedRow {
                let fila = listItems[id.row]
                let destino = segue.destination as! MessegeClientController
                destino.showMessenger = fila.doctor
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
}
