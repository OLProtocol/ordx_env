a1 模式切换：
1.1 normal->insert mode
i：在光标前插入
I: 在行首插入
a：在光标后插入
A: 在行尾插入
o：在下行行首插入
O：在上行行首插入
insert->normal mode
esc/jj

1.2 normal->visual mode
v
visual->normal
esc/v

1.3 normal->cmd mode
:
cmd->normal
esc/:

2 光标移动(normal):
w: 跳到下一个单词开头
b: 跳到本单词或上一个单词开头
e: 跳到本单词或下一个单词结尾
ge:跳到上一个单词结尾
0: 跳到行首
^: 跳到行首开始第一个非空字符
$: 跳到行尾
gg:跳到第一行
G: 跳到最后一行
f{char}: 光标跳到下个{char}所在位置
F{char}: 光标移动到上个{char}所在位置
t{char}: 光标跳到下个{char}的前一个字符的位置
T{char}: 光标移动到上个{char}后一个字符的位置
;: 重复上次的字符查找操作
,: 反向查找上次的查找命令

3 motion:
i: inner a:arround
example 
iw/aw ib/ab iB/aB di{/da{ di"/da" di'/da' di`/da`
i</a< i[/a[ it/at is/as ip/ap

4 operator(normal):
4.1 d(delete):删除
dd dd{n}
diw/daw dib/dab diB/daB di( da< di<

c(change):修改(删除并进入插入模式)
ciw ci<

y(yank):复制
v(visual):选中并进入VISUAL模式
p(paste):将内容粘贴到当前位置(d/y)
u(undo):撤消

5 operation + motion


10 模拟插件
10.1 快速commet注释
gcc gc3j gc}

10.2 easyMotion 快速移动光标
<space><space>[num]s[char]: <space><space>s[char] <space><space>2s[char]

10.3 vim surround
[operator]s[motion][symbol]

ysiw(: 给word加小括号
yank suruound inner word

cs)]: 将小括号换成中括号
change surround ) ]

ds]: 将中括号删除
delete surround ]

ysfr: 将从当前光标位置至指定搜索的字符位置的一段内容加上双引号
yank surround find r

10.4 vim sneak: 通过两个字符实现更强的motion
s/S+[char][char]:向后/向前搜索字符
sDr: 搜索Sr

[num][operator]z[char][char]
2dzPe : delete z(表示用sneak) Pe: 删除光标位置到第2个Pe开头之前内容
2yszPe" : 从光标位置到第2个Pe开头之前加双引号

10.5 gd: go to define

10.6
3j/3k/3h/3l
shift + [:移动到下一个空行的地方
shift + ]:移动到上一个空行的地方
指定行: 17gg / cmd mode: 17<enter>
搜索: /[pattern] + enter +n/N
删除操作:c$, c0,c^
剪切:dd,[number]dd,
redo:ctrl - r
undo:u

