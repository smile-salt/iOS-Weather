# コールバック

完了時の処理を引数で渡しておく手法があります。  
例えば、UIViewControllerの [present(_:animated:completion:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-present) など。

Delegateパターンよりも全体の処理の流れが追いやすくなると思います。  
また、メソッドが1〜2つのDelegateですと、コールバックを用いた方が実装量も少なくなるでしょう。  
反対に、Modelが要求するコールバックが多いと、Delegateパターンを用いて一つの型にまとめた方が管理し易い場合もあるでしょう。

## 課題
- Delegateで受け取っていたAPIの結果を、コールバック形式で受け取るように変更する
