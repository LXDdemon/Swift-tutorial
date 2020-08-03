//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

var ptr = malloc(24)//分配一块大小为24字节的内存,将地址值赋给ptr这个变量
// 存
ptr?.storeBytes(of: 2020, as: Int.self)//在开头的八个字节存2020
ptr?.storeBytes(of: 08, toByteOffset: 8, as: Int.self)//在8-16个字节存取08
ptr?.storeBytes(of: 01, toByteOffset: 16, as: Int.self)//在16-24个字节存取01
//// 取
print((ptr?.load(as: Int.self))!) //2020
print((ptr?.load(fromByteOffset: 8, as: Int.self))!) // 8
print((ptr?.load(fromByteOffset: 16, as: Int.self))!) // 16
free(ptr)//注意这部分内存不是ARC管理,需要我们手动销毁




var genericPtr = UnsafeMutablePointer<String>.allocate(capacity: 3)//生成一个String类型的指针,容量大小为可以存储3个String类型的大小
genericPtr.initialize(to: "Hello")//第一块内存存储Hello
genericPtr.successor().initialize(to: "World")//使用successor连续分配的内存
genericPtr.successor().successor().initialize(to: "Swift")
// MARK: -取值方式和C语言的数组非常相似
print(genericPtr.pointee) // "Hello"
print((genericPtr + 1).pointee) // "World"
print((genericPtr + 2).pointee) // "Swift"
print(genericPtr[0]) // "Hello"
print(genericPtr[1]) // "World"
print(genericPtr[2]) // "Swift"
genericPtr.deinitialize(count: 3)
genericPtr.deallocate()//释放内存

class Teacher : CustomStringConvertible{
    
    
    var gradeClass :String
    var name :String
    init(gradeClass: String ,name: String) {
        self.name = name
        self.gradeClass = gradeClass
    }
    var description: String {
        return self.gradeClass + " " + self.name
    }
    deinit {
        print(gradeClass,name,"deinit")
    }
    
}

var objcPtr = UnsafeMutablePointer<Teacher>.allocate(capacity: 3)//分配一个可以装下3个Teacher对象大小的内存,并且将内存地址赋值给objcPtr这个指针变量
objcPtr.initialize(to: Teacher.init(gradeClass: "3年级 2班", name: "李老师"))
//objcPtr.successor().initialize(repeating: Teacher.init(gradeClass: "2年级 1班", name: "王老师"), count: <#T##Int#>)
objcPtr.successor().initialize(to: Teacher.init(gradeClass: "2年级 1班", name: "王老师"))
(objcPtr + 2).initialize(to: Teacher.init(gradeClass: "1年级 5班", name: "张老师"))
print(objcPtr.pointee.description)//3年级 2班 李老师
print(objcPtr.successor().pointee.description)//2年级 1班 王老师
print(objcPtr.successor().successor().pointee.description)//1年级 5班 张老师
objcPtr.deinitialize(count: 3)//将存放的3个Teacher对象
objcPtr.deallocate()//释放内存
//print(ob)


//: [Next](@next)
