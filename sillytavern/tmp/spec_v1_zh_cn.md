# 角色卡 V1：规范

本文档用于在存在歧义时作为参考，也供未来新的实现者使用。
[阅读 MUST、SHOULD 和 MAY 的定义](./keyword_definitions.md)

## 目录

- [嵌入方法](#嵌入方法)
- [字段](#字段)
  * [name](#name)
  * [description](#description)
  * [personality](#personality)
  * [scenario](#scenario)
  * [first_mes](#first_mes)
  * [mes_example](#mes_example)

## 嵌入方法

- 不带图片的 .json 文件。出于用户友好性考虑，不推荐使用。
- PNG/APNG：在 "Chara" EXIF 元数据字段中存放以 base64 编码的 JSON 字符串。
- WEBP：**由于存在技术歧义，本规范不涵盖。**

## 字段

当前格式可以表示为以下 TypeScript 类型：

```ts
type TavernCard = {
  name: string
  description: string
  personality: string
  scenario: string
  first_mes: string
  mes_example: string
}
```

所有字段都是必填字段，并且 **MUST** 默认设为空字符串，而不是 null 或缺失/undefined。

在发送给 AI 的提示词中，字段 `description`、`personality`、`scenario`、`first_mes` 和 `mes_example` **MUST** 替换以下魔法字符串，并且搜索时 **不区分大小写**（例如 `<BOT>` 和 `<bot>` 都有效）：
- 将 {{char}} 或 `<BOT>` 替换为卡片 `name` 字段的值
- 将 {{user}} 或 `<USER>` 替换为应用程序设置的显示名称。

用户名称的默认值 **MUST** 存在。

是否应在 `name` 字段内替换 {{user}} 和 `<USER>` 是一个 **UNSPECIFIED** 的边界情况。

每个字段的详细说明如下。

### `name`

用于标识一个角色。

### `description`

角色的描述。

默认情况下，**SHOULD** 在每个提示词中包含该字段。

现有项目使用的面向用户的替代名称：

- ZoltanAI："Personality"
- Agnai："Persona Attributes" 和 "{{personality}}"
- Silly："Description"

### `personality`

角色性格的简短摘要。

默认情况下，**SHOULD** 在每个提示词中包含该字段。

现有项目使用的面向用户的替代名称：

- ZoltanAI："Summary"
- Agnai：尚无名称
- Silly："Personality summary"

### `scenario`

对话当前的上下文和情境。

默认情况下，**SHOULD** 在每个提示词中包含该字段。

### `first_mes`

聊天机器人发送的第一条消息，也称为 "greeting"。

聊天机器人 **MUST** 是第一个发送消息的一方，并且该消息
**MUST** 是 `first_mes` 中的字符串。

### `mes_example`

示例对话。**MUST** 预期 bot 制作者会按如下格式编写示例
对话：

```
<START>
{{user}}: hi
{{char}}: hello
<START>
{{user}}: hi
Haruhi: hello
```

`<START>` 标记新对话的开始，并且 **MAY** 被转换
（例如转换为一条 OpenAI System 消息，内容为 "Start a new conversation."）

默认情况下，示例对话 **SHOULD** 仅在实际对话填满上下文大小之前
包含在提示词中；之后应剪除示例对话，以便为实际对话历史腾出
空间。此行为 **MAY** 允许用户配置。
