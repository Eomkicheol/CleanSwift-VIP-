//
//  LoginViewController.swift
//  CleanSwift(VIP)
//
//  Created by Steve JobsOne on 4/14/20.
//  Copyright (c) 2020 Steve JobsOne. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginDisplayLogicDelegate: class {
    func loginStatus(viewModel: Login.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogicDelegate {
    
    
    var interactorDelegate: LoginBusinessLogicDelegate?
    var routerDelegate: (NSObjectProtocol & LoginRoutingLogicDelegate & LoginDataPassingDelegate)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactorDelegate = interactor
        viewController.routerDelegate = router
        interactor.presenterDelegate = presenter
        presenter.viewControllerDelegate = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = routerDelegate, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.text = "vccfrontend1@qaaw.ga"
        passwardTextField.text = "123456Abc@mobio"
        
    }
    
    // MARK:- LogIn
    
    // MARK: LogonInfo
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwardTextField: UITextField!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.login(request: Login.Request(userID: userNameTextField.text, password: passwardTextField.text))
    }
    
    func login(request: Login.Request) {
       
        let indecator = Loader.sharedInstance
        indecator.showIndicator()
        interactorDelegate?.loginRequestWith(request: request)
    }
    
    func loginStatus(viewModel: Login.ViewModel) {
        
        switch viewModel.success {
        case true:
            //showLoaderIs(hidden: false)
            break
            
        default:
            print(viewModel.success)
            break
        }
    }
}