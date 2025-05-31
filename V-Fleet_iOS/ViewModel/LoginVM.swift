//
//  LoginVM.swift
//  PocketITNerd
//
//  Created by ashish mehta on 11/10/22.
//

import Foundation

class LoginVM: NSObject {
    var requestModel = LoginRequestModel()
    var apiService = AuthenticationApiServices()
    var responseModel: LoginResponseModel?
    var alertMessage = ""
    
    func login(completion: @escaping ApiResponseCompletion) {
        let params = requestModel.dictionary
        apiService.login(params) { result in
            switch result {
            case .success(let response):
                if let jsonString = String(data: response.data as? Data ?? Data(), encoding: .utf8) {
                    print("Result Data JSON String: \(jsonString)")
                    self.alertMessage = response.message
                    print("message::",response.message)
                    
                } else {
                    print("Failed to convert resultData to String.")
                }
                
                print("response111:: ", response.data as Any)
                guard let data = response.data as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: "Data not found.")))
                    return
                }
                do {
                    self.responseModel = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                   AppCache.shared.currentUser = self.responseModel
                    
                    let attendanceStatus = self.responseModel?.data?.attendanceStatus ?? false
                    let shiftStatus = self.responseModel?.data?.shiftStatus ?? false
                    
                    UserDefaultsManager.shared.saveValue(attendanceStatus, forKey: .attendance_Status)
                    UserDefaultsManager.shared.saveValue(shiftStatus, forKey: .shift_Status)
                
                    //Get value from userdefault
                    if let currentUser = AppCache.shared.currentUser {
                        let attendanceStatus = currentUser.data?.attendanceStatus ?? false
                        let shiftStatus = currentUser.data?.shiftStatus ?? false
                        print("attendanceStatus :: LoginVM>>> ", attendanceStatus)
                        print("shiftStatus :: LoginVM>>> ", shiftStatus)
                    }
                    
                    completion(.success(response))
                 
                    
                } catch {
                    print("Error decoding data: ", error.localizedDescription)
                    completion(.failure(ApiResponseErrorBlock(message: "\(response.message).")))
                }
 
                print("data::",data)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
//    func login(completion: @escaping ApiResponseCompletion) {
//        let params = requestModel.dictionary
//        apiService.login(params) { result in
//            switch result {
//            case .success(let response):
//                if let jsonString = String(data: response.data as? Data ?? Data(), encoding: .utf8) {
//                    print("Result Data JSON String: \(jsonString)")
//                    self.alertMessage = response.message
//                    print("message::", response.message)
//                } else {
//                    print("Failed to convert resultData to String.")
//                }
//
//                print("response111:: ", response.data as Any)
//                guard let data = response.data as? Data else {
//                    completion(.failure(ApiResponseErrorBlock(message: "Data not found.")))
//                    return
//                }
//                do {
//                    self.responseModel = try JSONDecoder().decode(LoginResponseModel.self, from: data)
//                    AppCache.shared.currentUser = self.responseModel
//
//                    let attendanceStatus = self.responseModel?.data?.attendanceStatus ?? false
//                    let shiftStatus = self.responseModel?.data?.shiftStatus ?? false
//
//                    UserDefaultsManager.shared.saveValue(attendanceStatus, forKey: .attendance_Status)
//                    UserDefaultsManager.shared.saveValue(shiftStatus, forKey: .shift_Status)
//
//                    completion(.success(response))
//                } catch {
//                    print("Error decoding data: ", error.localizedDescription)
//                    completion(.failure(ApiResponseErrorBlock(message: "\(response.message).")))
//                }
//
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }

}
