### c语言关键字

`int`   `short`   `long`   `unsigned`   `signed`    (long long  unsigned long int unsigned long long int)

`char`

`double`   `float`

`if else   ` 

`for `  `do while ` `switch case default`       `continue break`

**const    enum    **  (const int MONTHS = 12   #define INT 32768)

**auto  extern  static** 

`void`   `return` 

`struct`    `union`

sizeof

typedef

**goto  inline register**   ~~***restrict***~~     `volatile`                            （inline内联函数）register char *s;*

**_Bool       _Complex     _Imaginary**                                    _Bool a = 1;



goto part2;

part2:printf("Refined analysis");

```
enum DAY
{
      MON=1, TUE, WED, THU, FRI, SAT, SUN
};
```
结构体


```
//此声明声明了拥有3个成员的结构体，分别为整型的a，字符型的b和双精度的c
//同时又声明了结构体变量s1
//这个结构体并没有标明其标签
struct 
{
    int a;
    char b;
    double c;
} s1;

//此声明声明了拥有3个成员的结构体，分别为整型的a，字符型的b和双精度的c
//结构体的标签被命名为SIMPLE,没有声明变量
struct SIMPLE
{
    int a;
    char b;
    double c;
};
//用SIMPLE标签的结构体，另外声明了变量t1、t2、t3
struct SIMPLE t1, t2[20], *t3;

//也可以用typedef创建新类型
typedef struct
{
    int a;
    char b;
    double c; 
} Simple2;
//现在可以用Simple2作为类型声明新的结构体变量
Simple2 u1, u2[20], *u3;
```




"string"中包含多种转义字符 "\t"  "\n" "\088"(8进制) "\xee"（16进制or）\0xff

char nerf = '\n';

数字   0x41 0101

C语言除法/   浮点除还是浮点 整数除截尾（非四舍五入）



运算符优先级http://c.biancheng.net/cpp/html/462.html

1   [] () .->

2   **-1(-单目运算符)   （int）强制类型转换  ++ --  *(指针取值运算符 )   &(取地址运算符)  !  ~  sizeof**    右到左

！表达式（逻辑非）  ~表达式（按位取反）       

3     /    \*     %

4    + -

5      <<     >>             左移右移

6 关系运算符   >  >=  <   <=

7      ==     !=

8    & 

9     ^

10   |

11 逻辑运算符  &&

12  ||

13  ？：

14   赋值运算符        =  /= *= %= += -=       <<=(移位后赋值)  >>=   &=  ^= |=

15 ， 逗号运算符   表达式，表达式

### 缓冲区问题

缓冲区就是一块连续的计算机内存区域，它可以保存相同数据类型的多个实例，如字符数组。而缓冲区溢出则是指当计算机向缓冲区内填充数据位数时超过了缓冲区本身的容量，溢出的数据覆盖在合法数据上

堆栈段分为堆（Heap）和栈（Stack）。堆用来存储程序运行时分配的变量；而栈则是一种用来存储函数调用时的临时信息的结构**，如函数调用所传递的参数、函数的返回地址、函数的局部变量等**。在程序运行时由编译器在需要的时候分配，在不需要的时候自动清除。这里需要特别注意的是，堆（Heap）和栈（Stack）是有区别的，很多程序员混淆堆栈的概念，或者认为它们就是一个概念。简单来说，它们之间的主要区别可以表现在如下三个方面

http://c.biancheng.net/view/369.html

xx.cpp

int  giants = 5；             文件作用域 ，外部链接   可在其他外部文件使用，使用时用global声明

static  int dodgers = 3 ；      文件作用域 ，内部连接   仅在该文件使用

详见cpp 324



int a[10]={9,7,8}

int a[]={9,8,7,6,5}

int array[3] [4]={{1,2,3,4},{1,2},{}}

int array[] [4]

char str[10] = {'','',}不够的自动添加‘\0’

char str[] = {"hello"};在末尾添加‘\0’orchar str[] = "hello";