//
//  FileManager + Extension.swift
//  Bookworm
//
//  Created by NAM on 2023/09/06.
//


import UIKit

extension UIViewController {

  
    func saveImageToDocument(fileName: String, image: UIImage) {
       
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        //3. 이미지 -> 데이터로 변환
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        // 압축률 정의 가능, 원본 데이터의 크기가 클 때는 resizing 가능..!
        
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
        
    }
    
    
    func loadImageFromDocument(fileName: String) -> UIImage {
     
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "star.fill")! }
     
        
     
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        //경로를 명시했으나 이미지가 없는경우도 처리해줘야한다..! ( 잘못된 경로 입력 등.. )
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return UIImage(systemName: "star.fill")!
        }
        
        
    }
    
    
    func removeImageFromDocument(fileName: String) {
      
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
      
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
        
        
    }
    
}
