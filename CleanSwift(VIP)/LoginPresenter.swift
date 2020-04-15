//
//  LoginPresenter.swift
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

protocol LoginPresentationLogicDelegate {
  func login(response: Login.Response)
}

class LoginPresenter: LoginPresentationLogicDelegate {
    
   
    
   
   
   
  weak var viewControllerDelegate: LoginDisplayLogicDelegate?
  
  // MARK: 
  
    func login(response: Login.Response) {
        let viewModel = Login.ViewModel(success:response.success)
        viewControllerDelegate?.loginStatus(viewModel: viewModel)
    }
       

}
