//: [Previous](@previous)

import Foundation



class Father {
    var name = "王大狗"
    init() {
        
    }
    
}
class Son {
    var name = "王小狗"
    
}

var ptr = UnsafeMutableRawPointer.allocate(byteCount: 64, alignment: 1)//分配一块大小为64字节的内存

ptr.assumingMemoryBound(to: Son.self).pointee = Son.init()//前面32个字节分配的son
(ptr + 32).assumingMemoryBound(to: Father.self).pointee = Father.init() //后面32个字节分配给father

print(unsafeBitCast(ptr, to: UnsafePointer<Son>.self).pointee.name)//这个指针本来是任性类型的类似于 void * 现在将其转化成UnsafePointer<Son>
//打印结果 王小狗
print(unsafeBitCast(ptr + 32 , to: UnsafePointer<Father>.self).pointee.name)//将任意类型的指针转化成 UnsafePointer<Father>
//打印结果 王大狗

// unsafeBitCast是忽略数据类型的强制转换，不会因为数据类型的变化而改变原来的内存数据 我们来举一个例子说明一下
print(unsafeBitCast(ptr, to: UnsafePointer<Father>.self).pointee)//__lldb_expr_123.Son
//可以看到虽然指针已经修改成son类型但是内存中存放的仍然是Father类型
ptr.deallocate()





//: [Next](@next)

