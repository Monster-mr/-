# 利用 vue-cli引入第三发postcss插件的过程

默认情况下vue-loader 也是按postcss进行css加载的 故修改webpack配置文件跟平时不太一样
如下提供三种方法（以填入tailwindcss插件为例）
（1）直接在根目录的postcssrc.js添加插件（插件名称用引号括住 后面的大括号是插件选项）。.![在这里插入图片描述](https://img-blog.csdnimg.cn/20191229140109572.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMDY3ODc5,size_16,color_FFFFFF,t_70)
(2)删除postcssrc.js 在根目录下建立postcss.config.js 

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191229140541450.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMDY3ODc5,size_16,color_FFFFFF,t_70)
（3）直接在vue-loader配置文件里添加我们的postcss插件tailwindcss的引入是postcss：[require('tailwindcss')]
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191229141051488.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMDY3ODc5,size_16,color_FFFFFF,t_70)
一下是官方文档地址 
https://vue-loader-v14.vuejs.org/zh-cn/features/postcss.html
https://github.com/michael-ciniawsky/postcss-load-config

还有一个小坑 vue-cli的dev-server模式下主index.html引入css 路径被做了限制只可以在static文件夹内引入
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019122914154150.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMDY3ODc5,size_16,color_FFFFFF,t_70)
