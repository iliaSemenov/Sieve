//
// Постановка задачи:
// Реализовать алгоритм поиска простых чисел методом решета Эратосфена и вывести сумму,а также список этих чисел.
// ---
// Автор: Илья Семенов
// smpw@mail.ru
// ---

import UIKit

class Results: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableResults: UITableView!
    @IBOutlet weak var sumLabel: UILabel!
    
    var arrayResultsFiltered: [CUnsignedLongLong] = []
    var arrayResults: [CUnsignedLongLong] = []
    var summ = CUnsignedLongLong()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if entered != 0
        {
            sieve() // Метод решета Эратосфена + оптимизация поиска
            sum() // Итерация по массиву и суммирование результата
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayResultsFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellResults")
        cell?.textLabel?.text = "\(arrayResultsFiltered[indexPath.row])"
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

    func sieve()
    {
        arrayResults.removeAll()
        var min: CUnsignedLongLong = CUnsignedLongLong()
        if entered > 1000
        {
            min = entered - 100
        }
        else
        {
            min = 2
        }
        
        for index in min..<entered + 1
        {
            arrayResults.append(CUnsignedLongLong(index))
        }
        for i in 0..<arrayResults.count
        {
            if (arrayResults[i] != 0)
            {
                for j in 0..<arrayResults.count
                {
                    if (arrayResults[j]%2 == 0) && (arrayResults[j] != 2) || (arrayResults[j]%3 == 0) && (arrayResults[j] != 3) || (arrayResults[j]%5 == 0) && (arrayResults[j] != 5) || (arrayResults[j]%7 == 0) && (arrayResults[j] != 7)
                    {
                        arrayResults[j] = 0
                        
                    }
                }
            }
        }
        filteringResultArray()
        tableResults.reloadData()
    }

    
    func filteringResultArray() // Очищаю массив arrayResults от "0" для таблицы
    {
        arrayResultsFiltered.removeAll()
        
        for i in 0..<arrayResults.count
        {
            if arrayResults[i] != 0
            {
                arrayResultsFiltered.append(arrayResults[i])
            }
        }
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

