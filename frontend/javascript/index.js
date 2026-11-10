import "$styles/index.scss"

// Fade content in as it scrolls into view. Only blocks that start below the
// fold are hidden, so nothing flashes on load, and nothing is hidden at all
// without JavaScript or when the visitor prefers reduced motion.
const revealSelector = ".ui-content, .ui-article, .ui-article-list-item, .ui-gallery, .ui-gallery-item, .ui-screenshot-gallery, .ui-footer"

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
