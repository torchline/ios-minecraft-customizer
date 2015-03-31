//
//  MCCResourcePack.swift
//  Minecraft Customizer
//
//  Created by Brad Walker on 3/29/15.
//  Copyright (c) 2015 Torchline Technology. All rights reserved.
//


class ResourcePack {
	private let archive: ZZArchive
	
	init(url: NSURL) {
		self.archive = ZZArchive(URL: url, error: nil)
	}
	
	func dataForKey(key: String) -> NSData? {
		return self.entryForKey(key)?.newDataWithError(nil)
	}
	
	func imageForKey(key: String) -> UIImage? {
		let data = self.dataForKey(key)
		return data != nil ? UIImage(data: data!) : nil
	}
	
	private func entryForKey(key: String) -> ZZArchiveEntry? {
		return self.entriesByKey[key]
	}
	
	lazy private var entriesByKey: [String: ZZArchiveEntry] = {
		let entries = self.archive.entries as! [ZZArchiveEntry]
		var entriesByKey = [String: ZZArchiveEntry]()
		
		for entry in entries {
			if entry.fileName != nil {
				entriesByKey[entry.fileName] = entry
			}
		}
		
		return entriesByKey
		}()
}
