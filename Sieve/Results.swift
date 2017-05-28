//
// Постановка задачи:
// Реализовать алгоритм поиска простых чисел методом решета Эратосфена и вывести сумму,а также список этих чисел.
// ---
// Автор: Илья Семенов
// smpw@mail.ru
// ---

import UIKit

var arrayResults: [CUnsignedLongLong] = []
var primeArray: [CUnsignedLongLong] = []
var summ = CUnsignedLongLong()

class Results: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableResults: UITableView!
    @IBOutlet weak var sumLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        sieve() // Здесь происходит анализ является ли введённое число простым (анализируется в функции baseSettings())
        sum() // Итерация по массиву и суммирование результата
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellResults")
        cell?.textLabel?.text = "\(arrayResults[indexPath.row])"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Найденные простые числа"
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
    
    func baseSettings(minValue: CUnsignedLongLong, maxValue: CUnsignedLongLong) // Оптимизация поиска. Создание диапазона и проверка на наличие простого числа в диапазоне
    {
        primeArray.removeAll()
        
        for index in minValue..<maxValue + 1
        {
            primeArray.append(CUnsignedLongLong(index))
        }
        
        for i in 0..<primeArray.count
        {
            if (primeArray[i] != 0)
            {
                for j in 0..<primeArray.count
                {
                    if (primeArray[j]%2 == 0) || (primeArray[j]%3 == 0) || (primeArray[j]%5 == 0) || (primeArray[j]%7 == 0)
                    {
                        primeArray[j] = 0
                    }
                }
            }
        }
    }
    
    func sieve()
    {
        arrayResults.removeAll()
        

        for i in 0..<arrayEnter.count
        {
            if (arrayEnter[i] == 2) || (arrayEnter[i] == 3) || (arrayEnter[i] == 5) || (arrayEnter[i] == 7)
            {
                arrayResults.append(arrayEnter[i])
            }
            else
            {
                baseSettings(minValue: arrayEnter[i], maxValue: arrayEnter[i] + 30)
                for j in 0..<primeArray.count
                {
                    if arrayEnter[i] == primeArray[j]
                    {
                        arrayResults.append(arrayEnter[i])
                        break
                    }
                }
            }
        }
        tableResults.reloadData()
    }
    
    
    func sum()
    {
       summ = 0
       for index in 0..<arrayResults.count
       {
        summ += arrayResults[index]
       }
        sumLabel.text = "\(summ)"
    }
}

