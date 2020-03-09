    python3 默认是按utf-8编码自己的脚本（xx.py文件）的，如你的xx.py文件内容为文本  “这是我的第一个python程序”  点ctrl+s或者保存时 该文本内容会按照utf-8的对照格式将二进制存入磁盘，即存入磁盘的值为111110001011..............下图对应的是16进制“易识别”格式
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200102091701256.png)
当解释器执行文本是会按照utf-8的对应规则把这些二进制转换为相应的可识别的文本“这是我的第一个python程序”进行处理。具体的处理过程涉及编译原理，暂且不讨论 下面我们在python3语法层面上讨论编码：
    python3 str 默认是以unicode对照的二进制格式在内存里的
    python3 还有一种bytes 可以按多种编码格式存在于内存（utf-8 gbk。。）
    ![在这里插入图片描述](https://img-blog.csdnimg.cn/20200102092941309.png)
   python3的len()函数对于bytes是按字节获取其长度
   而对于str却不是按字节来获取长度的是按其字符（1个字符可对应多个字节）
    ![在这里插入图片描述](https://img-blog.csdnimg.cn/20200102093251646.png)
    由上图亦可知以不同的编码存储在硬盘或磁盘上所占的字节是不一样的（utf-8 6个字节  gbk 4个字节）

总上你在python3中open一个文件时最好先知道其编码格式下面提供一种简单方式
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200102094921929.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMDY3ODc5,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200102094947680.png)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200102095014930.png)

最后做一下读取文本时文本大小的区分
import os
filesize = os.path.getsize(path)
这种方法获得的字节数是磁盘实际所占字节数
（一般大于文本内容实际字节数（多余的自己用于服务存储））
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200102095919350.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMDY3ODc5,size_16,color_FFFFFF,t_70)
即得到的是占用空间的大小

而 file 的open（）read()然后len（）
只有在二进制读取时获取的才是真正的文本字节大小
而已其他编码读取时获取的是字符的个数
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200102100432361.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMDY3ODc5,size_16,color_FFFFFF,t_70)

重点是切勿乱用encde读取文件：假如该文件是二进制文件 以utf-8读取时除了有乱码 ，len()统计数据字节数不正确外;还存在如果二进制文件内有特殊字符0x00（文本结束标志）时，后面的文本就会直接放弃读取，得到不完整的文本
        如想自己实践，可写一下种子文件的解析
