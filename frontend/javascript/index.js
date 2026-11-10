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
