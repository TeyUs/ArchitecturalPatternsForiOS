//
//  CharacterCell.swift
//  ArchitecturalPatterns
//
//  Created by Teyhan Uslu on 11.06.2024.
//

import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {
    static let identifier = "CharacterCell"

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(_ character: CharacterItem) {
        if let strUrl = character.image {
            let imageURL = URL(string: strUrl)
            characterImage.kf.setImage(with: imageURL)
        }
        nameLabel.text = "Name: \(character.name.orEmpty)"
        statusLabel.text = "Status: \((character.status?.rawValue).orEmpty)"
        typeLabel.text = "Type: \(character.type.orEmpty)"
        
    }
}



extension Optional where Wrapped == String {
    var orEmpty: String {
        if self == nil {
            return ""
        } else {
            return self!
        }
    }
}
//
//#Preview {
//    let cell = CharacterCell()
//    let character = CharacterItem(id: nil, name: "Citadel of Ricks", status: .unknown, species: nil, type: "Fish-Person", gender: nil, origin: nil, location: nil, image: "https://rickandmortyapi.com/api/character/avatar/21.jpeg", episode: nil, url: nil, created: nil)
//    cell.configureCell(character)
//    return cell
//}
