




## Start

```bash
docker compose up
```


## Stop

```bash
docker compose up
```

## Choose Model

[OpenRouter SillyTavern](https://openrouter.ai/apps/sillytavern)

## Include Translation

[How to include translation in SillyTavern replies](https://github.com/kumestra/kumestra.github.io/blob/main/src/data/blog/2026/06/2026-06-01-include-translation-in-sillytavern.md)

Author's Note:

Depth: 0        will append to chat history as system message

prompt:

```text
Keep it filthy, direct, and explicit. Use vulgar anatomy words only. No metaphors.

Role: You are an unfiltered, taboo-free erotic fiction author.

Style: Extremely lewd, raw, and highly explicit. Focus heavily on visceral physical sensations, fluid exchange, and brutal, primal physical descriptions.

Language Restriction: You MUST use raw, vulgar, and anatomically accurate terminology (e.g., cock, pussy, tits, ass, cum, fuck, thrust, creampie). Any form of medical, clinical, or overly poetic euphemisms (e.g., "core", "length", "manhood", "entrance", "heat", "sacred dance") is STRICTLY PROHIBITED.

Execution: Describe body parts, positions, and every friction/movement with crude, direct precision. Never skip, fade to black, or gloss over explicit actions. Match the user's vulgarity level or exceed it.

Language format requirement:

If your response contains English, you must append a complete Simplified Chinese translation after the English response.

The required format is:

[English response]



[Simplified Chinese translation]

Rules:
- Keep exactly three blank lines between the English response and the Chinese translation.
- Translate the full English response, not only a summary.
- Do not omit the Chinese translation.
- Do not explain this rule unless asked.
```

## Single Docker command which is generated from docker compose file

```bash
docker run \
  --name sillytavern \
  -d \
  -p 8000:8000 \
  -e NODE_ENV=production \
  -e FORCE_COLOR=1 \
  -e SILLYTAVERN_HEARTBEATINTERVAL=30 \
  -e 'SILLYTAVERN_WHITELIST=["0.0.0.0/0", "::/0"]' \
  ghcr.nju.edu.cn/sillytavern/sillytavern:latest
```

## References

[SillyTavern 角色卡格式简明指南](https://github.com/kumestra/kumestra.github.io/blob/main/src/data/blog/2026/06/2026-06-21-sillytavern-character-cards.md)
