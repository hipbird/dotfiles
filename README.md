# dotfiles

ドットファイルをまとめて管理し、CUI環境のセットアップを容易にする。

ドットファイルの管理には [ssh0](https://github.com/ssh0) さんの [dot](https://github.com/ssh0/dot/blob/master/README_ja.md) を利用する。

zsh の環境設定には [Prezto](https://github.com/sorin-ionescu/prezto) を利用。  
※ Prezto は、ドットファイルに一式含まれる。

## 最低限の前提環境

  - bash (zsh)
  - git
  - homebrew

## 環境構築方法
  1. homebrew で zsh をインストールする。
    ```bash
    brew install zsh
    ```

  2. homebrew でインストールした zsh をログインシェルにする
    ```bash
    # /usr/local/bin/zsh をパスに追加

    $ sudo vim /etc/shells

    /bin/bash
    /bin/csh
    /bin/ksh
    /bin/sh
    /bin/tcsh
    /bin/zsh
    /usr/local/bin/zsh  # この行を最後に追加する
    ```

    vim を抜けて

    ```bash
    $ chsh -s /usr/local/bin/zsh
    # パスワードを入れれば反映
    ```

  3. dot を `~/.zsh/plugins/dot` に `git clone` する。
    ```zsh
    git clone https://github.com/ssh0/dot.git ~/.zsh/plugins/dot
    ```

  4. dotfiles を `~/` に `.dotfiles` として `git clone` する。
    ```zsh
    git clone https://HipBird@bitbucket.org/HipBird/dotfiles.git ~/.dotfiles
    ```

  5. `~/.dotfiles/dotzshrc` を `.zshrc` として `~/` へシムリンクする
    ```zsh
    ln -nfs ~/.dotfiles/dotzshrc ~/.zshrc
    ```

    ※このシムリンクは dot を動かすための一時的なもので、次の手順で置き換えられる

  6. dotlink ファイルにしたがって、シムリンクを張る
    ```zsh
    dot set
    ```

  7. `~/.ssh` と秘密鍵のパーミッションを強化する
    ```zsh
    $ chmod 0700 .ssh
    $ chmod 0600 ~/.ssh/id_rsa
    ```

## 環境構築後の使い方

  - 新しい設定ファイルを dot 管理下に追加

    ```zsh
    dot add FILE $DOT_DIR/path/to/store/the/file

    # ex) $ dot add .ssh .dotfiles/ssh
    ```

  - dotlinkファイルの編集

    `.dotfiles/dotlink` ($DOT_DIR/dotlink) を編集する。

    `,` で区切り、左側が実体のパス。右側がシンボリックリンクを張るパス。

    `/` で始まるパスを指定した時には絶対パスとして扱われる。  
    省略すると頭に `$DOT_DIR/` や `$HOME/` が付いたものとして解釈される。

## 参考
  詳細は [README](https://github.com/ssh0/dot/blob/master/README_ja.md) や [Qiita の投稿](http://qiita.com/ssh0/items/930127d079ccd08bc18a) を参照
