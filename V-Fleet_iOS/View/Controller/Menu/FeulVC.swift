//
//  FeulVC.swift
//  V-Fleet_iOS
//
//  Created by Bishwajit Kumar on 19/07/24.
//

import UIKit
import DropDown
import CoreLocation

class FeulVC: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblVehicleNumber: UILabel!
    @IBOutlet weak var txtFildQuentity: UITextField!
    
    let dropDown = DropDown()
    let viewModel = FeulVM()
    var diffOdoValue: Int = 0
    var mileage: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = "Namaste, \(UserAttandanceData.shared.driverName)"
        lblVehicleNumber.text = UserAttandanceData.shared.vehicleNumber
        
        print("driverName::",UserAttandanceData.shared.driverName)
        print("vehicleNumber::",UserAttandanceData.shared.vehicleNumber)

        lblName.font = AppFont.bold.fontWithSize(18)
        
        if let currentOdometer = viewModel.responseModel?.data?.currentOdometer,
           let previousOdometer = viewModel.responseModel?.data?.previousOdometer {
            diffOdoValue = Int(currentOdometer - previousOdometer)
        } else {
            diffOdoValue = 0 // Handle the case where one or both values are nil
        }
        if let quantityText = txtFildQuentity.text, let quantity = Double(quantityText) {
            mileage = Double(diffOdoValue) / quantity
        } else {
            mileage = 0 // Handle invalid or missing quantity input
        }
        print("diffOdoValue:", diffOdoValue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.txtFildQuentity.text = ""
        super.viewWillAppear(animated)
        getVehicleInfoAtRefueling(date: currentDate, time: currentTime, vehicleId: UserAttandanceData.shared.vehicleId)
    }
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    var currentTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss" // Use 24-hour format
        let timeString = dateFormatter.string(from: Date())
        
        // URL-encode the time string
        let allowedCharacterSet = CharacterSet(charactersIn: ":").inverted
        let encodedTimeString = timeString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? timeString
        
        return encodedTimeString
    }
    
    func setUpRequestModel() {
        guard let currentOdometer = viewModel.responseModel?.data?.currentOdometer,
              let previousOdometer = viewModel.responseModel?.data?.previousOdometer,
              let quantityText = txtFildQuentity.text, let quantity = Int(quantityText) else {
            return // Handle the case where values are missing
        }
        
        viewModel.postFuelDetailsRequestModel = PostFuelDetailsRequestModel(
            vehicleId: UserAttandanceData.shared.vehicleId,
            odoValue: currentOdometer,
            prevOdoValue: previousOdometer,
            diffOdoValue: diffOdoValue,
            quantity: quantity,
            mileage: mileage,
            prevMileage: viewModel.responseModel?.data?.previousMileage,
            superCompanyId: UserAttandanceData.shared.superCompanyID,
            companyId: UserAttandanceData.shared.companyID,
            location: viewModel.responseModel?.data?.location,
            vehicleNumber: UserAttandanceData.shared.vehicleNumber
        )
    }
    
    @IBAction func actionMenuBtn(_ sender: UIButton) {
        //        dropDown.dataSource = ["Attendance History", "Logout"]
        //        dropDown.anchorView = sender
        //        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        //        dropDown.show()
        //        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
        //            guard let self = self else { return }
        //            if index == 0 {
        //                self.moveToNext(AttendanceVC.typeName, storyBoard: StoryBoard.main)
        //            }
        //        }
        
//        var menuItems = ["Logout"]
//        
//        if AppCache.shared.currentUser?.data?.access?.fleet == true {
//            menuItems.insert("Attendance History", at: 0)
//        }
//        
//        dropDown.dataSource = menuItems
//        dropDown.anchorView = sender
//        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
//        dropDown.show()
//        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
//            guard let self = self else { return }
//            if item == "Attendance History" {
//                self.moveToNext(AttendanceHistoryVC.typeName, storyBoard: StoryBoard.main)
//            } 
//            else if item == "Logout" {
//                RootControllerProxy.shared.setRoot(LoginVC.typeName)
//            }
//        }
        
        
        var menuItems = ["Logout"]
         
         // Removed the condition for adding "Attendance History"
         
         dropDown.dataSource = menuItems
         dropDown.anchorView = sender
         dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
         dropDown.show()
         dropDown.selectionAction = { [weak self] (index: Int, item: String) in
             guard let self = self else { return }
             if item == "Logout" {
                 RootControllerProxy.shared.setRoot(LoginVC.typeName)
             }
         }
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
        
        // Validate if txtFildQuentity is empty or has a value of 0
        //          if let quantityText = txtFildQuentity.text, quantityText.isEmpty {
        //              self.showAlert(title: AppConstants.appName, message: "Quantity field cannot be empty")
        //              return
        //          } else if let quantityValue = Int(txtFildQuentity.text ?? ""), quantityValue <= 0 {
        //              self.showAlert(title: AppConstants.appName, message: "Please enter a valid quantity")
        //              return
        //          }
        //
        //          // Check if the current odometer value is 0 and show an alert if true
        //          if let currentOdometer = self.viewModel.responseModel?.data?.currentOdometer, currentOdometer == 0 {
        //              self.showAlert(title: AppConstants.appName, message: "Data is not submitted as device is not active")
        //              return
        //          }
        //
        //          // Set up request model
        //          setUpRequestModel()
        //
        //          // Check if there is any validation message and show alert if present
        //          if let msg = viewModel.postFuelDetailsRequestModel.validationMsg {
        //              self.showAlert(title: AppConstants.appName, message: msg)
        //              return
        //          }
        //
        //          // Implement submit action
        //          self.postFuelDetails(userId: "\(UserAttandanceData.shared.userId)")
        //    }
        
        // Remove leading and trailing whitespace from txtFildQuentity text
        let trimmedQuantityText = txtFildQuentity.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Validate if the trimmed quantityText is empty or has a value of 0
        if let quantityText = trimmedQuantityText, quantityText.isEmpty {
            self.showAlert(title: AppConstants.appName, message: "Quantity field cannot be empty")
            return
        } else if let quantityValue = Int(trimmedQuantityText ?? ""), quantityValue <= 0 {
            self.showAlert(title: AppConstants.appName, message: "Please enter a valid quantity"){_ in 
                self.txtFildQuentity.text = ""
            }
            
            return
        }
        
        // Check if the current odometer value is 0 and show an alert if true
        if let currentOdometer = self.viewModel.responseModel?.data?.currentOdometer, currentOdometer == 0 {
            self.showAlert(title: AppConstants.appName, message: "Data is not submitted as device is not active"){_ in 
                self.txtFildQuentity.text = ""
            }
            return
        }
        
        // Set up request model
        setUpRequestModel()
        
        // Check if there is any validation message and show alert if present
        if let msg = viewModel.postFuelDetailsRequestModel.validationMsg {
            self.showAlert(title: AppConstants.appName, message: msg)
            return
        }
        
        // Implement submit action
        self.postFuelDetails(userId: "\(UserAttandanceData.shared.userId)")
    }


}

