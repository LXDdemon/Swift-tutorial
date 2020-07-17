import UIKit


func assertfunction(email: String ,password: String) {
    assert(email.count < 8, "invalid email")
    assert(password.count < 8, "invalid password")
}
//1. 定义枚举异常值
enum RequestError :Error {
    case netError
    case serviceError
    case missingParameter(parameter: String)
    case isnil
}

//2.抛出异常
func throwErrors(type :Int) throws -> String {
    if type == 1 {
        throw RequestError.netError
    }else if type == 2 {
        throw RequestError.serviceError
    }else if type == 3 {
        throw RequestError.missingParameter(parameter: "password")
    }
    return "success"
}
let array = Array<Int>()



//3.捕获异常

do {

    let errorMsg = try throwErrors(type: 2)

    //不报错 下边会输出，报错则不执行
    print(errorMsg)
} catch let error {
    //报错则执行相对应的错误类型
    
    switch error {
    case RequestError.netError :
        print("是网络错误")
    case RequestError.serviceError :
        print("是服务端错误")
    default:
        print("缺少参数")
    }
}
//4 .不处理异常(try? & try!)

func findOptionsError(value :String?) throws -> [String] {
    guard let value = value else {
        throw RequestError.isnil
    }
    return [value]
}

do {
    try findOptionsError(value: nil)
} catch let error {
    print(error)
}

func test() throws {
    try findOptionsError(value: nil)
}


let value = try? findOptionsError(value: nil)
//let value1 = try findOptionsError(value: nil)
//
//
//let crash = try! findOptionsError(value: nil)

 //MARK: Rethrow

func transform( _ num :Int) throws -> String {
    return "\(num)"
}
func flatMap (array :[Int]) throws -> [String] {
    var result :[String] = []
    for element in array {
       result.append( try transform(element))
    }
    return result
}
//flatMap这个函数本身是不会抛出错误的,但是因为调用了transform 这个可能抛出错误的函数所以需要使用 throws,将错误上报 ,接下来我们把transform函数变成faltMap的一个闭包参数,将这两个函数合并成一个

func flatMap(array : [Int] ,_ transform : (Int) throws -> String) throws  -> [String] {
    var result :[String] = []
    
    for element in array {
        result.append( try transform(element))
    }
    return result
}


//这样调用新的flatMap和调用之前的faltMap达到的效果就一致了.接下来我们再做一点改动 将最后的throws换成 rethrows

func flatMap_new(array : [Int] ,_ transform : (Int) throws -> String) rethrows  -> [String] {
    var result :[String] = []
    
    for element in array {
        result.append( try transform(element))
    }
    return result
}
 //MARK: defer

func judgeValuable( _ passWord :String?) throws {
    guard let passWord = passWord else {
        throw RequestError.isnil
    }
    print("passWord is ",passWord)
}

func saveThePassword(_ passWord:String?) throws {
    defer {
        print("已经检验过密码")
    }
    try? judgeValuable(passWord)
}

try saveThePassword(nil)

func fn1() {print("fn1") }
func fn2() {print("fn2") }
func fn3() {print("fn3") }

func testDefer() {
    defer {
        fn1()
    }
    defer {
        fn2()
    }
    defer {
        fn3()
    }
}
testDefer()
 //MARK: fatalError
func pay(amount :Int) -> Bool {
    if amount > 0 && amount < 10000 {
        return true
    }
    fatalError("金额超出范围")
}

pay(amount: 100000)//程序会直接终止
