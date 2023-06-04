// Copyright © 2017-2018 Trust.
//
// This file is part of Trust. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import BigInt
import Foundation

public struct EIP712_Function: Equatable, CustomStringConvertible {
    public var name: String
    public var parameters: [EIP712_ABIType]
    
    public init(name: String, parameters: [EIP712_ABIType]) {
        self.name = name
        self.parameters = parameters
    }
    
    /// Casts the arguments into the appropriate types for this function.
    ///
    /// - Throws:
    ///   - `ABIError.invalidArgumentType` if a value doesn't match the expected type.
    ///   - `ABIError.invalidNumberOfArguments` if the number of values doesn't match the number of parameters.
    public func castArguments(_ values: [Any]) throws -> [EIP712_ABIValue] {
        if values.count != parameters.count {
            throw EIP712_ABIError.invalidNumberOfArguments
        }
        return try zip(parameters, values).map({ try EIP712_ABIValue($1, type: $0) })
    }
    
    /// Function signature
    public var description: String {
        let descriptions = parameters.map({ $0.description }).joined(separator: ",")
        return "\(name)(\(descriptions))"
    }
}

