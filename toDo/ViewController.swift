
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var toDoListTableView: UITableView!
    @IBOutlet weak var addNewListButton: UIButton!
    
    var toDoMemo: [String] = ["할 일 1", "할 일 2", "할 일 3"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoListTableView.backgroundColor = .systemYellow
        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
        addNewListButton.addTarget(self, action: #selector(addNewListButtonTapped), for: .touchUpInside)
    }
    
    @IBAction func addNewListButtonTapped(_ sender: Any) {
        showAddTodoMessage()
    }
    
    func showAddTodoMessage() {
            let alert = UIAlertController(title: "할 일 추가", message: nil, preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "할 일을 입력하세요"
            }
            
            let addAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
                if let textField = alert.textFields?.first, let newTodo = textField.text, !newTodo.isEmpty {
                    self?.addTodo(newTodo)
                }
            }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func addTodo(_ todo: String) {
        toDoMemo.append(todo)
        toDoListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoMemo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        cell.textLabel?.text = toDoMemo[indexPath.row]
        return cell
    }
}
