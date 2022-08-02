//
//  ImportCSV_Route.swift
//  Freemix
//
//  Created by Adam Socki on 8/2/22.
//

import Foundation

struct Route: Identifiable {
    var shape_id: String = ""
    var shape_pt_lat: String = ""
    var shape_pt_lon: String = ""
    var shape_pt_sequence: String = ""
    var shape_dist_traveled: String = ""
    var id = UUID()
    
    init(raw: [String]) {
        shape_id = raw[0]
        shape_pt_lat = raw[1]
        shape_pt_lon = raw[2]
        shape_pt_sequence = raw[3]
        shape_dist_traveled = raw[4]
    }
}


func loadCSV(from csvName: String) -> [Route] {
    var csvToStruct = [Route]()
    
    //locate csv file
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
        print("Located")
        return[]
        
    }
    
    // convert the contents of the file into one very long string
    var data = ""
    do {
        data = try String(contentsOfFile: filePath)
    } catch {
        print(error)
        return []
    }
    
    // split the struct in to a array of "rows" of data. Each row is a string
    // detect "/n" carrage return, then split
    var rows = data.components(separatedBy: "\n")
    
    // remove header rows
    // count the number of header colunmsn before removing
    let columnCount = rows.first?.components(separatedBy: ",").count
    rows.removeFirst()
    
    // now loop around each row and split into columns
    for row in rows {
        let csvColumns = row.components(separatedBy: ",")
        if csvColumns.count == columnCount {
            let routeStruct = Route.init(raw: csvColumns)
            csvToStruct.append(routeStruct)
        }
    }
    
    return csvToStruct
    
}
