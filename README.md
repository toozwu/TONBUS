# TON 中文社区——TONBUS 运营

Telegram Open Network（TON） 是 Telegram 的区块链项目。官方通过邮件定向邀请了部分开发者内测。TONBUS 是被邀请的开发者，本库里的文件为官方06.09更新的 Source。

- TON 中文社区 Telegram 讨论组：https://t.me/ton_china     
- TON 中文社区 Telegram 中文 Channel：https://t.me/tonbus
- TON 中文社区 微信讨论组：（加微信：toozwu，备注 TON）
- TON 中文社区 微博：[@TON中文社区](https://weibo.com/sharing2)
- TON 中文白皮书：https://mp.weixin.qq.com/s/WLlD088acBDfjUM4bCEd0A 译者：[@吴泰_tooz](https://weibo.com/opeakt)
- Github：https://github.com/opeakt/TONBUS
看到这里请记得给我们点个 Star ✨ 哦～～谢谢

## TON 时间线：

- 2019年10月31日 前上线 TON 主网
- 今天
- 2019年8月6日，TON 社区和 Bgogo 社区达成合作。
- 2019年8月3日，TON 社区和无涯社区的AMA about TON whitepaper.
- 2019年7月29日，TON 社区和 CoinEx 社区的AMA about TON whitepaper.
- 2019年7月20日，TON 社区和 CoinBene 社区的AMA about TON whitepaper.
- 2019年7月15日，TON 社区和 TONBUS 社区的AMA about TON whitepaper.
- 2019年7月10日，TON 社区和 Real Satoshi 社区的AMA about TON whitepaper.
- 2019年7月10日，TON 社区和 BiHODL 社区的AMA about TON whitepaper.
- 2019年7月10日，日本 Liquid 交易所进行 IOU/IEO（个人投资者份额转让）；转让价格：3.5美金
- 2019年7月8日，BISS 币市交易所 Listing GRAM。TON 社区和 BISS 社区的AMA about TON whitepaper.
- 2019年4月轻节点代码开放，邮件邀请内测。
- 2018年1月第二笔投资，1.03USD价格半公开+数字货币投资机构。
- 2017年12月第一笔投资，0.37USD价格，传统机构投资者。

## TONBUS Instruction
### Installation
### If you are windows user, you can build docker container using our dockerfile
 1. Download docker desktop
 2. Download TONBUS project from our repository (please star us :P if you like it)
 3. Enter TONBUS main directory
 4. Run the following command in your powershell

    build docker images
    ```
    docker build . -t tonbus
    ```

    find the image id you just built
    ```
    docker images
    ```

    enter your docker container
    ```
    docker run -it -v "$(pwd):/data" <docker image id>
    ```

    set fift env variable
    ```
    export FIFTPATH=/data/lite-client/crypto/fift/lib
    ```

### If you are Mac user, you still use docker or your local system
 1. Download TONBUS project from our repository (please star us :P if you like it)
 2. Enter TONBUS main directory
 3. Run the following command in your powershell

    set fift env variable
    ```
    export FIFTPATH=<source path>/lite-client/crypto/fift/lib
    ```

## Test Network Instruction
 1. Enter test-network-run directory
 2. Start TON client
    ```
    ./lite-client -C ton-lite-client-test1.config.json
    ```
 3. Create a new wallet
    Pre-compile wallet code
    ```
    ./fift new-wallet.fif
    ```

    Deploy smart contract
    ```
    ./lite-client -C ton-lite-client-test1.config.json
    sendfile new-wallet-query.boc
    last
    getaccount -1:<your account address>
    ```

 4. Get some grams from faucet

    Edit testgiver.fif to your account address and faucet sequence number

    Pre-compile test giver code
    ```
    ./fift testgiver.fif
    ./lite-client -C ton-lite-client-test1.config.json
    sendfile wallet-query.boc
    last
    getaccount -1:8156775b79325e5d62e742d9b96c30b6515a5cd2f1f64c5da4b193c03f070e0d
    getaccount -1:<your account address>
    ```

 5. Transfer some funds to other account

    Pre-compile transaction code
    ```
    ./fift send-transaction.fif
    ./lite-client -C ton-lite-client-test1.config.json
    sendfile new-wallet-send-transaction-query.boc
    last
    getaccount -1:<your account address>
    ```
