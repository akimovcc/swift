import UIKit

//1. Написать функцию, которая определяет, четное число или нет.
func isEvenNumber(_ Number: Int) -> Bool{
    if (Number % 2 == 0){ return true }
    return false
}
func testTaskOne(_ Number: Int){
  print(isEvenNumber(Number) ? "Число \(Number) четное" : "Число \(Number) нечетное")
}
print("1. Написать функцию, которая определяет, четное число или нет.")
testTaskOne(4)
testTaskOne(5)

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func isDivisibilityByThree(_ Number: Int) -> Bool{
    if (Number % 3 == 0){ return true }
    return false
}
func testTaskTwo(_ Number: Int){
    print(isDivisibilityByThree(Number) ? "Число \(Number) делится без остатка на 3" : "Число \(Number) не делится без остатка на 3")
}
print("\n2. Написать функцию, которая определяет, делится ли число без остатка на 3.")
testTaskTwo(7)
testTaskTwo(9)


//3. Создать возрастающий массив из 100 чисел.
//Вариант 1: Функция создаёт возрастающий массив из чисел, которые больше предыдущих в диапазоне от 1 до 10
func createArrInc () -> Array <Int>{
    var arr = [Int]()
    for _ in 1...100{
        arr.append((arr.max() ?? 0) + Int.random(in: 1...10))
    }
    return arr
}
var createdArrInc = createArrInc()
//Вариант 2: Просто создаем массив из диапазона от 1 до 100
var arr: Array = [Int](1...100)
print("\n3. Создать возрастающий массив из 100 чисел.\n\(arr)\n")


//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
//Вариант 1
createdArrInc.removeAll(where: {$0 % 2 == 0 || $0 % 3 != 0} )
for element in createdArrInc {
    if isEvenNumber(element) || !isDivisibilityByThree(element){
        createdArrInc.remove(at: createdArrInc.firstIndex(of: element)!)
    }
}
//Вариант 2
func removeFromMassiveNumbers(_ arr: inout Array <Int>) -> Array <Int>{
    for element in arr {
        if isEvenNumber(element) || !isDivisibilityByThree(element){
            arr.remove(at: arr.firstIndex(of: element)!)
        }
    }
    return arr
}
print("4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3:\n\(removeFromMassiveNumbers(&arr))\n")


//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
var arrFibonachi: [Double] = []
func addFibNum ( _ arr: inout Array <Double>) -> Array <Double>{
    if arr.isEmpty || arr.count == 1{
        arr.append(1)
    }else{
       let n = arr.count
        arr.append(arr[n-1]+arr[n-2])
    }
    return arr
}
while(arrFibonachi.count < 100){
  addFibNum(&arrFibonachi)
}
print("5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов:\n\(arrFibonachi)\n")


//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
let n : Int = 546
var numbers = [Int](2...n)
//b. Пусть переменная p изначально равна двум — первому простому числу.
var p : Int = 2
//e. Повторять шаги c и d, пока возможно.
repeat{
    //c. Зачеркнуть в списке числа от 2p до n, считая шагами по p (это будут числа, кратные p: 2p, 3p, 4p, ...).
    for i in stride(from: numbers.firstIndex(of: p)! + p, to: numbers.count, by: p){
        numbers[i] = 0
    }
    //d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
    let indexOfArray = numbers.firstIndex(where: {$0 > p && $0 > 0})
    if(indexOfArray == nil){
        break
    }
    p = numbers[indexOfArray!]
}while(p < n)
numbers = numbers.filter{$0 != 0}
print("6. * Заполнить массив из 100 элементов различными простыми числами:\n\(numbers)")
