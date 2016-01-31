# swift-demo

###类与结构
* 1.类与结构体初始化，实例化
* 2.结构体成员初始化（类没有）
* 3.结构体，数组，字典为数值类型，类是引用类型


###存储属性
* 1.结构体属性存储
* 2.懒惰存储
* 3.计算属性（set,get）
* 4.类属性语句（static,class声明变量或常量，静态变量，）


###方法
* 1.实例方法用.语法调用
* 2.每一个实例都有一个隐藏的self属性，可以给实例属性前面+self，和方法参数同名区分
* 3.数值类型结构的实例属性默认不能被它的实例方法修改，前面+multating关键词，（不适用常量实例）
* 4.类方法，类的类方法前+class关键词，数值结构的类方法前+static关键词


###下标方法
* 1.通过subscript定义一个或多个参数以及一个返回值。可以只读或读写，通过setter和getter


###继承
* 1.基类
* 2.子类
* 3.重写方法。override
* 4.重写属性，get set
* 5.重写观察者
* 6.不可重写 final关键词


###类的继承和初始化
* 1.类初始化时必须保证所有属性被赋予合理的值，直接赋值比放在构造函数要好
* 2.自定义初始化，可以写多个初始化函数，但是都必须保证所有属性被赋值
* 3.实参和形参，不要形参用_代替
* 4.可选类型 ？
* 5.静态属性只有在初始化完成之前可以修改，即init里面修改
* 6.类当所有属性都有默认值，并且是基类，则系统会创建默认构造器
* 7.结构体即使属性没有被赋值也会生成默认构造器
* 8.类的继承和初始化
* 9.构造器的继承和重写
* 10.构造器的自动继承
* 11.是的的初始化 init?
* 12.闭包函数设置默认值


###析构函数
* 1.每个类最多有一个析构函数 deinit{}
* 2.西枸杞操作，实例销毁前自动调用


###自动引用计数
* 1.ARC实现：每当创建一个实例，ARC分配一块内存存储实例信息，当有强引用指向实例时，内存不会释放，没有强引用时释放内存
* 2.循环引用：使用weak或unowned修饰变量，unowned（类似unsafe）修为的变量一定有值，weak修饰的变量可能为空（可选值），当weak引用的对象释放时会被置空
* 3.无主引用:unowned类型必须有值，所以在类构造函数时候，必须初始化保证有值
* 4.无主引用和隐式拆分可选属性：当两个属性都要一直有值得时候，看例子
* 5.闭包强引用循环：闭包是函数指针，即类实例有一个强引用指向函数，函数体内截获的类成员属性又间接对实例强引用，构成函数和实例的循环引用
* 7.闭包循环引用解决方法： 创建捕获列表，捕获元素由weak/unowned关键词修饰[unowned self, weak delegate = self.delegate!] in 


###可选链
* 1.可选链：告诉编译器自检查当前调用的目标可能为空，如果为空则直接返回nil，否则就调用成功


###错误处理
* 1.函数前面声明throws声明此函数可以抛出错误，throwing函数
* 2.抛出错误使用throw关键字
* 3.在调用一个能抛出错误的函数前面。加try关键字
* 4.Do-Catch处理函数
* 5.将错误转换成可选值，let x = try? someThrowingFunction()
* 6.如果明知道throwing函数不会抛出错误，想要禁止错误传递，可以用try!
* 7.指定清理操作，defer语句在即将离开当前作用域前执行一些清理操作

###类型检查
* 1.使用is检查一个实例是否是一个类的子类 if item is Class
* 2.使用as？ ，as! 类型转换, let movie = item as? Class
* 3.Any 任何对象类型
* 4.AnyObject,任何类型，包括函数