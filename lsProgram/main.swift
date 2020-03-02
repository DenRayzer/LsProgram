//
//  main.swift
//  lsProgram
//
//  Created by Елизавета on 02.03.2020.
//  Copyright © 2020 Елизавета. All rights reserved.
//

import Foundation

var a = readLine()?.split(separator: " ")
var isHiddenFilesSkip = true

if a?.count == 1 { a?.append(" ") }
if a?[1] == "-a" { isHiddenFilesSkip = false }

extension FileManager {
    func urls(for directory: FileManager.SearchPathDirectory, skipsHiddenFiles: Bool = isHiddenFilesSkip ) -> [URL]? {
        let documentsURL = NSURL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let fileURLs = try? contentsOfDirectory(at: documentsURL as URL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
        
        return fileURLs
    }
}

if a?[1] != "-l" { for i in FileManager.default.urls(for: .documentDirectory)! { print(i.lastPathComponent) } }

if a?[1] == "-l" {
    for i in FileManager.default.urls(for: .documentDirectory)! {
        let attributes = try FileManager.default.attributesOfItem(atPath: i.path)
        print("""
            \(i.lastPathComponent)
            OwnerAccountName:  \(attributes[.ownerAccountName]!)
            FileSize:          \(attributes[.size]!)
            CreationDate:      \(attributes[.creationDate]!)
            
            ----------------------
            
            """) }
}
