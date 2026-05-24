---
name: hugging-science
description: Mobile-safe discovery of scientific datasets on Hugging Face using AMA native dataset search and included usage references.
---
# hugging-science

Use this skill when the user asks for scientific ML datasets, benchmark datasets, model-adjacent data, or Hugging Face resources for research.

## Workflow

1. Clarify the research domain, modality, license constraints, size constraints, and whether gated datasets are acceptable.
2. Call `run_intent` with `scientific.huggingface_dataset_search`.
3. Rank results by relevance, license clarity, gating status, available splits, and metadata completeness.
4. Use included references for dataset/model/space usage guidance when the user asks how to proceed.
5. State that AMA did not download or execute the dataset locally.

## Intent

Call:

```json
{
  "intent": "scientific.huggingface_dataset_search",
  "parameters": {
    "query": "genomics",
    "limit": 5
  }
}
```

## Output Shape

Return:

- query used
- dataset candidates with URL, license, gated status, tags, downloads/likes when available
- splits or size metadata when available
- recommended next step
- caveats about dataset card completeness and local execution limits

## Mobile Boundary

Do not run the upstream `fetch_catalog.py` script, `huggingface_hub`, Python dataset loading, local downloads, or model execution on iOS.
