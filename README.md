一些 x86 汇编的示例代码。

# 安装过程

1. 解压 `masm.rar`
2. 安装 `DOSBox-0.74`
3. 在 `DOSBox-0.74` 的安装目录下，双击 `DOSBox 0.74 Options.bat` 
4. 在自动打开的配置文件中，找到 [autoexec] 并加入下面的命令

```batch
mount c d:\path_to_repo
set PATH=%PATH%;c:\masm\bin
c:
cd src
```

5. 找到 [sdl] 并修改为

```batch
fullscreen=false
fulldouble=false
fullresolution=original
windowresolution=1080x800
output=opengl
autolock=true
sensitivity=100
waitonerror=true
priority=higher,normal
mapperfile=mapper-0.74.map
usescancodes=true
```

6. 打开 DOSBox 就可以编程了
