### Locations
For F-Droid, there are 3 possible entry-points the process looks for Fastlane, always located in the root of the app's repository:

* `/fastlane/metadata/android/<locale>/`
* `/metadata/<locale>/`
* `/src/<buildFlavor>/fastlane/metadata/android/<locale>/`

### Image sizes
* `icon.png`: minimum 48x48, max 512x512 px
* `featureGraphic.png`: either 512x250 or 1024x500 px
* `tvBanner.png`: 1280x720 px (maybe 640x360 is acceptable as well?)
* screenshots: large enough to show details giving an impression, but small enough to fit on small screens (and give not too much issues on bad connections/small data plans). If above mentioned Github action gives you an error like `Error: 'max:min' edge radio should be at most 2.0: got=2.11` that means exactly what it says: height/width ratio should at max be 2:1 – so if your screenshots of the Eiffel Tower use the tower's original ratio, add more width to them :)


### Additional notes
* screenshots can be PNGs or JPGs, no other formats are accepted.
* F-Droid picks Fastlane from the very same tag/commit it builds the app from. So make sure to have your ``changelogs/<versionCode>.txt`` there before you create the tag.
* the updater for the IzzyOnDroid repo picks Fastlane from HEAD.
* if you need different descriptions for different flavors: F-Droid supports a.o. ``/src/<buildFlavor>/fastlane/metadata/android/``, so no need to revert to [Triple-T](https://gitlab.com/snippets/1901490)
* if you have fastlane structures on multiple matching locations, F-Droid will merge them. This is especially helpful if you use ``fastlane supply`` to deploy to Google Play, which does not support ISO-639 language codes (like ``en`` or ``de``) but insists on localized ones (``en-US``, ``en-UK``, ``de-DE``, ``de-AT`` etc): keep the ones to be used with ``fastlane supply`` in one location, and have the "simple ones" in another.
* some further hints (especially on formatting) can [be found here](https://gitlab.com/IzzyOnDroid/repo/-/wikis/Fastlane), with pointers for F-Droid and IzzyOnDroid repos.
* for F-Droid, which elements you have in your Fastlane structure does make a difference on if and where your app is shown on the "Latest" tab, see: [What are the criteria for an app to show up in the "Latest" tab?](https://gitlab.com/fdroid/wiki/-/wikis/FAQ#what-are-the-criteria-for-an-app-to-show-up-in-the-latest-tab)