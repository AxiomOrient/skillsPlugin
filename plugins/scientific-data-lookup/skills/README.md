# Scientific Data Lookup Skills

This directory contains AMA mobile data lookup skills.

- `database-lookup`: routes scientific data questions to native AMA intents or reference-only database plans.
- `hugging-science`: uses Hugging Face dataset search through a Swift host intent.
- `usfiscaldata`: uses U.S. Treasury Fiscal Data through a Swift host intent.
- `depmap`: discovers DepMap release files and keeps downstream matrix analysis out of the iOS runtime.

Native lookup execution belongs in AMA Swift host intents. Skills in this directory do not ship local scripts or external program runners.
