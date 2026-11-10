// Keeps the site readable offline. Pages are fetched from the network first so
// visitors always get fresh content, falling back to the last cached copy and
// finally to the offline page. Other same-origin files are served from cache
// while being refreshed in the background. Third-party requests (analytics,
// fonts, consent banner) are left alone.
//
// Bump VERSION to throw away everything cached by earlier versions.
const VERSION = "v1"
const CACHE = `substancelab-${VERSION}`
const OFFLINE_URL = "/offline/"

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE)
      .then((cache) => cache.addAll(["/", OFFLINE_URL]))
      .then(() => self.skipWaiting())
  )
})

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((key) => key !== CACHE).map((key) => caches.delete(key))))
      .then(() => self.clients.claim())
  )
})

self.addEventListener("fetch", (event) => {
  const request = event.request
  const url = new URL(request.url)

  if (request.method !== "GET" || url.origin !== self.location.origin) return

  if (request.mode === "navigate") {
    event.respondWith(networkFirst(request, event))
  } else {
    event.respondWith(staleWhileRevalidate(request, event))
  }
})

async function networkFirst(request, event) {
  const cache = await caches.open(CACHE)
  try {
    const response = await fetch(request)
    store(cache, request, response, event)
    return response
  } catch (error) {
    return (await cache.match(request)) || (await cache.match(OFFLINE_URL))
  }
}

async function staleWhileRevalidate(request, event) {
  const cache = await caches.open(CACHE)
  const cached = await cache.match(request)
  const refresh = fetch(request).then((response) => {
    store(cache, request, response, event)
    return response
  })

  if (cached) {
    event.waitUntil(refresh.catch(() => {}))
    return cached
  }
  return refresh
}

// Saves a copy of a successful response without holding up the response
// itself. The fetch event is kept alive until the write is done, so the
// worker isn't stopped halfway through, and a failed write is ignored rather
// than failing the request.
function store(cache, request, response, event) {
  if (!response.ok) return
  event.waitUntil(cache.put(request, response.clone()).catch(() => {}))
}
