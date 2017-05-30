//
// Постановка задачи:
// Реализовать алгоритм поиска простых чисел методом решета Эратосфена и вывести сумму,а также список этих чисел.
// ---
// Автор: Илья Семенов
// smpw@mail.ru
// ---

import UIKit

var entered: CUnsignedLongLong = 0

class Enter: UIViewController, UITextFieldDelegate
{
    @IBOutlet var tapToCloseTextField: UITapGestureRecognizer!
    @IBOutlet weak var enterTextField: UITextField!
    
    let limitLength = 15
    
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
            entered = CUnsignedLongLong(enterTextField.text!)!
        }
        enterTextField.text = ""
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

