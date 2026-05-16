# Python Notes

Use this only when the request is clearly about Python test structure.

## Rewrite Hints

- Prefer `pytest.mark.parametrize` for repeated example cases of one contract.
- Use property-based testing when the contract is naturally universal, especially for parsers, serializers, and round-trips.
- Avoid tests that embed production logic in fixtures or helper factories.

## Verification

- Start with focused pytest node selection.
- Widen to the relevant suite once the narrowed proof is green.
