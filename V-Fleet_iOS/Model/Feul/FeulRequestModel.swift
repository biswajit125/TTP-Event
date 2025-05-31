//
//  FeulRequestModel.swift
//  V-Fleet_iOS
//
//  Created by Bishwajit Kumar on 25/07/24.
//

import Foundation


struct FeulRequestModel: Codable {
//    var date : String?
//    var time : String?
    var vehicleId : Int?
    // Method to validate the properties
   
    var validationMsg: String? {
//        if date == nil {
//            return "Date is required"
//        }
//        if time == nil {
//            return "Date is required"
//        }
        if vehicleId == nil {
            return "Date is required"
        }
        return nil
    }
    
    
}

struct PostFuelDetailsRequestModel: Codable {
    var vehicleId: Int?
    var odoValue : Double?
    var prevOdoValue : Double?
    var diffOdoValue: Int?
    var quantity: Int?
    var mileage : Double?
    var prevMileage: Double?
    var superCompanyId: Int?
    var companyId: Int?
    var location: String?
    var vehicleNumber: String?
    
    var validationMsg: String? {
        // Check if required fields are nil
        if vehicleId == nil {
            print("Vehicle ID is missing.")
          
        }

        if odoValue == nil {
            print("ODO value is missing.")
            
        }

        if prevOdoValue == nil {
            print("Previous ODO value is missing.")
         
        }

        if quantity == nil {
            print("Quantity is missing.")
           
        }

        if mileage == nil {
            print("Mileage is missing.")
           
        }

        if prevMileage == nil {
            print("Previous mileage is missing.")
           
        }

        if superCompanyId == nil {
            print("Super company ID is missing.")
           
        }

        if companyId == nil {
            print("Company ID is missing.")
           
        }

        if location == nil || location?.isEmpty == true {
            print("Location is missing or empty.")
            
        }

        if vehicleNumber == nil || vehicleNumber?.isEmpty == true {
            print("Vehicle number is missing or empty.")
           
        }

        // All required fields are valid
        return nil
    }

    
    
}
