//
//  ViewController.swift
//  andela
//
//  Created by Chris Karani on 12/18/19.
//  Copyright © 2019 Chris Karani. All rights reserved.
//

import UIKit

// a ViewContorller displaying the list of results from the API
class EntriesCollectionViewController: UICollectionViewController {

    // data source
    var entries = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        setupCells()
        retrieveData {
            print("done")
        }
        // Do any additional setup after loading the view.
    }
    
    func setupCells() {
        collectionView.register(EntryCell.self, forCellWithReuseIdentifier: EntryCell.cellID)
    }
    
    func retrieveData(completion: () -> Void) {
        let urlString = "https://api.publicapis.org/entries"
        guard let url = URL(string: urlString) else {
            return
        }
        
        // very quickly we've devloped a scalable api for handle our network requests
        let resource = CodableResource<EntriesContainer>(url: url)
        URLSession.shared.load(resource) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let entriesData):
                self.entries = entriesData.entries
                // back to the main thread
                DispatchQueue.main.async { [unowned self] in
                    self.collectionView.reloadData()
                }
                print(self.entries.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
            print("done")
        }
    }
}


extension EntriesCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entries.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let entry = entries[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EntryCell.cellID, for: indexPath) as! EntryCell
        cell.entry = entry
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
