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
    event.respondWith(networkFirst(request))
  } else {
    event.respondWith(staleWhileRevalidate(request, event))
  }
})

async function networkFirst(request) {
  const cache = await caches.open(CACHE)
  try {
    const response = await fetch(request)
    if (response.ok) cache.put(request, response.clone())
    return response
  } catch (error) {
    return (await cache.match(request)) || (await cache.match(OFFLINE_URL))
  }
}

async function staleWhileRevalidate(request, event) {
  const cache = await caches.open(CACHE)
  const cached = await cache.match(request)
  const refresh = fetch(request).then((response) => {
    if (response.ok) cache.put(request, response.clone())
    return response
  })

  if (cached) {
    event.waitUntil(refresh.catch(() => {}))
    return cached
  }
  return refresh
}
