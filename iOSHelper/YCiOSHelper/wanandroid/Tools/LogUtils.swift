
import Foundation

func log<T>(log: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    //print(#file)    //获取当前print所在的文件路径
    //print(#function)    //获取当前print所在的方法名称
    //print(#line)    //获取当前print所在的行数
    //判断是否打印debug
    #if DEBUG
    print("\((fileName as NSString).pathComponents.last!)_\(methodName)[行: \(lineNumber)]: \(log)")
    
    #endif
}


