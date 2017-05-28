//
// Постановка задачи:
// Реализовать алгоритм поиска простых чисел методом решета Эратосфена и вывести сумму,а также список этих чисел.
// ---
// Автор: Илья Семенов
// smpw@mail.ru
// ---

import UIKit

var arrayEnter: [CUnsignedLongLong] = []

class Enter: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    @IBOutlet weak var tableEnter: UITableView!
    @IBOutlet var tapToCloseTextField: UITapGestureRecognizer!
    @IBOutlet weak var enterTextField: UITextField!
    
    let limitLength = 19
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        startSettings()
    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    @IBAction func addNumber(_ sender: Any)
    {

        if enterTextField.text == ""
        {
           showError(title: "Требуется число", message: "Поле не должно быть пустым!")
        }
        else if (CUnsignedLongLong(enterTextField.text!)! == 1) || (CUnsignedLongLong(enterTextField.text!)! == 0)
        {
            showError(title: "Неправильный ввод", message: "Цифра 1 или 0 не может быть использована")
        }
        else
        {
            arrayEnter.append(CUnsignedLongLong(enterTextField.text!)!)
            tableEnter.reloadData()
        }
        enterTextField.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayEnter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEnter")
        cell?.textLabel?.text = "\(arrayEnter[indexPath.row])"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Введённые числа"
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let delete = UITableViewRowAction(style: .destructive, title: "Удалить", handler: {(row, action) -> Void in
            arrayEnter.remove(at: indexPath.row)
            self.tableEnter.reloadData()
        })
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    func startSettings()
    {
        enterTextField.delegate = self
        self.view.addGestureRecognizer(tapToCloseTextField)
    }
    
    @IBAction func closeTextField(_ sender: Any)
    {
        enterTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        enterTextField.resignFirstResponder()
        return true
    }
    
    func showError(title: String, message: String)
    {
        let errorMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Хорошо", style:  .default, handler: nil)
        errorMessage.addAction(okButton)
        present(errorMessage, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        guard let text = enterTextField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= limitLength
    }
}

