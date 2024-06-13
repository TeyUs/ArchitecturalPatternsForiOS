//
//  ViewController.swift
//  ArchitecturalPatterns
//
//  Created by Teyhan Uslu on 11.06.2024.
//

import UIKit

class GreeterViewController: UIViewController {
    let service = NetworkService()

    @IBAction func MVCTapped(_ sender: Any) {
        let vc = MVCViewController()
        vc.service = service
        self.show(vc, sender: nil)
    }
    
    @IBAction func MVPTapped(_ sender: Any) {
        let vc = MVPViewController()
        let presenter = MVPPresenter(service: service, view: vc)
        vc.presenter = presenter
        self.show(vc, sender: nil)
        
    }
    
    @IBAction func MVVMTapped(_ sender: Any) {
        let vc = MVVMViewController()
        let viewModel = MVVMViewModel(service: service)
        vc.viewModel = viewModel
        self.show(vc, sender: nil)
    }
    
    @IBAction func VIPERTapped(_ sender: Any) {
        let vc = VIPERRouter(service: service).build()
        self.show(vc, sender: nil)
    }
}
