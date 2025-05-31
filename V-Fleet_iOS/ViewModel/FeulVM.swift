//
//  FeulVM.swift
//  V-Fleet_iOS
//
//  Created by Bishwajit Kumar on 25/07/24.
//

import Foundation

class FeulVM: NSObject {
    var requestModel = FeulRequestModel()
    var apiService = AuthenticationApiServices()
    var responseModel: FeulResponseModel?
    var postFuelDetailsRequestModel = PostFuelDetailsRequestModel()
    var postFuelDetailsResponseModel : AttandanceResponseModel?

    func getVehicleInfoAtRefueling(vehicleId: Int,completion: @escaping ApiResponseCompletion) {
        apiService.getVehicleInfoAtRefueling(vehicleId: vehicleId) { result in
            switch result {
            case .success(let response):
                
                print("response::", response)
                if let jsonString = String(data: response.data as? Data ?? Data(), encoding: .utf8) {
                    print("Result Data JSON String: \(jsonString)")
                    
                } else {
                    print("Failed to convert resultData to String.")
                }
                guard let data = response.data as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: "Data not found.")))
                    return
                }
                do {
                    self.responseModel = try JSONDecoder().decode(FeulResponseModel.self, from: data)
                    completion(.success(response))
                } catch {
                    print("Error decoding data: ", error.localizedDescription)
                    completion(.failure(ApiResponseErrorBlock(message: "\(error.localizedDescription).")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postFuelDetails(userId: String,completion: @escaping ApiResponseCompletion) {
      let params = postFuelDetailsRequestModel.dictionary
        apiService.postFuelDetails(userId: userId, parameters: params) { result in
            switch result {
            case .success(let response):
                print("response::", response)
                guard let data = response.data as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: "Data not found.")))
                    return
                }
                do {
                    self.postFuelDetailsResponseModel = try JSONDecoder().decode(AttandanceResponseModel.self, from: data)
                    completion(.success(response))
                } catch {
                    print("Error decoding data: ", error.localizedDescription)
                    completion(.failure(ApiResponseErrorBlock(message: "\(error.localizedDescription).")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
