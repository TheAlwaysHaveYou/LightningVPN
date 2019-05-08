# ios闪连

#### 使用说明

1. 对于NEKit只能使用carthage导入，不能直接carthage update，因为当前swift版本相对于拉下来的framework版本有可能不同，导致拉不下来。 使用carthage update --no-use-binaries --platform ios命令导入，不从远程库里面拉framework，而是将工程拉下来，根据当前Xcode版本的内容进行打包成framework。
