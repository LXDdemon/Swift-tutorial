import UIKit

var str = "Hello, playground"
//var a = 0
//precondition(a == 1, "error111")


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
    try str = throwErrors(type: 2)
    //不报错 下边会输出，报错则不执行
    print(str)
} catch  {
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

let value = try? findOptionsError(value: nil)


let crash = try! findOptionsError(value: nil)


