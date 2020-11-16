//
//  HomeViewController.swift
//  heme.tv
//
//  Created by Alvaro Hernandez Melo on 11/11/20.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

enum ProviderType: String {
    case basic
    case google
}

class HomeViewController: UIViewController {
    
    /*
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var closeSessionButton: UIButton!*/
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var closeSessionButton: UIButton!
    
    private let email: String
    private let provider: ProviderType
    
    
    init(email: String, provider: ProviderType){
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Inicio"
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        emailLabel.text = email
        providerLabel.text = provider.rawValue
        // Do any additional setup after loading the view.
        
        // Guardar los datos del usuario
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider.rawValue, forKey: "provider")
        defaults.synchronize()
    }
    
    
    @IBAction func closeSessionButtonAction(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        defaults.synchronize()
        
        
        switch provider {
        case .basic:
            firebaseLogOut()
        case .google:
            GIDSignIn.sharedInstance()?.signOut()
            firebaseLogOut()
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    private func firebaseLogOut() {
        do {
            try Auth.auth().signOut()

        }catch{
            // se ha producido un error
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
