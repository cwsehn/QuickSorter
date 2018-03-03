//
//  ViewController.swift
//  QuickSorter
//
//  Created by Chris William Sehnert on 2/28/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var arrayMaker = QuickSorter1()
    var path: String?
    var fileContent: String?
    var tester = [1, 2, 3, 4, 5, 6, 7, 8]
    var tester2 = [1001, 2, 55, 777, 1028, 17, 28888, 16, 97]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        path = arrayMaker.readDataFromFile(file: "QuickSort")
        arrayMaker.tenThou = try? getLineArrayFromFile(fileName: path!)
        arrayMaker.tenThou?.removeLast()
        let arrayLength = arrayMaker.tenThou?.count
        print("arrayLength: \(String(describing: arrayLength))")
        let first = arrayMaker.tenThou![0]
        print("the first number in the array: \(first)")
        
        if let preparedArray = arrayMaker.tenThou {
            var tenThouArray = integerMaker(inputArray: preparedArray)
            print("First Integer before Sort: \(tenThouArray[0])")
            let result = arrayMaker.pivotCounter(array: &tenThouArray)
            print("Result: \(result) FirstArrayMemberAfterSort: \(tenThouArray[0])")
        }
        
        let test = arrayMaker.pivotCounter(array: &tester)
        let test2 = arrayMaker.pivotCounter(array: &tester2)
        print("Tester Result: \(test) Tester2 Result: \(test2)")
    }
    
    private func getLineArrayFromFile(fileName: String) throws -> Array<String> {
        if path == nil {
            throw ImportError.FileNotFound
        }
        var lineArray: Array<String>?
        do {
            let content = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            lineArray = content.components(separatedBy: "\n")
            
        }catch{
            throw ImportError.CouldntGetArray
        }
        
        return lineArray!
    }
    
    private func integerMaker(inputArray: [String]) -> [Int] {
        var outputArray: [Int] = []
        
        for entry in inputArray {
            var trimmed = entry
            trimmed.removeLast()
            if let integer = Int.init(trimmed) {
                outputArray.append(integer)
            }
        }
        return outputArray
    }
}

enum ImportError: Error {
    case FileNotFound
    case CouldntGetArray
}






