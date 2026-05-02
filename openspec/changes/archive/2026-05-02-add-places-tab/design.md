## Context

The user wants a new tab for "Places" in the main navigation. This is currently just a placeholder request.

## Goals / Non-Goals

**Goals:**
- Add "Places" to the `TabView`.
- Use a consistent SF Symbol icon.

**Non-Goals:**
- Implement the full list logic or data model in this step.

## Decisions

- **Icon selection**: Use `mappin.and.ellipse` as it clearly represents "Places" or "Locations".
- **Tab Order**: Place it between "Stats" and "Settings" to maintain a logical flow (Map -> Stats -> Places -> Settings).
- **Tagging**: Assign `tag(2)` to the new tab, as `tag(0)`, `tag(1)`, and `tag(3)` are already in use.

## Risks / Trade-offs

- **[Trade-off]** Placeholder: The tab will be empty initially, which might confuse users if they don't know it's a work-in-progress. → **Mitigation**: Use clear "Coming Soon" or "Places Placeholder" text.
