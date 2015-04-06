//
//  FREST.swift
//  Minecraft Customizer
//
//  Created by Brad Walker on 4/4/15.
//  Copyright (c) 2015 Torchline Technology. All rights reserved.
//

import Foundation

class FREST
{
	let baseURL: NSURL
	let requestQueue = NSOperationQueue.mainQueue()
	
	init(baseURL: NSURL) {
		self.baseURL = baseURL
	}
	
	func fetchResource(name: String, id: String, completion: (Dictionary<String, AnyObject>?) -> Void) {
		self.fetchResource(name, id: id, fields: nil, completion: completion)
	}
	
	func fetchResource(name: String, id: String, fields: [String]?, completion: (Dictionary<String, AnyObject>?) -> Void) {
		let document = name.stringByAppendingPathComponent(id)
		let url = self.baseURL.URLByAppendingPathComponent(document)
		let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)!

		if let validFields = fields {
			let joinedFields = ",".join(validFields)
			let queryItem = NSURLQueryItem(name: "fields", value: joinedFields)
			components.queryItems = [queryItem]
		}
		
		let request = NSURLRequest(URL: components.URL!)
		
		self.sendRequest(request, completion: { (dictionary) -> Void in
			var resource: Dictionary<String, AnyObject>? = nil
			if let validDictionary = dictionary {
				resource = validDictionary["response"] as? Dictionary<String, AnyObject>
			}
			
			completion(resource)
		})
	}
	
	internal func sendRequest(request: NSURLRequest, completion: (Dictionary<String,AnyObject>?) -> Void) {
		NSURLConnection.sendAsynchronousRequest(request, queue: self.requestQueue) { (response, data, error) -> Void in
			let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
			if let dictionary = json as? Dictionary<String, AnyObject> {
				completion(dictionary)
			}
			else {
				completion(nil)
			}
		}
	}
}
