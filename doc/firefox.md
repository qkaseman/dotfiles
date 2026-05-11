# Firefox

## Extensions

### Privacy Badger

- Allow auto-updates.
- Run in private windows.

### Tampermonkey

- Allow auto-updates.
- Run in private windows.

### Tree Style Tab

1. At the top, select "Unlock Expert Options"
1. Under "Tree Behavior", deselect
    1. "When a new tree appears, collapse others automatically"
    1. "When a tab gets focus, expand its tree and collapse others
       automatically"
    1. "Except focus moving caused by closing of the current tab"
1. Under "Advanced", deselect
    1. "Warn me when I attempt to close multiple tabs"
    1. "Warn me when I attempt to close multiple tabs by a normal click on a
       closebox"

#### Hide Native Tabs

1. Type `about:support` in the address bar.
1. Click `Open folder` on `Profile Folder`.
1. Create `chrome/userChrome.css` and fill with the below contents.
1. Type `about:config` in the address bar.
1. Set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`.
1. Restart Firefox.

```css
#main-window[tabsintitlebar="true"]:not([extradragspace="true"]) #TabsToolbar>.toolbar-items {
    opacity: 0;
    pointer-events: none;
}

#main-window:not([tabsintitlebar="true"]) #TabsToolbar {
    visibility: collapse !important;
}

#sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
    display: none;
}

.tab {
    margin-left: 1px;
    margin-right: 1px;
}
```

### uBlock Origin

Enable everything essentially.

#### Custom Rules

Add these custom rules:

```text
! 2022-07-29 https://www.cbssports.com
www.cbssports.com##.fEy1Z2XT

! 2022-10-18 https://www.cbssports.com
www.cbssports.com##.fEy1Z2XT

! 2023-11-10 https://mobalytics.gg
mobalytics.gg##.m-83k6c4
mobalytics.gg##.m-bz6vl

! 2024-01-03 https://maxroll.gg
maxroll.gg##.z-\[100000\].bg-opacity-80.bg-dark-1.overflow-y-auto.w-full.h-full.inset-0.fixed

! 2024-05-19 https://support.google.com
support.google.com##.sgeIconFabStartButton
support.google.com##.sgeDesktopFabRoot

! Google sucks
!google.*##.xpdopen:has-text(Featured snippet):nth-ancestor(2)
!www.google.*# .mw .rc div[jsl^="$t"][jsl$="0;"][class^="r-"]
!www.google.*##.rc [id^="ed"]
!www.google.*##.exp-outline
!www.google.*###ed_8
!google.*##div[id^="ed_"]
!www.google.*##div[jscontroller]:if(h4:has-text(People also search for))
!www.google.*##h4:has-text(People also search for):xpath(ancestor::div[@jscontroller][1])
!google.*##div[id^="eob_"]
!https://www.google.*/xjs/*
!www.google.*##[class*="g kno-kp mnr-c g-blk"]
!www.google.*##:is([data-sokoban-container] > div:last-child):has([jscontroller])
!www.google.*##.related-question-pair

! 2023-10-03 https://www.google.com
www.google.com##.google-s-ad__container

! 2024-05-19 https://www.self.com
www.self.com##.grid-layout__aside.grid--item.fVLMby.GridItem-buujkM

! 2024-01-11 https://www.youtube.com
www.youtube.com###offer-module > .ytd-watch-next-secondary-results-renderer.style-scope

! Removes Mixes from the Main Page
youtube.com##ytd-rich-item-renderer:has(#video-title-link[title*="Mix"][href$="start_radio=1"])
! Removes Mixes from the right side panel
youtube.com##ytd-compact-radio-renderer
! Removes Mixes from search results
youtube.com##ytd-radio-renderer

! Removes "YouTube" (Music) playlists from the right side panel
youtube.com##ytd-compact-playlist-renderer:has([title^="YouTube"])

! --- YouTube Shorts (likely stale — YT DOM changes frequently) ---

! YT Homepage and Subscriptions - Hide the Shorts section
youtube.com##[is-shorts]
! YT Menu - Hide the Shorts button
www.youtube.com###guide [title="Shorts"], .ytd-mini-guide-entry-renderer[title="Shorts"]
! YT Search - Hide Shorts
www.youtube.com##ytd-search ytd-video-renderer:has([overlay-style="SHORTS"])
! YT Search, Channels and Sidebar or below the player - Hide the Shorts sections
www.youtube.com##ytd-reel-shelf-renderer
! YT Channels - Hide the Shorts tab
www.youtube.com##[tab-title="Shorts"]
! YT Subscriptions - Hide Shorts - Grid View
www.youtube.com##ytd-browse[page-subtype="subscriptions"] ytd-grid-video-renderer:has([overlay-style="SHORTS"])
! YT Subscriptions - Hide Shorts - List View
www.youtube.com##ytd-browse[page-subtype="subscriptions"] ytd-video-renderer:has([overlay-style="SHORTS"])
! YT Subscriptions - New Layout - Hide Shorts
www.youtube.com##ytd-browse[page-subtype="subscriptions"] ytd-rich-item-renderer:has([overlay-style="SHORTS"])
! YT Sidebar - Hide Shorts
www.youtube.com###related ytd-compact-video-renderer:has([overlay-style="SHORTS"])

