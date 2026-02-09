---
argument-hint: [message]
description: Implement feature/bugfix/tech improvement with a TDD approach
---

.claude/claudeRes/scripts/feature_spec.md に書かれたスペックに基づき、
下記の手順と制約に従い TDD で実装を進めてください

## 手順

1. スペックの理解、現状の実装確認
2. 実装のために必要な確認事項をユーザに確認し、スペックを明確化
3. (スペックに通常の手段では実装できない突飛な指定があれば代替案を提示)
4. WEB での調査が必要なら、修正要件を web-research-agent に伝え、実装法を調査・提案してもらう
5. web-research-agent のレポートを確認
6. この時点で新たに必要な確認事項が発見されたならユーザに確認し、修正要件を再度明確化
7. 実装の方針をユーザに提示し、承認を得る
   - ユーザに PoC を要求されたら poc-feasibility-expert subagent を呼び出して PoC を実行し、その結果をユーザに提示
8. 実装項目の確定
9. 実装項目を適切なサブタスクに分割し、リストアップしてユーザの承認を得る
10. プレシデンス・ダイアグラム法の要領でサブタスクの依存関係を整理
11. feature のためのブランチをどこにどう作るか提示し、その通り作成するか、ユーザが手動で作成するのを促しユーザのブランチ作成を待つ
12. 作成した feature のブランチにチェックアウト
13. 要件、実装項目、サブタスク一覧とプレシデンス・ダイアグラムをまとめて、マークダウンファイルに保存(<YY_MM_DD>\_solution*design*<appropriate-task-name>.md)
    - Save Location: `.claude/claudeRes/docs` (.claude は project-level のもの)
    - もし上のパスが存在しなければ `.claude/claudeRes/docs` ディレクトリを新たに作成し、そこに保存
14. ユーザにマークダウンファイルを提出し、修正/承認を促す。
15. 修正されたマークダウンファイルを確認し、最終方針を認識
16. マークダウンファイルを tdd-implementer subagent に提出し、プレシデンス・ダイアグラムの先頭から、各サブタスクに対して順々に TDD で実装してもらう
17. TDD 実装が完了したらユーザに完了を報告,実装レポートを`.claude/claudeRes/docs` ディレクトリにマークダウンファイルで作成(<YY_MM_DD>\_dev*final*<appropriate-task-name>.md)
    - 末尾に Pull Request の Description にコピー&ペーストで使える簡潔な説明文を追加すること: Background, Main Changes, Notes の 3 章構成。各章 3-6 行程度、最大でも 10 行程度。

## 制約

1. 確たるソリューションが見つからない複雑な問題に対しては、poc-feasibility-expert subagent を呼び出し、poc を実施してもらってください
2. TDDによるアプローチが過剰な場合は、ユーザにその旨を伝え、了承を得た上でより簡素なアプローチで実装を行うこと。


## ドキュメント更新確認フォーマット

既存のドキュメント更新時は、以下のフォーマットで変更内容を出力し、変更前にユーザに承認を求める:

```
=== Document Update Confirmation ===

File: {document_file_path}

Changes Summary:
- {変更項目1の一文説明}
- {変更項目2の一文説明}
- {変更項目3の一文説明}

--- Before ---
{変更される既存の内容}

--- After ---
{更新後の内容}

=== End of Update Preview ===
```

承認後にのみドキュメントを更新する。
