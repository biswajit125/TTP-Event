//
//  LoginResponseModel.swift
//  Vstock
//
//  Created by iTechnolabs - 7 on 03/07/23.
//

import Foundation
// MARK: - LoginResponseModel
struct LoginResponseModel: Codable {
    var data: DataClass?
    var message: String?
    var status: Int?
}

// MARK: - DataClass
struct DataClass: Codable {
    var role: String?
    var access: Access?
    var mobile: String?
    var accountNotExpired, enabled: Bool?
    var superCompanyName: String?
    var companyID, driverID: Int?
    var shiftStatus: Bool?
    var name: String?
    var superCompanyID, id: Int?
    var email: String?
    var attendanceStatus: Bool?
    var username: String?

    enum CodingKeys: String, CodingKey {
        case role, access, mobile
        case accountNotExpired = "account_not_expired"
        case enabled, superCompanyName
        case companyID = "companyId"
        case driverID = "driverId"
        case shiftStatus, name
        case superCompanyID = "superCompanyId"
        case id, email, attendanceStatus, username
    }
}

// MARK: - Access
struct Access: Codable {
    var fleet, fuel, expense: Bool?
}

//// MARK: - GetVehicleByVehicleNumberResponseModel
//struct GetVehicleByVehicleNumberResponseModel: Codable {
//    var data: GetVehicleByVehicleNumberData?
//    var message: String?
//    var status: Int?
//}
//
//// MARK: - DataClass
//struct GetVehicleByVehicleNumberData: Codable {
//    var id: Int?
//    var vehicleNumber: String?
//    var model, noOfWheel, capacity: Int?
//    var qrCode: [Int]?
//    var active: Bool?
//    var superCompanyID, companyID: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, vehicleNumber, model, noOfWheel, capacity, qrCode, active
//        case superCompanyID = "superCompanyId"
//        case companyID = "companyId"
//    }
//}

// MARK: - GetVehicleByVehicleNumberResponseModel
struct GetVehicleByVehicleNumberResponseModel: Codable {
    let data: GetVehicleByVehicleNumberData?
    let message: String?
    let status: Int?
}

// MARK: - DataClass
struct GetVehicleByVehicleNumberData: Codable {
    let id: Int?
    let vehicleNumber: String?
    let model, noOfWheel: Int?
    let capacity: Double?
    let qrCode: [Int]?
    let active: Bool?
    let superCompanyID, companyID: Int?

    enum CodingKeys: String, CodingKey {
        case id, vehicleNumber, model, noOfWheel, capacity, qrCode, active
        case superCompanyID = "superCompanyId"
        case companyID = "companyId"
    }
}
