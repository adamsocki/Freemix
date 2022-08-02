//
//  ImportCSV_Stops.swift
//  Freemix
//
//  Created by Adam Socki on 8/2/22.
//

import Foundation

struct Stops: Identifiable {
    var stop_id: String = ""
    var stop_code: String = ""
    var stop_name: String = ""
    var stop_desc: String = ""
    var stop_lat: String = ""
    var stop_lon: String = ""
    var zone_id: String = ""
    var stop_url: String = ""
    var wheelchair_boarding: String = ""
    var id = UUID()
    
    init(raw: [String]) {
        stop_id = raw[0]
        stop_code = raw[1]
        stop_name = raw[2]
        stop_desc = raw[3]
        stop_lat = raw[4]
        stop_lon = raw[5]
        zone_id = raw[6]
        stop_url = raw[7]
        wheelchair_boarding = raw[8]
    }
    
}

func loadCSV(from csvName: String) -> [Stops] {
    var csvToStruct = [Stops]()
    
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
            let stopStruct = Stops.init(raw: csvColumns)
            csvToStruct.append(stopStruct)
        }
    }
    
    return csvToStruct
    
}
