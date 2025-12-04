# Docusaurus → 11ty Migration Snapshot

**Date:** October 27, 2025  
**Project:** Sage.is AI-UI Documentation

---

## TL;DR

- 11ty would unify stacks, but Docusaurus currently delivers richer docs features with less custom code.
- Headline blockers are MDX/React component parity, navigation, and search—these drive most of the effort.
- Updated full-migration estimate: **55‑80 engineering hours** if we chase feature parity.

---

## What We Rely On Today (Docusaurus)

- ~~MDX + React components embedded in docs (`TopBanners`, `SponsorList`).~~ 
	- no longer this as ben resolved
- Auto-generated sidebars from folder structure (`sidebars.ts`).
	- We could make a little njk or liquid that could deal with this...
- Built-in search (lunr), table of contents, breadcrumbs, dark mode.
- Mermaid diagrams, Prism highlighting, blog author metadata.
	- These are low hanging fruit 
- GitHub edit links, frontmatter-driven ordering, MDX admonitions.

---

## 11ty Gaps That Need Coverage

| Feature | 11ty Status | Est. Effort* | Notes |
| --- | --- | --- | --- |
| Sidebar navigation | Custom collections + template logic | **8‑12 h** | Build filesystem walker, ordering, active states. |
| MDX/React components | No first-class support | **12‑18 h** | Replace with shortcodes or embed React via plugin; most time is rewriting docs that reference components. |
| Search | Plugins available (Pagefind/Lunr) | **6‑10 h** | Configure index build + UI wire-up; Pagefind preferred. |
| Dark mode toggle | Manual | **4‑6 h** | Implement toggle, persistence, accessibility. |
| Mermaid diagrams | Plugin/community recipe | **3‑4 h** | Either pre-render at build or hydrate client-side. |
| TOC + breadcrumbs | Manual | **3‑5 h** | Use markdown-it + data cascade. |
| Blog niceties (reading time, authors) | Manual | **4‑6 h** | Collections + filters. |

*Effort assumes familiarity with 11ty and ability to reuse snippets from other Startr sites.

**Subtotal for parity-critical items:** ~40‑61 h. Add 15‑20 h for content conversion (MDX cleanup, link fixes, QA) → **55‑80 h total.**

---

## Migration Effort Shape

- **Setup (4‑6 h):** Initialize 11ty, bring over Tailwind/PostCSS pipeline, configure build/deploy.
- **Feature parity (30‑45 h):** Implement table above, focusing on navigation/MDX/search first.
- **Content migration (15‑20 h):** Convert ~30 MDX files, replace React components, update frontmatter.
- **Polish & QA (6‑9 h):** Accessibility, link checks, SEO meta, regression review with stakeholders.

---

## Recommendation

- Keep Docusaurus in place for now; it already solves the docs-specific concerns with minimal custom work.
- If stack consolidation is a must, pilot 11ty on a smaller doc set (e.g., a single guide section) to validate MDX replacement strategy and navigation patterns before committing the full 55‑80 h.
- Revisit once we have reusable 11ty snippets for navigation + MDX substitutes from other Startr properties.

---

## Immediate Checks (if we revisit)

1. Inventory every MDX file that imports React; confirm replacement approach (shortcodes vs. hydrated islands).
2. Spike a navigation prototype in 11ty using current docs tree to validate the revised 8‑12 h estimate.
3. Benchmark Pagefind integration to ensure search UX matches today’s lunr setup.

---

**Document Version:** 1.1  
**Updated By:** GitHub Copilot
