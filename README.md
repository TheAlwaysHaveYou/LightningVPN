# ios闪连

#### 使用说明
操作流程
1，git clone git@github.com:TheAlwaysHaveYou/LightningVPN.git
2，pod update
3，carthage update --no-use-binaries --platform ios
        对于NEKit只能使用carthage导入，不能直接carthage update，因为当前swift版本相对于拉下来的framework版本有可能不同，导致拉不下来。 使用carthage update --no-use-binaries --platform ios命令导入，不从远程库里面拉framework，而是将工程拉下来，根据当前Xcode版本的内容进行打包成framework。

4，修改 Bundle Idenfifier  
5，将Network Extensions 和Personal VPN 这两个权限打开
![](https://github.com/TheAlwaysHaveYou/LightningVPN/raw/master/sourse/1563784087757.jpg)

6，然后代码里面配置SS服务器的IP，端口，密码，等等。
7，就可以跑起来了。
