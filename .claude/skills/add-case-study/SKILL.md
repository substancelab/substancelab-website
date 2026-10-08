---
name: add-case-study
description: "Adds a new case study to the substancelab.com site (Bridgetown) from raw source material — a client interview, a PRD, or draft case-study markdown files, typically found under ../Content/Cases/<Client>/. Covers: locating/writing the project.yml entry, writing the localized _<slug>.erb partial in the site's existing voice and structure (hero, markdown sections, factbox aside, client quote, statistics), researching the client's own website for factbox facts, sourcing and cropping an Unsplash image when no product screenshot exists, and verifying with a Bridgetown build. Load when the user asks to write, create, or add a case study for a client, turn case-study source material into a site page, or update/restyle an existing case study page. Do NOT load for general copywriting unrelated to /work/ case studies, or for editing unrelated site content."
---

# Adding a case study to substancelab.com

This site (Bridgetown, in `src/`) renders case studies from two things per
project: an entry in `src/_data/projects.yml`, and a localized partial at
`src/<locale>/work/_<slug>.erb` rendered by `src/work/_case_study.erb`. Source
material for a new case (client interview transcripts, PRDs, draft case-study
markdown in various lengths) usually lives outside the site repo, e.g.
`../Content/Cases/<Client Name>/`.

## 1. Find and read the source material

Look for a folder matching the client name under `../Content/Cases/`. It
typically contains multiple drafts (concise/detailed, multiple languages) —
read the detailed one for the fullest set of facts (challenge, approach, key
technical decisions, results, quotes), but treat it as raw material to
distill, not text to paste in. The site's case studies are much shorter and
in a different voice than a portfolio case-study document.

## 2. Check `src/_data/projects.yml`

Search for an existing entry for the client first (by client name or
website) — many clients are already listed without a case study enabled.
If found, add to it rather than duplicating:

```yaml
case_studies:
- da        # or - en, or both, matching which partial(s) you write
```

Make sure `slug:` is set and matches the partial filename. If relevant,
add a fitting `services:` entry (see `locales/da.yml` under `services:` for
valid keys — unknown keys still render via their raw string, so prefer an
existing key like `maintenance` when it fits).

## 3. Study 2-3 existing case studies for structure and tone

Read a few of `src/da/work/_*.erb` (e.g. `_hh-components.erb`,
`_eventzonen-dk.erb`, `_gomore.erb`) before writing. The recurring shape:

```erb
<% slot :hero do %>
  <div class="container">
    <h1>...</h1>
    <p class="ui-lede">...</p>
  </div>
<% end %>

<section>
  <div class="container">
    <%= markdown(<<~MARKDOWN)
      ## Heading
      Prose...
    MARKDOWN
    %>

    <aside class="factbox pull-right">...</aside>   <!-- optional, client facts -->

    <blockquote class="quote pull-left">
      <p>...</p>
      <div class="author">Full Name, Title, Client</div>
    </blockquote>
  </div>
</section>

<section>
  <div class="container">
    <div class="statistics">
      <div class="statistics-figure">
        <div class="statistics-number">...</div>
        <div class="statistics-label">...</div>
      </div>
      <!-- 2-3 of these -->
    </div>
  </div>
</section>
```

Use `markdown(<<~MARKDOWN ... MARKDOWN)` blocks for prose so headings/links
render, plain HTML for hero/factbox/quote/statistics structure.

## 4. Voice and content rules (learned the hard way — apply by default)

- **Length**: keep it short and precise. Prefer several tight paragraphs (2-4
  sentences each) under 2-3 `##` subheadings, not a long-form narrative. If in
  doubt, cut — this has been the single most common feedback.
- **No named individuals in body prose.** Refer to "Substance Lab", "Bomae"
  (the client), "ledelsen", "medarbejderne" — never a personal name in the
  running text, even if the source material names people.
- **Quotes are the exception**: a client testimonial's attribution *must*
  carry the real name and title (`<div class="author">Mads Nørgaard, CFO,
  Bomae</div>`), matching the source material's actual quote. If the quoted
  text itself refers to a named individual at Substance Lab (e.g. the
  original quote praises "Jakob"), it's fine to soften that one reference to
  "Substance Lab" — but never invent or alter the substance of what the
  client said.
- **No software version numbers or narrow technical jargon.** The audience
  is non-technical founders and business owners (per the site's own
  `peptalk` copy in `locales/da.yml`). Say "opgraderede til understøttede
  versioner" rather than naming Ruby/Rails version numbers. Technologies
  themselves (Ruby on Rails, PostgreSQL) are fine to name; specific version
  numbers are not.
- **Don't make the client sound helpless without Substance Lab.** Source
  material written for a freelancer's portfolio tends to dramatize the
  "before" state ("nobody understood it", "the business would grind to a
  halt"). Reframe: the client's system/team was in good shape; Substance Lab
  continued, strengthened, or unblocked it — not rescued it from incompetence.
  Avoid language that blames end users for "learning to click through"
  things, or casts routine steps as "traps for human error."
- Generate both danish and english versions.

## 5. Research the client for the factbox

Fetch the client's own website (WebFetch) for concrete, verifiable facts —
what they do, who they serve, any real numbers (review counts, certifications,
years active, pricing model). Use this to write or improve the `factbox`
aside instead of relying solely on the source material, which may be stale
or written from an internal perspective. Keep it to 2-4 sentences plus the
existing `factbox-table` website row.

## 6. Source an image if there's no product screenshot

Internal tools/CRMs (no public screenshot to show) follow the pattern seen in
`src/images/work/hh-components/`: one Unsplash source photo plus two derived
crops, all in `src/images/work/<slug>/`:

- `<photographer-slug>-<photo-id>-unsplash.jpg` — the untouched source image,
  named for traceability back to the photographer/photo.
- `masthead.jpg` — resized wide (e.g. `-resize 1600x`), used only as the
  page's social/og:image thumbnail (see `plugins/hero_helpers.rb`), never
  shown inline.
- `tile.jpg` — cropped to exactly `740x600` (`-resize 740x600^ -gravity
  center -extent 740x600`), shown in the case-study gallery listing.

Steps: WebFetch an Unsplash search results page for a relevant query, pick a
free (non-Premium) photo whose subject fits the case, WebFetch its photo page
for the direct `images.unsplash.com/photo-...` URL and photographer name,
`curl` it into place, then `convert` (ImageMagick, available at
`/opt/local/bin/convert`) the two derived sizes. No visible attribution is
needed elsewhere on the site (matches existing convention) — the filename is
the record.

Only add `project.jpg` (shown inline via `project_image` in
`_case_study.erb`) when a real, honest screenshot of the product exists —
never substitute a stock photo for a "screenshot of the project."

## 7. Build and verify

The site only builds one locale per run, controlled by the `LOCALE` env var
(`config/initializers.rb`, default `da`). Build each locale you wrote a
partial for:

```bash
bundle exec bridgetown build          # da (default)
LOCALE=en bundle exec bridgetown build  # en
```

Should complete with no errors. Then spot-check the generated page (for
whichever locale you just built):

```bash
grep -n "<h1>\|factbox\|quote\|statistics-number" output/work/<slug>/index.html
grep -n "tile.jpg" output/work/index.html   # confirm it appears in the gallery
```

Building `en` overwrites `output/` with the English pages — rebuild the
default `da` locale afterwards (plain `bundle exec bridgetown build`) so the
working tree's `output/` matches the site's default state.

`output/` is a build artifact — don't worry about committing it unless the
project's `.gitignore` says otherwise (check `git status` — if `output/` was
already untracked before you built, leave it alone).