// MARK: - API METHODS
extension FeulVC {
    func getVehicleInfoAtRefueling(date: String, time: String, vehicleId: Int) {
        CustomLoader.shared.show()
        viewModel.getVehicleInfoAtRefueling(vehicleId: vehicleId) { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(let response):
                
               // self?.showAlert(title: AlertsNames.error.rawValue, message: self?.viewModel.responseModel?.message)
                if response.status == 404 {
                   
                    self?.showAlert(title: AppConstants.appName, message: self?.viewModel.responseModel?.message )
                  
//                    if let jsonString = String(data: response.data as? Data ?? Data(), encoding: .utf8) {
//                        print("Result Data JSON String: \(jsonString)")
//                        self?.showAlert(title: AlertsNames.error.rawValue, message: response.))
//                    } else {
//                        print("Failed to convert resultData to String.")
//                    }
                }
             
            case .failure(let error):
                self?.showAlert(title: AlertsNames.error.rawValue, message: error.message)
            }
        }
    }
    
    
    func postFuelDetails(userId: String) {
        CustomLoader.shared.show()
        viewModel.postFuelDetails(userId: userId) { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(let response):
                print("success")
                
                DispatchQueue.main.async {
                    self?.showAlert(title: AppConstants.appName, message: self?.viewModel.postFuelDetailsResponseModel?.message) { _ in
                        self?.txtFildQuentity.text = ""
                    }
                }
               // self?.showAlert(title: AlertsNames.error.rawValue, message: self?.viewModel.postFuelDetailsResponseModel?.message)
                print("response::", response)
            case .failure(let error):
                self?.showAlert(title: AlertsNames.error.rawValue, message: error.message)
            }
        }
    }
}
extension FeulVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.txtFildQuentity {
            if string.contains(" ") {
                return false
            }
        }
        return true
    }
}
