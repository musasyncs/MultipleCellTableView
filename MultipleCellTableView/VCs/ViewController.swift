//
//  ViewController.swift
//  MultipleCellTableView
//
//  Created by Ewen on 2021/10/15.
//

import UIKit

class ViewController: UIViewController {
    var sections = [Section]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(GalleryTableViewCell.self, forCellReuseIdentifier: "\(GalleryTableViewCell.self)")

        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: "\(SwitchTableViewCell.self)")
        tableView.register(BasicTableViewCell.self, forCellReuseIdentifier: "\(BasicTableViewCell.self)")
        
        tableView.register(SectionHeader.self, forHeaderFooterViewReuseIdentifier: "\(SectionHeader.self)")
        tableView.register(SectionFooter.self, forHeaderFooterViewReuseIdentifier: "\(SectionFooter.self)")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.backgroundColor = .white //必須寫在viewDidLoad
        tableView.separatorStyle = .none //必須寫在viewDidLoad
        tableView.dataSource = self
        tableView.delegate   = self
        view.addSubview(tableView)
        tableView.fillSuperView()
        
        let header = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        tableView.tableHeaderView = header
    
        setupViewModels()
    }
    
    private func setupViewModels() {
        sections.append(Section(title: "最近上線", cellTypes: [
            .galleryTableViewCellType(
                viewModels: [
                    GalleryCollectionViewCellVM(title: "Abigail", imageName:"Abigail"),
                    GalleryCollectionViewCellVM(title: "Caitlin", imageName:"Caitlin"),
                    GalleryCollectionViewCellVM(title: "Chelsea", imageName:"Chelsea"),
                    GalleryCollectionViewCellVM(title: "Danielle", imageName:"Danielle"),
                    GalleryCollectionViewCellVM(title: "Katie", imageName:"Katie"),
                    GalleryCollectionViewCellVM(title: "Melissa", imageName:"Melissa"),
                    GalleryCollectionViewCellVM(title: "Molly", imageName:"Molly")
                ], rows: 2
            )
        ]))

        sections.append(Section(title: "尋找設定", cellTypes: [
            .switchCellType(
                viewModel: SwitchTableViewCellVM(
                    title: "全球",
                    iconImage: UIImage(systemName: "globe.asia.australia"),
                    iconTintColor: .systemOrange,
                    handler: {},
                    isOn: false
                )
            ),
            .basicTableViewCellType(
                viewModel: BasicTableViewCellVM(
                    title: "位置",
                    iconImage: UIImage(named: "location"),
                    iconTintColor: .white,
                    handler: { [weak self] in
                        self?.popVC()
                    }
                )
            )
        ]))
        
        sections.append(Section(title: "帳號設定", cellTypes: [
            .basicTableViewCellType(
                viewModel: BasicTableViewCellVM(
                    title: "電話號碼",
                    iconImage: UIImage(systemName: "iphone"),
                    iconTintColor: .systemPink,
                    handler: { [weak self] in
                        self?.popVC()
                    }
                )
            )
        ]))
    }
    
    func popVC() {
        let vc = TestViewController()
        present(vc, animated: true)
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].cellTypes[indexPath.row] {
        case .galleryTableViewCellType(let viewModels, _ ):
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(GalleryTableViewCell.self)", for: indexPath) as! GalleryTableViewCell
            cell.configure(with: viewModels)
            cell.delegate = self
            return cell
        case .switchCellType(viewModel: let viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(SwitchTableViewCell.self)", for: indexPath) as! SwitchTableViewCell
            cell.configure(with: viewModel)
            cell.selectionStyle = .none
            return cell
        case .basicTableViewCellType(let viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(BasicTableViewCell.self)", for: indexPath) as! BasicTableViewCell
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    //===
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section].cellTypes[indexPath.row] {
        case .galleryTableViewCellType(_, let rows):
            let height: CGFloat = view.frame.size.width / 2.5 * 1.5
            return height * CGFloat(rows) + Constant.padding * CGFloat(rows+1) + 1
        case .switchCellType(_):
            return view.frame.size.width/8
        case .basicTableViewCellType(_):
            return view.frame.size.width/8
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch sections[indexPath.section].cellTypes[indexPath.row] {
        case .galleryTableViewCellType(_, _):
            break
        case .switchCellType(_):
            break
        case .basicTableViewCellType(let viewModel):
            viewModel.handler()
        }
    }
    
    // section header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(SectionHeader.self)") as! SectionHeader
            header.configure(text: sections[section].title)
            return header
        case 1:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(SectionHeader.self)") as! SectionHeader
            header.configure(text: sections[section].title)
            return header
        case 2:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(SectionHeader.self)") as! SectionHeader
            header.configure(text: sections[section].title)
            return header
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    // section footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == sections.count - 1 else { return nil }
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(SectionFooter.self)") as! SectionFooter
        return footer
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == sections.count-1 ? 80 : 0
    }
}


//MARK: - GalleryTableCellDelegate (警告跳出)
extension ViewController: GalleryTableCellDelegate {
    func didTapItem(with viewModel: GalleryCollectionViewCellVM) {
        let alert = UIAlertController(title: viewModel.title, message: "成功點擊", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確定", style: .cancel))
        present(alert, animated: true)
    }
}

//MARK: - UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? StretchyTableHeaderView else { return }
        header.scrollViewDidScroll(scrollView: tableView)
    }
}

//============================================
struct Section {
    let title: String
    let cellTypes: [CellType]
}

enum CellType {
    case galleryTableViewCellType(viewModels: [GalleryCollectionViewCellVM], rows: Int)
    case switchCellType(viewModel: SwitchTableViewCellVM)
    case basicTableViewCellType(viewModel: BasicTableViewCellVM)
}


struct GalleryCollectionViewCellVM {
    let title: String
    let imageName: String
}
struct SwitchTableViewCellVM {
    let title: String
    let iconImage: UIImage?
    let iconTintColor: UIColor
    let handler: (()->Void)
    var isOn: Bool
}
struct BasicTableViewCellVM {
    let title: String
    let iconImage: UIImage?
    let iconTintColor: UIColor
    let handler: (()->Void)
}