! YT Mobile - Hide the Shorts Menu button
m.youtube.com##.pivot-shorts:upward(ytm-pivot-bar-item-renderer)
! YT Mobile - Hide Shorts sections
m.youtube.com##ytm-reel-shelf-renderer
! YT Mobile - Hide Shorts in search results
m.youtube.com##ytm-search ytm-video-with-context-renderer [data-style="SHORTS"]

! Title: Hide YouTube Shorts
! Description: Hide all traces of YouTube shorts videos on YouTube
! Version: 1.8.0
! Last modified: 2024-01-08 20:02
! Expires: 2 weeks (update frequency)
! Homepage: https://github.com/gijsdev/ublock-hide-yt-shorts
! License: https://github.com/gijsdev/ublock-hide-yt-shorts/blob/master/LICENSE.md

! Hide all videos containing the phrase "#shorts"
youtube.com##ytd-grid-video-renderer:has(#video-title:has-text(#shorts))
youtube.com##ytd-grid-video-renderer:has(#video-title:has-text(#Shorts))
youtube.com##ytd-grid-video-renderer:has(#video-title:has-text(#short))
youtube.com##ytd-grid-video-renderer:has(#video-title:has-text(#Short))

! Hide all videos with the shorts indicator on the thumbnail
youtube.com##ytd-grid-video-renderer:has([overlay-style="SHORTS"])
youtube.com##ytd-rich-item-renderer:has([overlay-style="SHORTS"])
youtube.com##ytd-video-renderer:has([overlay-style="SHORTS"])
youtube.com##ytd-item-section-renderer.ytd-section-list-renderer[page-subtype="subscriptions"]:has(ytd-video-renderer:has([overlay-style="SHORTS"]))

! Hide shorts button in sidebar
youtube.com##ytd-guide-entry-renderer:has-text(Shorts)
youtube.com##ytd-mini-guide-entry-renderer:has-text(Shorts)

! Hide shorts section on homepage
youtube.com##ytd-rich-section-renderer:has(#rich-shelf-header:has-text(Shorts))
youtube.com##ytd-reel-shelf-renderer:has(.ytd-reel-shelf-renderer:has-text(Shorts))

! Hide shorts tab on channel pages
! Old style
youtube.com##tp-yt-paper-tab:has(.tp-yt-paper-tab:has-text(Shorts))
! New style (2023-10)
youtube.com##yt-tab-shape:has-text(/^Shorts$/)

! Hide shorts in video descriptions
youtube.com##ytd-reel-shelf-renderer.ytd-structured-description-content-renderer:has-text("Shorts remixing this video")

! Remove empty spaces in grid
youtube.com##ytd-rich-grid-row,#contents.ytd-rich-grid-row:style(display: contents !important)


!!! MOBILE !!!

! Hide all videos in home feed containing the phrase "#shorts"
m.youtube.com##ytm-rich-item-renderer:has(#video-title:has-text(#shorts))
m.youtube.com##ytm-rich-item-renderer:has(#video-title:has-text(#Shorts))
m.youtube.com##ytm-rich-item-renderer:has(#video-title:has-text(#short))
m.youtube.com##ytm-rich-item-renderer:has(#video-title:has-text(#Short))

! Hide all videos in subscription feed containing the phrase "#shorts"
m.youtube.com##ytm-item-section-renderer:has(#video-title:has-text(#shorts))
m.youtube.com##ytm-item-section-renderer:has(#video-title:has-text(#Shorts))
m.youtube.com##ytm-item-section-renderer:has(#video-title:has-text(#short))
m.youtube.com##ytm-item-section-renderer:has(#video-title:has-text(#Short))

! Hide shorts button in the bottom navigation bar
m.youtube.com##ytm-pivot-bar-item-renderer:has(.pivot-shorts)

! Hide all videos with the shorts indicator on the thumbnail
m.youtube.com##ytm-video-with-context-renderer:has([data-style="SHORTS"])

! Hide shorts sections
m.youtube.com##ytm-rich-section-renderer:has(ytm-reel-shelf-renderer:has(.reel-shelf-title-wrapper:has-text(Shorts)))
m.youtube.com##ytm-reel-shelf-renderer.item:has(.reel-shelf-title-wrapper:has-text(Shorts))

! Hide shorts tab on channel pages
m.youtube.com##.single-column-browse-results-tabs>a:has-text(Shorts)
```
