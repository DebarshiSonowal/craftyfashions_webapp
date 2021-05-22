'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "e557a5fe70e2df8aa1ee39926d82a750",
"assets/assets/Fonts/EBGaramond-Bold.ttf": "defdbd28e961a44e72ff07f42746b927",
"assets/assets/Fonts/EBGaramond-Medium.ttf": "53b516bb245061aaf91b954720f2faf5",
"assets/assets/Fonts/EBGaramond-Regular.ttf": "7212787ac2cb006948236e4600392180",
"assets/assets/Fonts/Halyard%2520Text%2520Regular.ttf": "89248b0583721153668df86453b579de",
"assets/assets/Fonts/Sumana-Bold.ttf": "f25e52cdb8d220f55860bad3be91d03a",
"assets/assets/Fonts/Sumana-Regular.ttf": "9459c8dd7f6528c6c8e35f2056a18b5f",
"assets/assets/images/404.png": "47b44a93a6001a0f1cec93c814af41ae",
"assets/assets/images/crafty.png": "2f96613817b55bf9d32e23ee1e7ab483",
"assets/assets/images/error.webp": "601efce416e2da34e4c3baa3e3d15a69",
"assets/assets/images/favourite.webp": "460f3fc8c44cc3b49f1c768c8aaedf10",
"assets/assets/images/kk.jpg": "c5af7eeaf086033e5d10b433e8b7a9f5",
"assets/assets/images/logo.png": "361bf4485a7394301b6ae1734883e9f1",
"assets/assets/images/mask.webp": "4ed8234df2bac3816ab638d928e4650d",
"assets/assets/images/men.jpg": "662de3f2cc0f1c817f400b73426a40db",
"assets/assets/images/nointernet.png": "cf0a5645354f8ce787bffd5f7590c466",
"assets/assets/images/settings.png": "59fcb6d90a7e20297b171a2347984e0b",
"assets/assets/images/shopping-cart.webp": "c2d381f92d31a5511002447e212ac75d",
"assets/assets/images/user.png": "84ce62a853e6d34058522bba337ed635",
"assets/assets/images/warning.webp": "dbd2b76587e9513856adc552a5669704",
"assets/assets/images/women.jpg": "7b96ceeaedf34b425393327945cfe1ea",
"assets/assets/Policy/index.html": "16285b91edd193046381872f82581635",
"/": "280d79685e02d0a9e896335fcea926b5",
"assets/assets/Policy/payment.html": "b18f32cb726273d9b75121a7135ae974",
"assets/assets/Policy/RETURN%2520AND%2520REFUND%2520POLICY.htm": "7ea5e061b3de4945c4420766e7bdb569",
"assets/assets/Policy/RETURN%2520AND%2520REFUND%2520POLICY_files/colorschememapping.xml": "6b7a472a22fbdbff4b2b08ddb4f43735",
"assets/assets/Policy/RETURN%2520AND%2520REFUND%2520POLICY_files/filelist.xml": "a876bed212fa3387363f4384fd6b6827",
"assets/assets/Policy/RETURN%2520AND%2520REFUND%2520POLICY_files/themedata.thmx": "2b26e4dd316f857ebb6e2b6b0e1e0282",
"assets/assets/Policy/style.css": "da6be494ec0709e2970777113b39736d",
"assets/assets/raw/failed.json": "e6e449e0cae65765b9a6a659d44773ce",
"assets/assets/raw/like.json": "c279c8f7976a0783813fed8a0a079f6f",
"assets/assets/raw/loading.json": "c229a037272552700fd3972da475cfbc",
"assets/assets/raw/safe.json": "61f121fbc4b4ba4e0722d9d82489371a",
"assets/assets/raw/shoppingcart.json": "ef9b8335fdc28ec6756ef365f51b6df4",
"assets/assets/raw/successful.json": "05c35d0a17c39e6e83a93b4717507321",
"assets/FontManifest.json": "ccc2de8e82beb8bcde0b990ebf939cb6",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "8e478f9922490b88d836a4a92a0926ad",
"assets/packages/empty_widget/assets/images/emptyImage.png": "6bb2d2c61bb39c0c571b95ae009acc4b",
"assets/packages/empty_widget/assets/images/im_emptyIcon_1.png": "545e13e1cabb2faf7eac9801f64f7f89",
"assets/packages/empty_widget/assets/images/im_emptyIcon_2.png": "bcff5e23332d92e74562eaf8f47c7bd1",
"assets/packages/empty_widget/assets/images/im_emptyIcon_3.png": "2698f6c94cec9450ced97499b70a34d6",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/packages/flutter_markdown/assets/logo.png": "67642a0b80f3d50277c44cde8f450e50",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "00bb2b684be61e89d1bc7d75dee30b58",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "4b6a9b7c20913279a3ad3dd9c96e155b",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "dffd9504fcb1894620fa41c700172994",
"assets/packages/progress_dialog/assets/double_ring_loading_io.gif": "e5b006904226dc824fdb6b8027f7d930",
"favicon.png": "2f96613817b55bf9d32e23ee1e7ab483",
"icons/Icon-192.png": "7324822054dcefa625b0ffc6b7bcf018",
"icons/Icon-512.png": "2a9cb020d9bc607dc0f6a7cc19b5dad9",
"index.html": "280d79685e02d0a9e896335fcea926b5",
"main.dart.js": "b6e642d2bb1edb805053479ad522fe5c",
"manifest.json": "3547ab0daf9696b3e42aac381fd4558e",
"version.json": "02dc96a89589da20d92662d973e50e11"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
