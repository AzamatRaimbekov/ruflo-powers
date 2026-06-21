# Design System

Last updated: 2026-06-03
Status: current
Platforms: web frontend, reusable agent-asset templates, mobile-ready guidance

## Purpose

This document is the detailed design-system memory for frontend and mobile-facing work in this repository. It complements `design-system.md`, which remains the compact token ledger.

- Product: local agent assets, frontend skills, and starter project templates.
- Primary users: developers and Codex agents creating or maintaining frontend and mobile UI.
- Experience goals: consistent UI decisions, clear token usage, accessible defaults, and reusable project startup docs.
- Design principles: document intent before expanding visuals, reuse project tokens/components first, keep operational UI scannable, and record platform-specific exceptions.
- Source files: `frontend-design-demo.html`, `docs/frontend/design-system.md`, `docs/frontend/components.md`, `docs/frontend/screens.md`, and `agent-assets/frontend/skills/design-system-steward/SKILL.md`.

## Platform Coverage

| Platform | Scope | Notes |
| --- | --- | --- |
| Web | Current repository UI memory and starter frontend projects. | Uses `docs/frontend/` as the default design documentation home. |
| iOS | Guidance for target mobile projects. | Use `docs/mobile/design.md` or cross-link from `docs/design.md` when the target project is mobile-only. |
| Android | Guidance for target mobile projects. | Include density, touch, safe area, system theme, and navigation notes when applicable. |

## Visual Direction

The current repository demo uses an editorial brutalist direction: warm paper surfaces, hard borders, bold condensed display type, acid highlights, and utilitarian panels. This direction is appropriate for the local demo only. New product projects should define their own visual direction in this file before adding new palettes, fonts, or reusable components.

## Color System

### Palette Intent

| Palette | Purpose | Use When | Avoid When |
| --- | --- | --- | --- |
| Primary | Product identity and main actions. | Main CTA, selected navigation, active tools, focused product moments. | Repeating across every surface or replacing semantic status colors. |
| Secondary | Supporting actions and secondary emphasis. | Alternate buttons, secondary navigation, supporting panels. | Critical status, destructive action, or dense text surfaces. |
| Accent | High-emphasis moments. | Highlights, onboarding, visual affordances, small callouts. | Large backgrounds that overwhelm scanning or produce a one-note palette. |
| Neutral | Structure and reading hierarchy. | Backgrounds, borders, text, disabled states, data-heavy layouts. | Communicating success, warning, or danger by itself. |
| Success | Positive completion and valid states. | Confirmation, saved state, complete progress, valid form feedback. | Decorative green branding or unrelated emphasis. |
| Warning | Attention and reversible risk. | Pending decisions, caution states, validation warnings. | Destructive actions or low-priority decoration. |
| Danger | Destructive, blocking, or invalid states. | Delete actions, failed validation, critical alerts. | Non-critical decoration or positive emphasis. |
| Info | Neutral system feedback. | Helpful notices, onboarding hints, background sync. | Replacing primary actions or warning/danger states. |
| Dark mode | Low-light and user-selected dark UI. | User preference, media-heavy workflows, mobile dark theme. | Defaulting without separate contrast/elevation checks. |

### Current Demo Tokens

| Token | Value | Role | Pairings | Contrast | Platforms |
| --- | --- | --- | --- | --- | --- |
| `--ink` | `#171511` | Primary text, borders, dark buttons. | `--paper`, `--acid`, `--mint`, `--signal`. | High contrast on light/accent surfaces. | web |
| `--paper` | `#f5efdf` | Page background and light surfaces. | `--ink`, `--night`. | Supports readable body copy with `--ink`. | web |
| `--signal` | `#ff4f1f` | High-energy accent, shadows, callouts. | `--ink`, `--paper`. | Use for emphasis, not small body text. | web |
| `--acid` | `#d7ff3f` | Primary highlight and status accent. | `--ink`, `--night`. | Strong highlight with dark text. | web |
| `--mint` | `#85d8c6` | Secondary accent and interaction shadow. | `--ink`. | Suitable for small supporting surfaces. | web |
| `--night` | `#1f2a44` | Dark panel background. | `--acid`, `--paper`. | Needs light text or accent foreground. | web |
| `--line` | `rgba(23, 21, 17, 0.18)` | Subtle line work. | Light surfaces. | Decorative separator only. | web |
| `--shadow` | `18px 18px 0 rgba(23, 21, 17, 0.13)` | Brutalist panel offset shadow. | Major demo panels. | Not a semantic color. | web |

### Color Rules

- Add semantic token names before raw color usage.
- Document each new palette with purpose, use cases, anti-patterns, contrast, and platform coverage.
- Do not use semantic status colors as decoration.
- Avoid UI that is dominated by one hue family unless that is an explicit product decision.
- Check foreground/background contrast before using a color pair for text or controls.
- For mobile projects, document system light/dark behavior and platform color mappings.

