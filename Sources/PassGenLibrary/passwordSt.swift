//
//  File.swift
//  
//
//  Created by Luiz Sena on 21/03/22.
//

import Foundation
import ArgumentParser

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

public struct passwordSt: ParsableCommand {
    
    public static var configuration = CommandConfiguration(commandName: "passgen")
    
    @Option(name: NameSpecification.shortAndLong, help: "Size of password")
    var size: Int
    @Option(name: NameSpecification.shortAndLong, help: "Name to be assigned to password")
    var pass_name: String
    
    public init() { }
    
    public func run() throws {
        var password = ""
        
        while true{
            
            if size < 8 {
                print(error)
                print("\nThe password length cannot be less than 8")
                break
            }else if size > 32 {
                print(error)
                print("\nThe password length cannot be less than 32")
                break
            }else{
                print(message, terminator: "")
                while validadePassword(password: password) != 4 {
                    password = randomString(length: size)
                }
                print("\n\nYour password \(pass_name) is \(password)", terminator: "")
                print("\nYour password to \((Double(validadePassword(password: password))/4)*100)" + "% of force\n")
                createFile()
                writeFile(pass_name: pass_name, password: password)
                let filePath = NSHomeDirectory() + "/senhas.txt"
                do{
                    let testing = try String(contentsOf: URL(fileURLWithPath: filePath))
                    print(testing)
                }catch{
                    print(error)
                }
                break
            }
        }
    }
    
}
