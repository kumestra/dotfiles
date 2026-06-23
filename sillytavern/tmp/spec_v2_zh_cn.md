# 角色卡 V2：规范

本文档描述了添加到 V1 角色卡嵌入式 JSON 中的新 JSON 字段。
V1 指的是截至 2023 年 5 月 4 日角色卡生态系统中当前使用的格式。

[面向新实现者的角色卡 V1 规范](./spec_v1.md)

[阅读 MUST、SHOULD 和 MAY 的定义](./keyword_definitions.md)

**本规范已于 5 月 17 日验证，可以采用。**

## 目录

- [新字段](#新字段)
  * [`spec`](#spec)
  * [`spec_version`](#spec_version)
  * [`creator_notes`](#creator_notes)
  * [`system_prompt`](#system_prompt)
  * [`post_history_instructions`](#post_history_instructions)
  * [`alternate_greetings`](#alternate_greetings)
  * [`character_book`](#character_book)
  * [`tags`](#tags)
  * [`creator`](#creator)
  * [`character_version`](#character_version)
  * [`extensions`](#extensions)

## 新字段

V1（当前）规范可以用以下 TypeScript 定义描述：

```ts
type TavernCardV1 = {
  name: string
  description: string
  personality: string
  scenario: string
  first_mes: string
  mes_example: string
}
```

V2 规范可以描述为：

```ts
type TavernCardV2 = {
  spec: 'chara_card_v2'
  spec_version: '2.0' // 5 月 8 日新增
  data: {
    name: string
    description: string
    personality: string
    scenario: string
    first_mes: string
    mes_example: string

    // 新字段从这里开始
    creator_notes: string
    system_prompt: string
    post_history_instructions: string
    alternate_greetings: Array<string>
    character_book?: CharacterBook

    // 5 月 8 日新增
    tags: Array<string>
    creator: string
    character_version: string
    extensions: Record<string, any>
  }
}

/**
 * `name?: string` 中的 ? 表示 JSON 中可以不存在 `name` 属性
 *（也就是该属性是可选的）
 * 编辑器可以不支持可选属性，前端也可以忽略可选属性，
 * 但如果数据中已经存在这些属性，则绝不能销毁它们。
 *
 * `extensions` 属性可以包含任意键值对，但鼓励你
 * 为键添加命名空间以防止冲突，并且绝不能从数据中销毁
 * 未知键值对。`extensions` 是必填字段，并且必须
 * 默认设为 `{}`。`extensions` 存在于角色书本身以及
 * 每个条目中。
 **/
type CharacterBook = {
  name?: string
  description?: string
  scan_depth?: number // agnai："Memory: Chat History Depth"
  token_budget?: number // agnai："Memory: Context Limit"
  recursive_scanning?: boolean // 没有 agnai 等价项。条目内容是否可以触发其他条目
  extensions: Record<string, any>
  entries: Array<{
    keys: Array<string>
    content: string
    extensions: Record<string, any>
    enabled: boolean
    insertion_order: number // 如果插入两个条目，较低的 "insertion order" = 插入位置更靠上
    case_sensitive?: boolean

    // 当前在 SILLY 中没有等价项的字段
    name?: string // 不用于提示工程
    priority?: number // 如果达到 token 预算，较低的 priority 值 = 更早被丢弃

    // 当前在 AGNAI 中没有等价项的字段
    id?: number // 不用于提示工程
    comment?: string // 不用于提示工程
    selective?: boolean // 如果为 `true`，需要同时来自 `keys` 和 `secondary_keys` 的键才能触发条目
    secondary_keys?: Array<string> // 参见字段 `selective`。如果 selective == false，则忽略
    constant?: boolean // 如果为 true，始终插入提示词中（在预算限制内）
    position?: 'before_char' | 'after_char' // 条目是放在角色定义之前还是之后
  }>
}
```

因此，同时支持 V1 和 V2 的前端会使用类似这样的类型：

```ts
type TavernCard = TavernCardV1 | TavernCardV2
```

如果你不确定这在普通 JavaScript 中意味着什么，请查看[说明文档中 "Proposed fields" 一节的介绍](./README.md#proposed_fields)

**除嵌套在 `data` 属性内部之外，所有 V1 字段都遵循 [V1 规范](./spec_v1.md)。**

### `spec`

此字段的值 **MUST** 为 `"chara_card_v2"`。

### `spec_version`

此字段的值 **MUST** 为 `"2.0"`。

### `creator_notes`

此字段的值 **MUST NOT** 用于提示词中。此字段的值 **SHOULD** 对 bot 用户非常容易发现（至少 **SHOULD** 显示一个段落）。

### `system_prompt`

前端的默认行为 **MUST** 是使用此字段中的值替换用户理解中的 "system prompt" 全局设置。（例外：如果字段值为空字符串，则 **MUST** 使用用户的 "system prompt" 设置或内部回退值。）

前端 **MUST** 支持 `{{original}}` 占位符，该占位符会被替换为在没有角色 `system_prompt` 时前端原本会使用的 "system prompt" 字符串（例如用户自己的 system prompt）。

前端 **MAY** 提供替换或补充角色卡 system prompt 的方式（除直接编辑卡片之外），但这 **MUST NOT** 是默认行为。

### `post_history_instructions`

前端的默认行为 **MUST** 是使用此字段中的值替换用户理解中的 "ujb/jailbreak" 设置。（例外：如果字段值为空字符串，则 **MUST** 使用用户的 "ujb/jailbreak" 设置或内部回退值。）

前端 **MUST** 支持 `{{original}}` 占位符，该占位符会被替换为在没有角色 `system_prompt` 时前端原本会使用的 "ujb/jailbreak" 字符串（例如用户自己的 ujb/jailbreak）。

前端 **MAY** 提供替换或补充角色卡 post_history_instructions 的方式（除直接编辑卡片之外），但这 **MUST NOT** 是默认行为。

### `alternate_greetings`

字符串数组。

前端 **MUST** 为角色的第一条消息提供 "swipes"，此数组中的每个字符串都是一个额外的 "swipe"。

### `character_book`

角色专属 lorebook。

此字段的类型定义见[新字段介绍](#新字段)。

前端默认 **MUST** 使用角色 lorebook。

角色编辑器 **MUST** 以指定格式保存角色 lorebook。

角色 lorebook **SHOULD** 与用户的 "world book"/"world info"/"memory book" 叠加使用。（角色书 **SHOULD** 完全优先于世界书。）

### `tags`

字符串数组。

对哪些字符串有效没有限制。

此字段 **SHOULD NOT** 用于提示工程。

此字段 **MAY** 用于前端排序/过滤目的（**SHOULD** 不区分大小写）。

### `creator`

此字段 **MUST NOT** 用于提示工程。

此字段 **MAY** 显示在前端。

### `character_version`

此字段 **MUST NOT** 用于提示工程。

此字段 **MAY** 显示在前端并用于排序。

### `extensions`

此字段 **MUST** 默认设为空对象（`{}`）。

此字段 **MAY** 包含任意 JSON 键值对。

角色编辑器在导入和导出角色卡时 **MUST NOT** 销毁未知键值对。

应用程序 **MAY** 在此对象中存储任何未指定的数据。

应用程序 **SHOULD** 为其使用的任何键添加命名空间以防止冲突，例如
`"agnai/voice": /* ... */` 或 `"agnai_voice": /* ... */` 或 `"agnai": { "voice": /* ... */ }"`。
