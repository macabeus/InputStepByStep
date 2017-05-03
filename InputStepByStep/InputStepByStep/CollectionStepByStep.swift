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
    let inputType: InputType
    let obligatory: Bool
    
    public init(name: String, label: String, inputType: InputType, obligatory: Bool) {
        self.name = name
        self.label = label
        self.inputType = inputType
        self.obligatory = obligatory
    }
}

public enum CellCreateGrid {
    case name(String)
    case input(ConfigInput, cellName: String, currentValue: String) // TODO: Desacoplar lógica do ConfigInput da parte de criar grid para algo genérico
    case finish()
}

public protocol CollectionStepByStepProtocol {
    var cellConfigList: [CellCreateGrid] { get set }
    func cellFinishAction()
}

public class CollectionStepByStep: UICollectionViewController, CollectionStepyByStepLayoutDelegate {
    
    public var delegate: CollectionStepByStepProtocol?
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
    
    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentCell = delegate!.cellConfigList[indexPath.section]
        
        switch currentCell {
        case .name(let name):
            let cell: UICollectionViewCell
            
            if indexPath.item == 0 {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCSbSDivision", for: indexPath)
                (cell as! CellConfigDivision).startCell()
            } else {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCSbSConfigTitle", for: indexPath)
                (cell as! CellConfigTitle).labelTitle.text = name
            }
            
            return cell
        case .input(let input, _, let value):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCSbSConfigInput", for: indexPath) as! CellConfigInput
            // if input.obligatory { ... // TODO: Colocar na UI algo para diferenciar quando o campo é obrigatório/opcional
            
            if value == "" {
                cell.labelField.text = input.label
            } else {
                cell.labelField.text = value
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
                // TODO: é preciso atualizar o status de "cheio" e "vazio" daquela bolinha da cell step
                cell.labelField.text = text
                
                switch self.delegate!.cellConfigList[indexPath.section] {
                case .input(let input, let cellName, _):
                    self.delegate!.cellConfigList[indexPath.section] = CellCreateGrid.input(input, cellName: cellName, currentValue: text)
                default:
                    return
                }
            }
            
            showInput.start(view: cell)
            
        } else if ((cell as? CellConfigFinish) != nil) {
            delegate!.cellFinishAction()
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
