//
//  ViewController.swift
//  SQliteDemo
//
//  Created by darshan on 03/02/18.
//  Copyright © 2018 darshan. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    var db : OpaquePointer?

    @IBOutlet var textFieldName: UITextField!
    @IBOutlet var textFieldTask: UITextField!

    @IBAction func saveButton(_ sender: Any) {
        
        let name = textFieldName.text?.trimmingCharacters(in : .whitespacesAndNewlines)
        let task = textFieldTask.text?.trimmingCharacters(in : .whitespacesAndNewlines)
        
        if (name?.isEmpty)! {
            print("enter your name")
            return;
        }
        
        if (task?.isEmpty)! {
            print("enter your task")
            return;
        }
        
        var stmt: OpaquePointer?
        
        let insertQuery = "INSERT INTO Task (name,task) VALUES (?,?)"
        
        
        if sqlite3_prepare(db, insertQuery, -1, &stmt,nil) != SQLITE_OK {
             print("Error insert query")
        }
        
        if sqlite3_bind_text(stmt,1,name,-1,nil) != SQLITE_OK {
            print("Error in bind name")
        }
        
        if sqlite3_bind_text(stmt,1,task,-1,nil) != SQLITE_OK {
            print("Error in bind task")
        }
        
       if sqlite3_step(stmt) == SQLITE_DONE {
            
            print("Value enter succesfully")
        }
    }
    
    
 
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //create sqlite file
        
        let fileURL = try?
            FileManager.default.url(for: .userDirectory
            , in: .userDomainMask, appropriateFor: nil
            , create: false).appendingPathComponent("taskDb.sqlite")
    
        if sqlite3_open(fileURL?.path,&db) != SQLITE_OK {
            print("Error OPening Database")
            return;
        }
        
        let createTabelQuery = "CREATE TABLE IF NOT EXISTS Task (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, task TEXT)"
        
        if sqlite3_exec(db, createTabelQuery, nil, nil, nil) != SQLITE_OK {
        
            print("error creating table")
            return;
        }
        
        print("ok200")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

