//
//  BViperWireframe.swift
//  GuardianProToDo
//
//  Created by Alim Yıldız on 4/27/22.
//

import UIKit
//import ObjectMapper

open class BViperWireframe: NSObject {
    
    private var baseName: String!
    private var projectName: String!
    
    public var presenter: BViperPresenter!
    public var controller: BViperViewController!
    public var interactor: BViperInteractor!
    
    private func configureModele(data:Any? = nil){
        presenter.data = data
        interactor.presenter = presenter
        presenter.interactor = interactor as? BViperInteractorInput
        presenter.view = controller
        presenter.wireFrame = self
        controller.presenter = presenter
    }
    
    //MARK: Router
    public required init(dataValue: Any? = nil, modelName:String? = nil) {
        super.init()
        let val = dataValue
        
      /*  if let modelName = modelName , let dataValue = dataValue as? [String:Any] {
            let modelClass = NSClassFromString(modelName) as! Mappable.Type
            val = modelClass.init(JSON: dataValue)
        }*/
        
        projectName = self.description.components(separatedBy: ".")[0].replacingOccurrences(of: "<", with: "")
        
        baseName = String(describing: type(of: self)).replacingOccurrences(of: UIConstant.wireFrameName, with: "")

        interactor = (initBase(name: UIConstant.interactorBaseName) as! BViperInteractor.Type).init()
        presenter = (initBase(name: UIConstant.presenterBaseName) as! BViperPresenter.Type).init()
        controller = (initBase(name: UIConstant.controllerBaseName) as! BViperViewController.Type).init()
        controller.pageData = dataValue
        
        self.configureModele(data: val)
    }
    
    private func initBase(name:String) -> AnyClass {
        
        let classNames = projectName.appending(".").appending(baseName).appending(name)
        return NSClassFromString(classNames)!
    }
}

extension BViperWireframe: BViperWireFrameInterface {
    
    @objc open func showController(fromController: UIViewController) {
        NavigationManager.pushViewController(from: fromController, to: controller)
    }
}
