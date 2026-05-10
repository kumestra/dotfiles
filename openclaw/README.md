

## Install

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

find token

```bash
cat ~/.openclaw/openclaw.json | grep token
```

## gemini prompt

```text
from now, i will now ask you some questions about a open source proj, which name is openclaw, it is a new proj, so related info is not in your training data, when answer question, you must search for internet, and make sure answer is reasonable, every answer you should provide origin data source which is used to prove you are not hallucination, if you can not find answer, you can guess, but you should tell why you guess like this, do you understand?
```