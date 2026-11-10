import "$styles/index.scss"

// Fade content in as it scrolls into view. Only blocks that start below the
// fold are hidden, so nothing flashes on load, and nothing is hidden at all
// without JavaScript or when the visitor prefers reduced motion.
// Only gallery items in a grid are revealed one by one: in a carousel the
// gallery is revealed as a whole, and its items have their own recede
// animation on the same properties.
const revealSelector = ".ui-content, .ui-article, .ui-article-list-item, .ui-gallery, .ui-gallery.grid .ui-gallery-item, .ui-screenshot-gallery, .ui-footer"

function setupReveal() {
  if (
    !("IntersectionObserver" in window) ||
    window.matchMedia("(prefers-reduced-motion: reduce)").matches
  ) {
    return
  }

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (!entry.isIntersecting) return
        entry.target.classList.add("is-revealed")
        observer.unobserve(entry.target)
      })
    },
    { rootMargin: "0px 0px -10% 0px" }
  )

  document.querySelectorAll(revealSelector).forEach((element) => {
    if (element.getBoundingClientRect().top < window.innerHeight) return
    element.classList.add("reveal")
    observer.observe(element)
  })
}

setupReveal()

// Hamburger menu for small screens. The links stay visible when this doesn't
// run; the has-menu class is what lets the stylesheet collapse them.
const nav = document.querySelector(".ui-navigation")
const toggle = nav && nav.querySelector(".ui-nav-toggle")

// Fade in a backdrop behind the navigation once the page has scrolled, so the
// links stay legible over content. At the top there's nothing beneath them.
if (nav) {
  const updateScrolled = () => nav.classList.toggle("is-scrolled", window.scrollY > 8)
  window.addEventListener("scroll", updateScrolled, { passive: true })
  updateScrolled()
}

if (toggle) {
  toggle.hidden = false
  nav.classList.add("has-menu")

  const setOpen = (open) => {
    nav.classList.toggle("is-open", open)
    toggle.setAttribute("aria-expanded", String(open))
  }

  toggle.addEventListener("click", () => setOpen(!nav.classList.contains("is-open")))

  // Close after picking a link (the page may not reload, e.g. /#company)
  // and hand focus back to the toggle, as the link it was on is now hidden
  nav.addEventListener("click", (event) => {
    if (!event.target.closest("a")) return
    const wasOpen = nav.classList.contains("is-open")
    setOpen(false)
    if (wasOpen) toggle.focus()
  })

  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape" && nav.classList.contains("is-open")) {
      setOpen(false)
      toggle.focus()
    }
  })
}

// Carousel controls (prev/next buttons and dots) for horizontally scrolling
// galleries. Browsers with CSS carousel support (::scroll-button and
// ::scroll-marker) get them from the stylesheet alone; this builds the same
// controls for the rest. Without either the gallery is a plain scrollable row.
function setupCarousels() {
  const danish = document.documentElement.lang === "da"

  document.querySelectorAll(".ui-gallery.carousel:not(.grid)").forEach((gallery) => {
    const track = gallery.querySelector(".ui-gallery-items")
    const items = Array.from(track.children)
    if (items.length < 2) return

    const makeButton = (className, label, text) => {
      const button = document.createElement("button")
      button.type = "button"
      button.className = `ui-carousel-button ${className}`
      button.setAttribute("aria-label", label)
      button.textContent = text
      return button
    }

    const prev = makeButton("previous", danish ? "Forrige" : "Previous", "←")
    const next = makeButton("next", danish ? "Næste" : "Next", "→")
    const dotsWrap = document.createElement("div")
    dotsWrap.className = "ui-carousel-dots"

    const dots = items.map((item, index) => {
      const dot = document.createElement("button")
      dot.type = "button"
      dot.className = "ui-carousel-dot"
      dot.setAttribute("aria-label", String(index + 1))
      dot.addEventListener("click", () => scrollToOffset(offsetOf(item)))
      dotsWrap.append(dot)
      return dot
    })

    gallery.append(prev, next, dotsWrap)
    gallery.classList.add("has-controls")

    // offsetLeft ignores the transforms used by the recede animation
    const offsetOf = (item) =>
      item.offsetLeft - (parseFloat(getComputedStyle(track).scrollPaddingLeft) || 0)
    const maxScroll = () => track.scrollWidth - track.clientWidth

    const scrollToOffset = (left) =>
      track.scrollTo({ left: Math.max(0, Math.min(maxScroll(), left)) })

    // Step relative to the scroll position rather than the active item, so
    // the buttons still move when the last items can't reach the left edge
    const step = (direction) => {
      const left = track.scrollLeft
      const offsets = items.map(offsetOf)
      const target =
        direction > 0
          ? offsets.find((offset) => offset > left + 2)
          : offsets.filter((offset) => offset < left - 2).pop()
      if (target !== undefined) scrollToOffset(target)
    }

    const update = () => {
      const left = track.scrollLeft
      const offsets = items.map(offsetOf)
      const atEnd = left >= maxScroll() - 2
      // Without overflow the row is at its start and its end at once; the
      // first item is then the current one
      const current = atEnd && maxScroll() > 2
        ? items.length - 1
        : offsets.reduce(
            (best, offset, i) => (Math.abs(offset - left) < Math.abs(offsets[best] - left) ? i : best),
            0
          )
      dots.forEach((dot, i) => dot.setAttribute("aria-current", String(i === current)))
      prev.disabled = left <= 2
      next.disabled = atEnd
    }

    prev.addEventListener("click", () => step(-1))
    next.addEventListener("click", () => step(1))
    track.addEventListener("scroll", update, { passive: true })
    window.addEventListener("resize", update)
    update()
  })
}

if (!CSS.supports("selector(::scroll-button(left))")) {
  setupCarousels()
}
