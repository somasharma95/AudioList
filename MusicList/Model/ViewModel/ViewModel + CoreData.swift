//
//  ViewModel + CoreData.swift
//  MusicList
//
//  Created by Apple on 24/01/22.
//

import Foundation
import CoreData
import UIKit

extension SongsViewModel  {
    
    func downloadSong(url: String, completion : @escaping ((Bool)->Void)) {
        var audioTrack: Data?
        guard let audioUrl = URL(string: url) else {
            completion(false)
            return
            
        }
        do {
               audioTrack = try Data(contentsOf: audioUrl)
           } catch {
               print(error.localizedDescription)
               completion(false)
           }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: ViewConstants.entity, in: managedContext)!
     
        let song = NSManagedObject(entity: entity, insertInto: managedContext)
        song.setValue(audioTrack, forKey: ViewConstants.keyName)
        song.setValue(url, forKey: ViewConstants.urlKey)
        
        do {
            try managedContext.save()
            completion(true)
        }
        catch let error as NSError {
            completion(false)
            print(error.userInfo)
        }
        
    }
    
   
    
    func fetchSongs(url:String) -> Bool {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return false}
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ViewConstants.entity)
        request.predicate = NSPredicate(format: "url = %@", url)
        request.returnsObjectsAsFaults = false
        do {
                   let result = try managedContext.fetch(request)
                   for data in result as! [NSManagedObject] {
                       if let urls = data.value(forKey: "url") as? String {
                       print(urls)
                       let data = data.value(forKey: "audio") as? Data
                       downloadedSongs.append(urls)
                       musicDictionary[urls] = data
                       }
                       return true
                 }
                   
               } catch {
                   
                   print("Failed")
               }
        return false
    }
    
    func currentlyPlaying() -> String? {
           return song
       }
    
}
