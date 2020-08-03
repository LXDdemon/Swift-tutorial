import UIKit

var str = "Hello, playground"
print(MemoryLayout.size(ofValue: str))
print(MemoryLayout.stride(ofValue: str))
print(MemoryLayout.alignment(ofValue: str))
print(MemoryLayout<String>.size)
func test1(_ ptr :UnsafeMutablePointer<String>){
    ptr.pointee += "  Swift"//泛型类指针修改此指针引用的实例。
    
}

func test2(_ ptr :UnsafeMutableRawPointer){
    ptr.storeBytes(of: "Hello, Swift", as: String.self)//非泛型类指针修改此指针引用的实例。
}

func test3(_ ptr :UnsafePointer<String>){
    print(ptr.pointee)//泛型不可变指针访问此指针引用的实例。
}
func test4(_ ptr :UnsafeRawPointer) {
    print(ptr.load(as: String.self))//非泛型不可变指针访问此指针引用的实例。
}
test1(&str)
print(str)
test2(&str)
print(str)
test3(&str)
test4(&str)

var score = 100
var ptr1 = withUnsafeMutablePointer(to: &score) { (point) -> UnsafeMutablePointer<Int> in
    return point
}
var ptr2 = withUnsafeMutablePointer(to: &score){$0}

print("ptr1===",ptr1)
print("ptr2===",ptr2)

ptr1.pointee = 120//修改获取变量指针,引用的势力的值
var ptr3 = withUnsafeMutablePointer(to: &score) { UnsafeMutableRawPointer($0)//将泛型类指针转换成非泛型类指针
}
ptr3.storeBytes(of: 150, as: Int.self)

class Student {
    var age :Int?
    init(age :Int) {
        self.age = age
    }
}
var student  = Student.init(age: 20)
var ptr = withUnsafePointer(to: &student) { UnsafeRawPointer($0) }//首先获取到student这个变量的指针

let address = ptr.load(as: UInt.self)//将ptr指向的Student对象的内存地址值取出来

var objectPtr = UnsafeRawPointer(bitPattern: address)//这个就是student对象在堆空间的地址值

print(objectPtr)//Optional(0x0000600001866120)
//print(heapPtr!.load(as: Student.self).age)








