//
//  CollectionStepByStep.swift
//  InputStepByStep
//
//  Created by Bruno Macabeus Aquino on 03/05/17.
//  Copyright © 2017 Bruno Macabeus Aquino. All rights reserved.
//

import UIKit

public enum CellCreateGrid {
    case name(String)
    case input(name: String, label: String)
    case finish()
}

public protocol InputStepByStepProtocol {
    var configList: [CellCreateGrid] { get }
    func cellFinishAction(inputValues: [String: [String: String]])
}

public class InputStepByStep: UICollectionViewController, InputStepyByStepLayoutDelegate {
    
    public var delegate: InputStepByStepProtocol?
    var inputValues: [String: [String: String]] = [:]
    let showInput = ShowInput()
    
    public override func viewDidLoad() {
        collectionView!.collectionViewLayout = InputStepByStepLayout()
        (collectionView!.collectionViewLayout as! InputStepByStepLayout).delegate = self
        
        collectionView!.register(UINib(nibName: "CellDivision", bundle: Bundle(for: InputStepByStep.self)), forCellWithReuseIdentifier: "CellDivision")
        collectionView!.register(UINib(nibName: "CellConfigFinish", bundle: Bundle(for: InputStepByStep.self)), forCellWithReuseIdentifier: "CellConfigFinish")
        collectionView!.register(UINib(nibName: "CellConfigTitle", bundle: Bundle(for: InputStepByStep.self)), forCellWithReuseIdentifier: "CellConfigTitle")
        collectionView!.register(UINib(nibName: "CellConfigInput", bundle: Bundle(for: InputStepByStep.self)), forCellWithReuseIdentifier: "CellConfigInput")
    }
    
    override public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return delegate!.configList.count
    }
    
    override public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch delegate!.configList[section] {
        case .name(_):
            return 2
        default:
            return 1
        }
    }
    
    var lastCellDivision: CellConfigDivision?
    var currentTitle: String?
    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentCell = delegate!.configList[indexPath.section]
        
        switch currentCell {
        case .name(let name):
            let cell: UICollectionViewCell
            
            if indexPath.item == 0 {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellDivision", for: indexPath)
                (cell as! CellConfigDivision).startCell()
                lastCellDivision = (cell as! CellConfigDivision)
            } else {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellConfigTitle", for: indexPath)
                (cell as! CellConfigTitle).labelTitle.text = name
                currentTitle = name
                inputValues[name] = [:]
            }
            
            return cell
        case .input(let name, let label):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellConfigInput", for: indexPath) as! CellConfigInput
            
            lastCellDivision!.totalInputs += 1
            cell.inputName = name
            cell.configTitle = currentTitle
            cell.myCellDivisin = lastCellDivision
            
            if let value = inputValues[cell.configTitle!]![cell.inputName!] {
                cell.labelField.text = value
            } else {
                cell.labelField.text = label
            }
            
            cell.updateWidthUnderline()
            return cell
        case .finish:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellConfigFinish", for: indexPath) as! CellConfigFinish
            
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
                cell.updateWidthUnderline()
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
        while delegate!.configList.count != sectionCurrent && Mirror(reflecting: delegate!.configList[sectionCurrent]).children.first?.label! != "name" {
            count += 1
            sectionCurrent += 1
        }
        
        return count
    }
    
    func cellTypeAt(section: Int, row: Int) -> CellStepByStepType {
        let currentCell = delegate!.configList[section]
        
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
