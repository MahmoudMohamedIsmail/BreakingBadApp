//
//  Dictionary+Extension.swift

import Foundation

extension Dictionary{
    
    func convertTo<T: Decodable>(_ type: T.Type)->T? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }

        do {
            let model = try? JSONDecoder().decode(T.self, from: jsonData)
            return model
        }
    }
    
}
