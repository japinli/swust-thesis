swust-thesis
============

The thesis template of LaTeX for Southwest University of Science and
Technology.

西南科技大学*LaTeX*论文模板。

备注：个人使用，非校方授权。

LaTeX 安装
--------

下载[TeX Live][]，参看[安装教程][]进行安装。

swustthesis 获取
----------------

1. 克隆代码
   ```
   git clone https://github.com/japinl/swust-thesis.git
   ```
2. 点击`Clone or download`选择`Download ZIP`下载并解压。

进入`swustthesis`目录，在命令提示符或终端中使用`latexmk`编译文档，查看
`main.pdf`效果，可以使用`latexmk -c`清理生成的中间文件。

备注：由于本科论文中使用了华文行楷，若需要在Linux系统下使用，需要预先
安装该字体。具体安装方式查看
[此处](http://blog.csdn.net/Kai_gai/article/details/51281440)。

swustthesis 说明
----------------

**swustthesis**类包含三种论文模板可通过如下选项设置。

| 选项     | 说明                      |
|:--------:|---------------------------|
| doctor   | 学士（本科）论文（默认）  |
| master   | 硕士论文                  |
| bachelor | 博士论文                  |

此外还可以通过设置打印选项。

| 选项    | 说明                          |
|---------|-------------------------------|
| oneside | 单面打印（学士论文默认）      |
| twoside | 双面打印（硕士、博士论文默认）|

例如，编写硕士论文并要单面打印可以按如下方式加载`swustthesis`类。

```
\documentclass[oneside, master]{swustthesis}
```

[TeX Live]: http://tug.org/texlive/
[安装教程]: http://tug.org/texlive/quickinstall.html
