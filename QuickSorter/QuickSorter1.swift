//
//  QuickSorter1.swift
//  QuickSorter
//
//  Created by Chris William Sehnert on 2/28/18.
//  Copyright © 2018 InSehnDesigns. All rights reserved.
//

import UIKit

struct QuickSorter1 {
    
    var tenThou: [String]?
    
    func readDataFromFile(file:String) -> String! {
        guard let filepath = Bundle.main.path(forResource: file, ofType: "txt")
            else {
                return nil
        }
        return filepath
    }
    
    func pivotCounter(array: inout [Int]) -> Int {
        
        var pivotCount = 0 //1 - array.count
        
        func partitioner (unsortedArray: inout [Int], leftIndex: Int, rightIndex: Int) -> Int {
            let medianIndex = medianFinder(unsortedArray: &unsortedArray, leftIndex: leftIndex, rightIndex: rightIndex)
            let pivot = unsortedArray[medianIndex]
            var partitionIndex = leftIndex + 1
            let steps = (rightIndex - leftIndex)
            pivotCount += steps
            let pivotIndex = leftIndex + 1
            unsortedArray.swapAt(leftIndex, medianIndex)
            for j in pivotIndex...rightIndex {
                if unsortedArray[j] < pivot {
                    unsortedArray.swapAt(partitionIndex, j)
                    partitionIndex += 1
                }
            }
            // move pivot to "rightful" index...
            unsortedArray.swapAt(leftIndex, partitionIndex - 1)
            
            return partitionIndex
        }
        
        func quickSort(unsortedArray: inout [Int], zeroIndex: Int, lastIndex: Int) {
            if lastIndex == 0 {return} // if initial array has only 1 element...
            let p = partitioner(unsortedArray: &unsortedArray, leftIndex: zeroIndex, rightIndex: lastIndex)
            if zeroIndex + 2 < p {
                let last = (p - 2)
                quickSort(unsortedArray: &unsortedArray, zeroIndex: zeroIndex, lastIndex: last)
            }
            if lastIndex > p {
                quickSort(unsortedArray: &unsortedArray, zeroIndex: p, lastIndex: lastIndex)
            }
        }
        
        func medianFinder(unsortedArray: inout [Int], leftIndex: Int, rightIndex: Int) -> Int {
            var medianIndex: Int = 0
            let subArrayLength: Int = rightIndex - leftIndex + 1
            let isOdd =  subArrayLength % 2 != 0
            if  isOdd {
                medianIndex = (subArrayLength / 2) + leftIndex
            } else {
                medianIndex = ((subArrayLength / 2) - 1) + leftIndex
            }
            
            let pivotSet = (left: unsortedArray[leftIndex], right: unsortedArray[rightIndex], median: unsortedArray[medianIndex])
            
            let medianValue = [pivotSet.left, pivotSet.right, pivotSet.median].sorted()[1]
            switch medianValue {
            case pivotSet.left:
                return leftIndex
            case pivotSet.median:
                return medianIndex
            case pivotSet.right:
                return rightIndex
            default:
                break
            }
            return medianIndex
        }
        
        quickSort(unsortedArray: &array, zeroIndex: 0, lastIndex: array.count - 1)
        return pivotCount
    }
}


























