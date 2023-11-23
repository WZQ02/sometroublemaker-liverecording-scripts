# 自用录播压制批处理（Windows）

!!! 注意，由于 CRLF/LF 转换问题，直接从 GitHub 上面下载的源码 zip 中解压出来的批处理无法正常工作。请使用 git pull 拉取源码或从 release 下载“自用录播压制批处理v***.zip”并解压。

这是我之前处理录播文件用到的一些批处理文件，现在我将这些批处理改成了向导式，以便于你使用。
在使用这些批处理脚本之前，请确保已安装这些软件：

- [B站录播姬](https://rec.danmuji.org/)
- [FFmpeg](https://ffmpeg.org/)
- [DanmakuFactory CLI 版（不是 GUI 版）](https://github.com/hihkm/DanmakuFactory)
- [新版 Powershell](https://aka.ms/PSWindows)（用于更改弹幕字幕样式）

双击第一个批处理即可。注意，需将所有文件放置到一个单独的文件夹后，再运行。
这些批处理在我自己的电脑上测试过，但不完全保证在你的电脑上不会出问题。为了尽可能避免问题，用到的所有文件和目录路径最好不要有空格、中文和括号。使用时如果遇到了 bug 请向我告知。