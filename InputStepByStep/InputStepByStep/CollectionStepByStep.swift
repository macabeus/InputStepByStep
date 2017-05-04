//
//  CollectionStepByStep.swift
//  InputStepByStep
//
//  Created by Bruno Macabeus Aquino on 03/05/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

public enum InputType {
    case text
    case number
}

public struct ConfigInput {
    let name: String
    let label: String
    
    public init(name: String, label: String) {
        self.name = name
        self.label = label
    }
}

public enum CellCreateGrid {
    case name(String)
    case input(ConfigInput, cellName: String)
    case finish()
}

public protocol CollectionStepByStepProtocol {
    var cellConfigList: [CellCreateGrid] { get set }
    func cellFinishAction(inputValues: [String: [String: String]])
}

public class CollectionStepByStep: UICollectionViewController, CollectionStepyByStepLayoutDelegate {
    
    public var delegate: CollectionStepByStepProtocol?
    var inputValues: [String: [String: String]] = [:]
    let showInput = ShowInput()
    
    public override func viewDidLoad() {
        collectionView!.collectionViewLayout = CollectionStepByStepLayout()
        (collectionView!.collectionViewLayout as! CollectionStepByStepLayout).delegate = self
        
        collectionView!.register(UINib(nibName: "CellCSbSDivision", bundle: Bundle(for: CollectionStepByStep.self)), forCellWithReuseIdentifier: "CellCSbSDivision")
        collectionView!.register(UINib(nibName: "CellCSbSConfigFinish", bundle: Bundle(for: CollectionStepByStep.self)), forCellWithReuseIdentifier: "CellCSbSConfigFinish")
        collectionView!.register(UINib(nibName: "CellCSbSConfigTitle", bundle: Bundle(for: CollectionStepByStep.self)), forCellWithReuseIdentifier: "CellCSbSConfigTitle")
        collectionView!.register(UINib(nibName: "CellCSbSConfigInput", bundle: Bundle(for: CollectionStepByStep.self)), forCellWithReuseIdentifier: "CellCSbSConfigInput")
    }
    
    override public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return delegate!.cellConfigList.count
    }
    
    override public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch delegate!.cellConfigList[section] {
        case .name(_):
            return 2
        default:
            return 1
        }
    }
    
    var lastCellDivision: CellConfigDivision?
    var currentTitle: String?
    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentCell = delegate!.cellConfigList[indexPath.section]
        
        switch currentCell {
        case .name(let name):
            let cell: UICollectionViewCell
            
            if indexPath.item == 0 {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCSbSDivision", for: indexPath)
                (cell as! CellConfigDivision).startCell()
                lastCellDivision = (cell as! CellConfigDivision)
            } else {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCSbSConfigTitle", for: indexPath)
                (cell as! CellConfigTitle).labelTitle.text = name
                currentTitle = name
                inputValues[name] = [:]
            }
            
            return cell
        case .input(let input, _):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCSbSConfigInput", for: indexPath) as! CellConfigInput
            
            lastCellDivision!.totalInputs += 1
            cell.inputName = input.label
            cell.configTitle = currentTitle
            cell.myCellDivisin = lastCellDivision
            
            if let value = inputValues[cell.configTitle!]![cell.inputName!] {
                cell.labelField.text = value
            } else {
                cell.labelField.text = input.label
            }
            
            return cell
        case .finish:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCSbSConfigFinish", for: indexPath) as! CellConfigFinish
            
            cell.startCell()
            
            return cell
        }
    }
    
    // focus
    override public func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    // input
    override public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        if let cell = cell as? CellConfigInput {
            showInput.callback = { text in
                if text == "" { // cancel
                    return
                }
                
                self.inputValues[cell.configTitle!]![cell.inputName!] = text
                cell.myCellDivisin!.totalInputsFilled = self.inputValues[cell.configTitle!]!.count
                cell.myCellDivisin!.updateProress()
                cell.labelField.text = text
            }
            
            showInput.start(view: cell)
            
        } else if ((cell as? CellConfigFinish) != nil) {
            delegate!.cellFinishAction(inputValues: inputValues)
        }
    }
    
    // CollectionStepyByStepLayoutDelegate
    func numberOfInputsAtStep(section: Int) -> Int {
        var count = 0
        var sectionCurrent = section + 1
        while delegate!.cellConfigList.count != sectionCurrent && Mirror(reflecting: delegate!.cellConfigList[sectionCurrent]).children.first?.label! != "name" {
            count += 1
            sectionCurrent += 1
        }
        
        return count
    }
    
    func cellTypeAt(section: Int, row: Int) -> CellStepByStepType {
        let currentCell = delegate!.cellConfigList[section]
        
        switch currentCell {
        case .name:
            if row == 0 {
                return .step
            } else {
                return .name
            }
            
        case .input:
            return .input
            
        case .finish:
            return .finish
        }
    }
    
}
