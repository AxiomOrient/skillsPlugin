---
name: usfiscaldata
description: Mobile-safe U.S. Treasury Fiscal Data lookup for debt and fiscal records using AMA native REST host intents and source references.
---
# usfiscaldata

Use this skill when the user asks about U.S. Treasury Fiscal Data, Debt to the Penny, federal debt, fiscal records, interest rates, or Treasury API usage.

## Workflow

1. Identify the Fiscal Data dataset, date range, fields, and whether the user wants the latest record or a query plan.
2. For latest Debt to the Penny, call `run_intent` with `scientific.fiscaldata_latest_debt`.
3. Explain fields using returned labels and included references.
4. For unsupported Fiscal Data datasets, provide a mobile-safe API plan from `references/` without pretending to run arbitrary queries.

## Intent

Call:

```json
{
  "intent": "scientific.fiscaldata_latest_debt",
  "parameters": {
    "dataset": "debt_to_penny"
  }
}
```

## Output Shape

Return:

- dataset and record date
- total public debt outstanding
- debt held by public
- intragovernmental holdings
- source endpoint
- field caveats and freshness note

## Mobile Boundary

Do not run local scripts, shell commands, downloaded CSV processors, or desktop API clients. Use AMA native REST intents or provide a documented query plan.
