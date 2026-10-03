---
name: github-repo-security-setup
description: リポジトリをpublicにする前後に、`gh api`でGitHub側のセキュリティ設定（Workflowのデフォルト権限のread-only化、外部コントリビューターのWorkflow実行の承認必須化、Secret scanningとPush protectionの有効化）を適用・確認する手順。「公開前のセキュリティ設定をして」「Actionsの権限を絞って」「Secret scanningを有効にして」等の依頼で使う。コードやワークフローYAMLの修正（スクリプトインジェクション対策等）はこのスキルの対象外。
---

# GitHubリポジトリのセキュリティ設定

ワークフローYAMLの修正だけでは防げない、リポジトリ側の設定を`gh api`で適用する手順。これらはリポジトリ設定を外部に反映する操作なので、実行前にユーザーへ対象リポジトリと適用内容を示して確認を取る。

## 前提

- `gh auth status`でログイン済みであること。
- 対象リポジトリのadmin権限があること。`gh repo view --json viewerPermission`が`ADMIN`であれば足りる。
- 権限不足やリポジトリ名の誤りでは、どちらもHTTP 404が返る（権限不足でも403にならない）。404が出たら、先にリポジトリ名と`viewerPermission`を確認する。
- Secret scanningとPush protectionはpublicリポジトリでは無料で使える。privateでは有料プランが必要な場合がある。

## 手順

### 0. 対象リポジトリを特定する

リポジトリ名はタイプミスしやすいので、手入力せず`gh`に解決させる。

```bash
REPO=$(gh repo view --json nameWithOwner --jq .nameWithOwner)
gh repo view --json nameWithOwner,visibility,viewerPermission
```

### 1. Workflowのデフォルト権限をread-onlyにする

`GITHUB_TOKEN`の既定権限を最小にし、Workflowからのpull requestの承認も禁止する。書き込みが必要なジョブは、ワークフロー側の`permissions:`で個別に宣言する。

```bash
gh api -X PUT "repos/$REPO/actions/permissions/workflow" \
  -f default_workflow_permissions=read \
  -F can_approve_pull_request_reviews=false
```

### 2. 外部コントリビューターのWorkflow実行に承認を必須にする

forkからのPRによるWorkflow実行（Actionsの実行時間の消費やsecrets周りの悪用）を、管理者の承認があるまで止める。`all_external_contributors`は、過去にコントリビュートしたことがある人も含め、リポジトリに書き込み権限のない人全員を対象にする。

```bash
gh api -X PUT "repos/$REPO/actions/permissions/fork-pr-contributor-approval" \
  -f approval_policy=all_external_contributors
```

### 3. Secret scanningとPush protectionを有効にする

```bash
gh api -X PATCH "repos/$REPO" \
  -f 'security_and_analysis[secret_scanning][status]=enabled' \
  -f 'security_and_analysis[secret_scanning_push_protection][status]=enabled'
```

## 確認（読み取りのみ）

適用後は、GETで実際の値を確認する。

```bash
gh api "repos/$REPO/actions/permissions/workflow"
# => default_workflow_permissions が "read"、can_approve_pull_request_reviews が false

gh api "repos/$REPO/actions/permissions/fork-pr-contributor-approval"
# => approval_policy が "all_external_contributors"

gh api "repos/$REPO" --jq .security_and_analysis
# => secret_scanning と secret_scanning_push_protection の status が "enabled"
```

## この手順の対象外（必要に応じて別途検討する）

- Dependabot alertsとsecurity updates: `gh api -X PUT "repos/$REPO/vulnerability-alerts"`、`gh api -X PUT "repos/$REPO/automated-security-fixes"`。
- Environment（例: `develop`）のRequired reviewers: `gh api -X PUT "repos/$REPO/environments/<name>" --input -`でJSONの`reviewers`を渡す。1人運用で`prevent_self_review`を有効にすると、自分の実行を承認できなくなる。
- `main`のブランチ保護またはRulesets: 必須レビューを付けると、1人運用では自分のPRをマージできなくなる。
- 接続設定の確認: `git remote -v`のURLにPersonal Access Tokenが埋め込まれていないこと。埋め込まれていた場合はトークンを失効し、`gh auth setup-git`でgitの認証を`gh`に任せる。
