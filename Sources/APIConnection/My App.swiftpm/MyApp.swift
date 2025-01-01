import SwiftUI

import Combine
import Foundation

class APIConnectionTester: ObservableObject {
    @Published var responseData: String = ""
    private let apiKey = "30023952" // Replace with your actual API key
    private let baseURLString = "https://api.openmetrolinx.com/OpenDataAPI/api/V1/Gtfs/Feed/TripUpdates"
    
    func testAPIConnection() {
        guard let url = URL(string: "\(baseURLString)?key=\(apiKey)") else {
            print("Invalid URL")
            DispatchQueue.main.async {
                self.responseData = "Invalid URL"
            }
            return
        }
        
        print("URL: \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.responseData = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                DispatchQueue.main.async {
                    self?.responseData = "Invalid response"
                }
                return
            }
            
            print("HTTP Response Status Code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Server error: \(httpResponse.statusCode)")
                DispatchQueue.main.async {
                    self?.responseData = "Server error: \(httpResponse.statusCode)"
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    self?.responseData = "No data"
                }
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
                DispatchQueue.main.async {
                    self?.responseData = "Response: \(responseString)"
                }
            } else {
                print("Unable to parse response")
                DispatchQueue.main.async {
                    self?.responseData = "Unable to parse response"
                }
            }
        }
        
        task.resume()
    }
}

