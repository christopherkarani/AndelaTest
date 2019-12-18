//
//  EntryTest.swift
//  andelaTests
//
//  Created by Chris Karani on 12/18/19.
//  Copyright © 2019 Chris Karani. All rights reserved.
//

import XCTest
import Foundation



    let exampleData = """
        {
    "count":681,
    "entries":[
       {
          "API":"Cat Facts",
          "Description":"Daily cat facts",
          "Auth":"",
          "HTTPS":true,
          "Cors":"no",
          "Link":"https://alexwohlbruck.github.io/cat-facts/",
          "Category":"Animals"
       },
       {
          "API":"Cats",
          "Description":"Pictures of cats from Tumblr",
          "Auth":"apiKey",
          "HTTPS":true,
          "Cors":"unknown",
          "Link":"https://docs.thecatapi.com/",
          "Category":"Animals"
       },
       {
          "API":"Dogs",
          "Description":"Based on the Stanford Dogs Dataset",
          "Auth":"",
          "HTTPS":true,
          "Cors":"yes",
          "Link":"https://dog.ceo/dog-api/",
          "Category":"Animals"
       }]}
""".data(using: .utf8)


