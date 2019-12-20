//
//  ViewController.swift
//  Teste
//
//  Created by MacBook on 18/12/19.
//  Copyright © 2019 Filipe. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Global variable for array json
    var dadosJson: [Table] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    //MARK: -  function running in background for reading JSON
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        if let url = URL(string: "https://cefis.com.br/api/v1/event") {
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, requisicao, erro) in
                
                if erro == nil {
                    
                    if let dadosRetorno = dados {
                        
                        do {
                            
                            if let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: .mutableContainers)
                                as? [String: Any] {
                                
                                if let brl = objetoJson["data"] as? Array<Any> {
                                    for item in brl {
                                        print(brl)
                                    }
                                }
                            }
                        } catch{
                                self.displayMessage(userMessage: "Estamos tendo problemas de conexão. Tente novamente.")
                        }
                    }
                    
                }
            }
            tarefa.resume()
        }
    }
    
    
    //MARK: - Configuration tableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dadosJson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dados: Table = dadosJson[indexPath.row]
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath) as! CellTabel
        
        celula.label1.text = dados.labe1
        celula.label2.text = dados.label2
        
        return celula
    }
    
    //MARK: - Function for alert user
    func displayMessage(userMessage: String) -> Void {
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: "Alerta", message: userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default)
            {
                (action:UIAlertAction!) in
                print ("Ok button tapped")
                DispatchQueue.main.async {
                    //  self.dismiss(animated: true, completion: nil)
                }
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
