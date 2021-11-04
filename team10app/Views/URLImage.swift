

import Foundation
import SwiftUI
import UIKit
import Combine

extension String {
  
  func load() -> UIImage {
    
    do {
      
      guard let url = URL(string: self) else {
        
        return UIImage()
        
      }
      
      let data: Data = try Data(contentsOf: url)
      
      return UIImage(data: data) ?? UIImage()
      
    } catch {
      
      
     
    }
    
    return UIImage()
    
  }
  
}
