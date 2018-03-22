//
//  LoginTask.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Birthday: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let year = "year"
    static let month = "month"
    static let day = "day"
  }

  // MARK: Properties
  public var year: Int?
  public var month: Int?
  public var day: Int?
    
    public init(day: Int?, month: Int?, year: Int?) {
        self.day = day
        self.month = month
        self.year = year
    }
    
  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    year = json[SerializationKeys.year].int
    month = json[SerializationKeys.month].int
    day = json[SerializationKeys.day].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = year { dictionary[SerializationKeys.year] = value }
    if let value = month { dictionary[SerializationKeys.month] = value }
    if let value = day { dictionary[SerializationKeys.day] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.year = aDecoder.decodeObject(forKey: SerializationKeys.year) as? Int
    self.month = aDecoder.decodeObject(forKey: SerializationKeys.month) as? Int
    self.day = aDecoder.decodeObject(forKey: SerializationKeys.day) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(year, forKey: SerializationKeys.year)
    aCoder.encode(month, forKey: SerializationKeys.month)
    aCoder.encode(day, forKey: SerializationKeys.day)
  }

}