## Typography

| Token | Font | Size | Weight | Line Height | Usage | Platforms |
| --- | --- | --- | --- | --- | --- | --- |
| Display | `Bebas Neue` | responsive fixed CSS sizes | regular | tight | Demo headings and large metrics. | web demo |
| Body | `Manrope` | fixed CSS sizes | regular to bold | readable | Body text, labels, and controls. | web demo |

Rules:

- Do not scale font size directly with viewport width.
- Keep letter spacing at `0` unless a documented font needs adjustment.
- Mobile projects must document text scaling, platform type ramps, and minimum readable sizes.
- New fonts need a reason, usage scope, fallback stack, loading behavior, and performance note.

## Spacing and Layout

| Token | Value | Usage |
| --- | --- | --- |
| `space-1` | `8px` | Small inline gaps. |
| `space-2` | `12px` | Compact padding and badges. |
| `space-3` | `18px` | Component gaps and card padding. |
| `space-4` | `22px` | Panel padding. |
| `space-5` | `28px` | Section rhythm. |
| `space-6` | `34px` | Action spacing. |
| `space-7` | `44px` | Page bottom padding. |

Rules:

- Stable controls, tiles, counters, and toolbars need constrained dimensions to prevent layout shift.
- Desktop operational screens should prioritize scanning and repeated actions over decorative spacing.
- Mobile screens must document safe areas, bottom bars/sheets, keyboard behavior, and tappable target sizes.

## Shape, Borders, and Elevation

Current demo shape language is hard-edged and low-radius:

- Borders: `2px` controls/dividers, `3px` major panels.
- Radius: mostly `0`.
- Shadows: hard offset shadows.

Rules:

- Cards should stay at `8px` radius or less unless a product-specific system requires otherwise.
- Avoid nested cards.
- Do not mix soft rounded elevation into the current demo direction without recording a direction change.
- Mobile sheets, dialogs, and navigation surfaces need separate elevation and gesture notes.

## Components

Reusable components are documented in `components.md`. Component documentation must include purpose, variants, states, tokens, accessibility, and reuse guidance.

Rules:

- Use documented project components first.
- Use active skill-provided components second.
- Use shadcn/ui only when no project or skill component is suitable.
- Document default, hover, focus, active/pressed, disabled, loading, error, empty, and offline states where relevant.

## Motion and Feedback

Current demo patterns:

| Pattern | Purpose | Rule |
| --- | --- | --- |
| `blink` | Status pulse. | Use only for lightweight status emphasis. |
| `load` | Meter fill. | Use for progress visualization. |
| `rise` | Tile entrance. | Use for one-time reveal, not constant motion. |
| Button hover | Feedback. | Keep subtle and stable. |

Rules:

- Motion should clarify state or create one strong moment.
- Respect reduced-motion preferences.
- Mobile apps should document haptics and gesture feedback when used.

## Responsive and Adaptive Behavior

| Breakpoint or Class | Target | Layout Rule |
| --- | --- | --- |
| `880px` | Small desktop/tablet | Collapse hero and strip grids to one column. |
| `560px` | Mobile | Stack layout, tighten header and typography. |

Rules:

- Horizontal overflow is a blocking UI issue.
- Text must fit inside buttons, panels, cards, and headings.
- Mobile layouts must preserve navigation, tap targets, and safe areas.

## Accessibility

- Use semantic landmarks where practical.
- Buttons need visible labels or accessible names.
- Color cannot be the only indicator of state.
- Maintain readable contrast and focus indicators.
- Support reduced motion for larger applications.
- Mobile projects must consider text scaling, screen readers, dynamic type, and minimum touch targets.

## Assets, Icons, and Imagery

- Use icons from the active icon library when available.
- Document icon stroke, fill, size, and state behavior before adding a reusable icon pattern.
- Product, venue, object, or person pages need real or generated bitmap visuals that reveal the subject, not abstract filler.

## Theming and Modes

- Light mode is the current documented mode.
- Dark mode is not defined for the demo and must be specified before implementation.
- Cross-platform projects should document shared semantic tokens and platform-specific mappings.

## Governance

Before adding a token, component, theme, or palette:

1. Search `design.md`, `design-system.md`, `components.md`, and source code.
2. Reuse an existing semantic role when possible.
3. Add a new token only for a repeated product need.
4. Document value, purpose, use cases, anti-patterns, accessibility, and platform coverage.
5. Update component and screen docs if behavior or structure changed.
6. Record meaningful decisions in `ui-decisions.md` or the project wiki.

## Open Questions

- Whether future target projects should prefer `docs/frontend/design.md`, `docs/mobile/design.md`, or a cross-platform `docs/design.md` depends on each product's platform scope.
