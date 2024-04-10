# iOS-Training
業務に近いかたちでアプリ開発を行いながら、  
iOSアプリ開発の基礎復習、実務スキルを身に付けるための研修です。

## 概要
天気予報アプリを開発していただきます。  

## 天気予報API
`YumemiWeather`というライブラリを使用してください。  
SwiftPackageManagerに対応しています。

インストール方法やAPI仕様は以下を参照ください。  
[YumemiWeather](Documentation/YumemiWeather.md)

## iOS-Trainingの進め方
1. 空白の授業用のリポジトリを作成
    1. 新しくWeatherでリポジトリを作成してください。
1. WeatherリポジトリにXcodeProjectを作成  
1. XcodeProjectに[YumemiWeather](Documentation/YumemiWeather.md)を導入
1. 課題用のブランチを切って実施  01_AutoLayout、02_API　など
2. 課題が完了したらmainにマージする
1. 次の課題を実施


# Session
1. [AutoLayout](Documentation/01_AutoLayout.md)
1. [API](Documentation/02_API.md)
1. [Lifecycle](Documentation/03_Lifecycle.md)
1. [Delegate](Documentation/04_Delegate.md)
1. [Error](Documentation/05_Error.md)
1. [Json](Documentation/06_Json.md)
1. [Codable](Documentation/07_Codable.md)
1. [ThreadBlock](Documentation/08_ThreadBlock.md)
1. [Closure](Documentation/09_Closure.md)
1. UIKit
    1. [UITableView](Documentation/10-1_UITableView.md)
    1. [UINavigationController](Documentation/10-2_UINavigationController.md)

[^git-rebase]: このようなケースで `rebase` コマンドを使うことが必ずしも正しいとは限りません。 どのような方法をとるかはチームで議論するべきと考えます。 ただ、この研修は「`rebase`コマンドを使ってみる」ことも研修の一部としています。

## 補足事項
- 後の課題に含まれる技術要素を先に取り入れてもOKです
