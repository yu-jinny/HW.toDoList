
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Todo {
        var title: String
        var isCompleted: Bool
    }
    
    @IBOutlet weak var toDoListTableView: UITableView!
    @IBOutlet weak var addNewListButton: UIButton!
    
    // toDoMemo 배열을 클래스 레벨로 이동
    var toDoMemo: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoListTableView.backgroundColor = .systemYellow
        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
        addNewListButton.addTarget(self, action: #selector(addNewListButtonTapped), for: .touchUpInside)
        
        // 초기 데이터를 사용하여 toDoMemo 초기화
        toDoMemo = [
            Todo(title: "할 일 1", isCompleted: false),
            Todo(title: "할 일 2", isCompleted: false),
            Todo(title: "할 일 3", isCompleted: false)
        ]
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
                if let textField = alert.textFields?.first, let newTodoTitle = textField.text, !newTodoTitle.isEmpty {
                    let newTodo = Todo(title: newTodoTitle, isCompleted: false)
                    self?.addTodo(newTodo)
                }
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(addAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
        
        func addTodo(_ todo: Todo) {
            toDoMemo.append(todo)
            toDoListTableView.reloadData()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return toDoMemo.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
            let todo = toDoMemo[indexPath.row]
            
            // Todo의 완료 여부에 따라 체크마크를 표시
            cell.accessoryType = todo.isCompleted ? .checkmark : .none
            
            // Todo의 제목과 가운데 줄 설정
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 17),
                .foregroundColor: UIColor.black
            ]
            
            let attributedTitle = NSMutableAttributedString(string: todo.title, attributes: attributes)
            
            // Todo가 완료되었을 때 가운데 줄 추가
            if todo.isCompleted {
                attributedTitle.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributedTitle.length))
            }
                
            cell.textLabel?.attributedText = attributedTitle
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Todo의 완료 여부를 토글
            toDoMemo[indexPath.row].isCompleted.toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        // 테이블 뷰 셀 삭제 기능 추가
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Todo 삭제
                toDoMemo.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
