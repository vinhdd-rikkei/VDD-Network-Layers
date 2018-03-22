//
//  LoginTask.swift
//  TestNetworkLayers
//
//  Created by vinhdd on 3/21/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON

public final class User: ModelProtocol, NSCoding {
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let supportMailUnreadCount = "supportMailUnreadCount"
        static let name = "name"
        static let bloodCode = "bloodCode"
        static let profileImage = "profileImage"
        static let isMailAddress = "isMailAddress"
        static let age = "age"
        static let bloodString = "bloodString"
        static let birthday = "birthday"
        static let buyTimes = "buyTimes"
        static let loginStatusString = "loginStatusString"
        static let mailUnreadCount = "mailUnreadCount"
        static let isMemberContentsFullMode = "isMemberContentsFullMode"
        static let areaCode = "areaCode"
        static let code = "code"
        static let loginStatus = "loginStatus"
        static let bannerCode = "bannerCode"
        static let comment = "comment"
        static let telAuth = "telAuth"
        static let registrationDate = "registrationDate"
        static let areaString = "areaString"
        static let point = "point"
        static let mailAddress = "mailAddress"
    }
    
    // MARK: Properties
    public var supportMailUnreadCount: Int?
    public var name: String?
    public var bloodCode: String?
    public var profileImage: String?
    public var isMailAddress: Bool? = false
    public var age: Int?
    public var bloodString: String?
    public var birthday: Birthday?
    public var buyTimes: Int?
    public var loginStatusString: String?
    public var mailUnreadCount: Int?
    public var isMemberContentsFullMode: Bool? = false
    public var areaCode: String?
    public var code: Int?
    public var loginStatus: Int?
    public var bannerCode: String?
    public var comment: String?
    public var telAuth: Bool? = false
    public var registrationDate: String?
    public var areaString: String?
    public var point: Int?
    public var mailAddress: String?
    
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
        supportMailUnreadCount = json[SerializationKeys.supportMailUnreadCount].int
        name = json[SerializationKeys.name].string
        bloodCode = json[SerializationKeys.bloodCode].string
        profileImage = json[SerializationKeys.profileImage].string
        isMailAddress = json[SerializationKeys.isMailAddress].boolValue
        age = json[SerializationKeys.age].int
        bloodString = json[SerializationKeys.bloodString].string
        birthday = Birthday(json: json[SerializationKeys.birthday])
        buyTimes = json[SerializationKeys.buyTimes].int
        loginStatusString = json[SerializationKeys.loginStatusString].string
        mailUnreadCount = json[SerializationKeys.mailUnreadCount].int
        isMemberContentsFullMode = json[SerializationKeys.isMemberContentsFullMode].boolValue
        areaCode = json[SerializationKeys.areaCode].string
        code = json[SerializationKeys.code].int
        loginStatus = json[SerializationKeys.loginStatus].int
        bannerCode = json[SerializationKeys.bannerCode].string
        comment = json[SerializationKeys.comment].string
        telAuth = json[SerializationKeys.telAuth].boolValue
        registrationDate = json[SerializationKeys.registrationDate].string
        areaString = json[SerializationKeys.areaString].string
        point = json[SerializationKeys.point].int
        mailAddress = json[SerializationKeys.mailAddress].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = supportMailUnreadCount { dictionary[SerializationKeys.supportMailUnreadCount] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = bloodCode { dictionary[SerializationKeys.bloodCode] = value }
        if let value = profileImage { dictionary[SerializationKeys.profileImage] = value }
        dictionary[SerializationKeys.isMailAddress] = isMailAddress
        if let value = age { dictionary[SerializationKeys.age] = value }
        if let value = bloodString { dictionary[SerializationKeys.bloodString] = value }
        if let value = birthday { dictionary[SerializationKeys.birthday] = value.dictionaryRepresentation() }
        if let value = buyTimes { dictionary[SerializationKeys.buyTimes] = value }
        if let value = loginStatusString { dictionary[SerializationKeys.loginStatusString] = value }
        if let value = mailUnreadCount { dictionary[SerializationKeys.mailUnreadCount] = value }
        dictionary[SerializationKeys.isMemberContentsFullMode] = isMemberContentsFullMode
        if let value = areaCode { dictionary[SerializationKeys.areaCode] = value }
        if let value = code { dictionary[SerializationKeys.code] = value }
        if let value = loginStatus { dictionary[SerializationKeys.loginStatus] = value }
        if let value = bannerCode { dictionary[SerializationKeys.bannerCode] = value }
        if let value = comment { dictionary[SerializationKeys.comment] = value }
        dictionary[SerializationKeys.telAuth] = telAuth
        if let value = registrationDate { dictionary[SerializationKeys.registrationDate] = value }
        if let value = areaString { dictionary[SerializationKeys.areaString] = value }
        if let value = point { dictionary[SerializationKeys.point] = value }
        if let value = mailAddress { dictionary[SerializationKeys.mailAddress] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.supportMailUnreadCount = aDecoder.decodeObject(forKey: SerializationKeys.supportMailUnreadCount) as? Int
        self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
        self.bloodCode = aDecoder.decodeObject(forKey: SerializationKeys.bloodCode) as? String
        self.profileImage = aDecoder.decodeObject(forKey: SerializationKeys.profileImage) as? String
        self.isMailAddress = aDecoder.decodeBool(forKey: SerializationKeys.isMailAddress)
        self.age = aDecoder.decodeObject(forKey: SerializationKeys.age) as? Int
        self.bloodString = aDecoder.decodeObject(forKey: SerializationKeys.bloodString) as? String
        self.birthday = aDecoder.decodeObject(forKey: SerializationKeys.birthday) as? Birthday
        self.buyTimes = aDecoder.decodeObject(forKey: SerializationKeys.buyTimes) as? Int
        self.loginStatusString = aDecoder.decodeObject(forKey: SerializationKeys.loginStatusString) as? String
        self.mailUnreadCount = aDecoder.decodeObject(forKey: SerializationKeys.mailUnreadCount) as? Int
        self.isMemberContentsFullMode = aDecoder.decodeBool(forKey: SerializationKeys.isMemberContentsFullMode)
        self.areaCode = aDecoder.decodeObject(forKey: SerializationKeys.areaCode) as? String
        self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? Int
        self.loginStatus = aDecoder.decodeObject(forKey: SerializationKeys.loginStatus) as? Int
        self.bannerCode = aDecoder.decodeObject(forKey: SerializationKeys.bannerCode) as? String
        self.comment = aDecoder.decodeObject(forKey: SerializationKeys.comment) as? String
        self.telAuth = aDecoder.decodeBool(forKey: SerializationKeys.telAuth)
        self.registrationDate = aDecoder.decodeObject(forKey: SerializationKeys.registrationDate) as? String
        self.areaString = aDecoder.decodeObject(forKey: SerializationKeys.areaString) as? String
        self.point = aDecoder.decodeObject(forKey: SerializationKeys.point) as? Int
        self.mailAddress = aDecoder.decodeObject(forKey: SerializationKeys.mailAddress) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(supportMailUnreadCount, forKey: SerializationKeys.supportMailUnreadCount)
        aCoder.encode(name, forKey: SerializationKeys.name)
        aCoder.encode(bloodCode, forKey: SerializationKeys.bloodCode)
        aCoder.encode(profileImage, forKey: SerializationKeys.profileImage)
        aCoder.encode(isMailAddress, forKey: SerializationKeys.isMailAddress)
        aCoder.encode(age, forKey: SerializationKeys.age)
        aCoder.encode(bloodString, forKey: SerializationKeys.bloodString)
        aCoder.encode(birthday, forKey: SerializationKeys.birthday)
        aCoder.encode(buyTimes, forKey: SerializationKeys.buyTimes)
        aCoder.encode(loginStatusString, forKey: SerializationKeys.loginStatusString)
        aCoder.encode(mailUnreadCount, forKey: SerializationKeys.mailUnreadCount)
        aCoder.encode(isMemberContentsFullMode, forKey: SerializationKeys.isMemberContentsFullMode)
        aCoder.encode(areaCode, forKey: SerializationKeys.areaCode)
        aCoder.encode(code, forKey: SerializationKeys.code)
        aCoder.encode(loginStatus, forKey: SerializationKeys.loginStatus)
        aCoder.encode(bannerCode, forKey: SerializationKeys.bannerCode)
        aCoder.encode(comment, forKey: SerializationKeys.comment)
        aCoder.encode(telAuth, forKey: SerializationKeys.telAuth)
        aCoder.encode(registrationDate, forKey: SerializationKeys.registrationDate)
        aCoder.encode(areaString, forKey: SerializationKeys.areaString)
        aCoder.encode(point, forKey: SerializationKeys.point)
        aCoder.encode(mailAddress, forKey: SerializationKeys.mailAddress)
    }
    
    func printInformation() {
        print("- name: \(self.name ?? "nil")")
        print("- point: \(self.point ?? -1)")
        print("- mail: \(self.mailAddress ?? "nil")")
        print("- age: \(self.age ?? -1)")
    }
}
