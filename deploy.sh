#!/bin/bash
# 配置したい設定ファイル
dotfiles=(.zshrc .tmux.conf)

# .zshrc と .tmux.conf という設定ファイルのシンボリックリンクを
# ホームディレクトリ直下に作成する
for file in "${dotfiles[@]}"; do
        ln -svf $file ~/
done

##### 使い方 #####
# 初回は実行権限の付与が必要
# chmod +x deploy.sh

# スクリプトを実行しシンボリックリンクを一気に作成する
# ./deploy.sh