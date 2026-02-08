# app-dev-suite Workflow Diagrams

## 1. Overview

```mermaid
flowchart LR
    subgraph Phase1["Phase 1: /feasibility-study"]
        F1[Spec読込]
        F2[コードベース調査\n+ Web調査]
        F3[方針候補作成\n+ 選択]
        F1 --> F2 --> F3
    end

    subgraph Phase2["Phase 2: /solution-design"]
        S1[Feasibility Report\n読込]
        S2[サブタスク分割\n+ 依存関係整理]
        S3[テストケース定義]
        S1 --> S2 --> S3
    end

    subgraph Phase3["Phase 3: /implement-tdd"]
        I1[Solution Design\n読込]
        I2[サブタスク毎に\nTDD実装]
        I3[統合テスト\n+ レポート]
        I1 --> I2 --> I3
    end

    Phase1 -- "feasibility_report.md" --> Phase2
    Phase2 -- "solution_design.md" --> Phase3

    style Phase1 fill:#e8f4fd,stroke:#2196F3
    style Phase2 fill:#fff3e0,stroke:#FF9800
    style Phase3 fill:#e8f5e9,stroke:#4CAF50
```

---

## 2. Detailed Flow

### Phase 1: Feasibility Study

```mermaid
flowchart TD
    Start(["/feasibility-study"]) --> Init["0. Config読込\nMetrics初期化"]
    Init --> TaskName["1. タスク名決定\n出力パス設定"]
    TaskName --> Ultra{"2. Ultrathink\n使用?"}
    Ultra --> Investigate

    subgraph Investigate["3. 並列調査"]
        direction LR
        E1["Explore:\n類似実装"]
        E2["Explore:\nテストパターン"]
        E3["Explore:\n影響範囲"]
        W1["Web Research:\nベストプラクティス"]
    end

    Investigate --> Clarify["4. 不明点確認\n(AskUser)"]
    Clarify --> Candidates["5-6. 方針候補リスト作成\n+ document-summarizer で要約"]

    Candidates --> Select{"7. 方針選択\n(AskUser)"}
    Select -- "方針確定" --> Report
    Select -- "PoC検証" --> PoC["poc-feasibility-expert\nで検証実施"]
    Select -- "追加調査" --> AddResearch["追加調査実施\n(Explore / Web)"]
    PoC --> Select
    AddResearch --> Select

    Report["8. 最終レポート作成\nfeasibility_report.md\n+ feasibility_details/"]
    Report --> QG{"9. Quality Gate\nチェックリスト承認"}
    QG -- "Pass" --> Complete["10. Metrics保存\nタスク完了"]
    QG -- "Block" --> Fix["問題修正"] --> QG
    QG -- "Warn" --> Confirm{"継続確認"} --> Complete

    style Start fill:#2196F3,color:#fff
    style Investigate fill:#e3f2fd
    style Select fill:#fff9c4
    style QG fill:#fce4ec
```

### Phase 2: Solution Design

```mermaid
flowchart TD
    Start(["/solution-design"]) --> Init["0. Config読込\nMetrics読込"]
    Init --> Source["1. Feasibility Report\n取得 (-s or 自動検出)"]
    Source --> PrevTask["2. 前タスク確認\n完了処理"]
    PrevTask --> NewTask["3. タスク作成"]
    NewTask --> ReadReport["4. Report読込"]

    ReadReport --> InitDesign["5. Initial Design作成\n要件整理 + 実装項目\n+ 高レベルテストケース"]
    InitDesign --> Approve1{"6. Initial Design\n承認 (AskUser)"}
    Approve1 -- "修正要求" --> InitDesign

    Approve1 -- "承認" --> DeepInvestigate

    subgraph DeepInvestigate["7. 並列コードベース調査"]
        direction LR
        D1["Explore:\n変更対象ファイル"]
        D2["Explore:\nテスト対象"]
        D3["Explore:\n依存コンポーネント"]
    end

    DeepInvestigate --> Subtask["8. サブタスク分割\nMermaid依存関係図"]
    Subtask --> Doc["9. Solution Design\nドキュメント保存"]
    Doc --> Summary["10. document-summarizer\nで要約表示"]

    Summary --> Approve2{"11. 最終承認\n(AskUser)"}
    Approve2 -- "追加検討" --> AddStudy["追加調査\n+ ドキュメント更新"]
    AddStudy --> Approve2
    Approve2 -- "承認" --> QG{"12. Quality Gate"}
    QG --> Complete["13. Metrics保存\nタスク完了"]

    style Start fill:#FF9800,color:#fff
    style DeepInvestigate fill:#fff3e0
    style Approve1 fill:#fff9c4
    style Approve2 fill:#fff9c4
    style QG fill:#fce4ec
```

### Phase 3: TDD Implementation

```mermaid
flowchart TD
    Start(["/implement-tdd"]) --> Init["0. Config読込\nMetrics読込"]
    Init --> Source["1. Solution Design\n取得 (-s or 自動検出)"]
    Source --> PrevTask["2. 前タスク確認"]
    PrevTask --> NewTask["3. タスク作成"]
    NewTask --> ReadDesign["4. Solution Design読込\nサブタスク・依存関係把握"]
    ReadDesign --> Branch["5. ブランチ作成\n+ チェックアウト"]

    Branch --> LoopStart{"6. 次の\nサブタスク?"}
    LoopStart -- "あり" --> DetailDesign

    subgraph SubtaskLoop["6. サブタスク実装ループ"]
        DetailDesign["a. 詳細設計\nテストケース定義\n+ テンプレート適用"]
        DetailDesign --> ApproveDesign{"詳細設計\n承認?"}
        ApproveDesign -- "承認" --> TDD
        ApproveDesign -- "修正" --> DetailDesign

        TDD["b. TDD実装\ntdd-implementer agent\nRed → Green → Refactor"]
        TDD --> Retro["c. 振り返り\nギャップ記録\n+ 品質チェック"]
    end

    Retro --> LoopStart
    LoopStart -- "全完了" --> Integration["7. 統合テスト実行\n全テスト確認"]
    Integration --> ImplReport["8. 実装レポート作成\n+ PR Description"]
    ImplReport --> QG{"9. Quality Gate"}
    QG --> Complete["10. Metrics保存\nタスク完了"]

    style Start fill:#4CAF50,color:#fff
    style SubtaskLoop fill:#e8f5e9
    style ApproveDesign fill:#fff9c4
    style QG fill:#fce4ec
```

### Supporting System

```mermaid
flowchart LR
    subgraph Skills["User-Invocable Skills"]
        FS["/feasibility-study"]
        SD["/solution-design"]
        IT["/implement-tdd"]
        SW["/setup-wizard"]
        SF["/small-feature"]
        GS["/generate-slides"]
    end

    subgraph Background["Background Skills"]
        QG["quality-gate\nチェックリスト・Metrics・Gate判定"]
    end

    subgraph Agents["Subagents"]
        EX["Explore\nコードベース探索"]
        WR["web-research-expert\n技術調査"]
        POC["poc-feasibility-expert\nPoC実装"]
        TDD["tdd-implementer\nTDD実装"]
        DS["document-summarizer\n要約生成"]
    end

    subgraph Config["Configuration"]
        CD["config.default.yaml"]
        CU["config.yaml (user)"]
    end

    Skills --> Background
    Skills --> Agents
    Config -.->|"Step 0で読込"| Skills

    style Background fill:#f3e5f5,stroke:#9C27B0
    style Agents fill:#e0f2f1,stroke:#009688
    style Config fill:#fafafa,stroke:#9E9E9E
```
