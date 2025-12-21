### Structure
Items marked with ¹ are the minimum requirements (i.e. must be there), ² means "strongly recommended". Consider all others optional, and ³ nice to have:

```
/                                           (repo-root)
└── fastlane
    └── metadata
        └── android
            ├── en-US                       (en-US seems to be required by F-Droid)
            │   ├── short_description.txt   (short description, max 80 chars, plain text) ¹
            │   ├── full_description.txt    (full app description, max 4000 chars, basic HTML allowed) ¹
            │   ├── title.txt               (app name)
            │   ├── video.txt               (URL to a video introducing the app)
            │   ├── images
            │   │   ├── icon.png            (app icon; useful e.g. for "service apps" containing none)
            │   │   ├── featureGraphic.png  (promo banner, shown on top of the app desc in F-Droid client; landscape) ³
            │   │   ├── promoGraphic.png    (same, smallscreen size?)
            │   │   ├── tvBanner.png        (same, TV-screen size?)
            │   │   ├── phoneScreenshots    ²
            │   │   │   ├── 1.png
            │   │   │   ├── 2.png
            │   │   │   ...
            │   │   ├── sevenInchScreenshots/
            │   │   ├── tenInchScreenshots/
            │   │   ├── tvScreenshots/
            │   │   └── wearScreenshots/
            │   └── changelogs              ³
            │       ├── 100000.txt          (must correspond to versionCode, literally, no padding)
            │       ├── 100100.txt          (so this means: versionCode=100100)
            │       └── 100101.txt          (max size: 500 bytes, plain ASCII (no HTML))
            └── ru
                ...
                └── changelogs
                    └── 100100.txt
```
