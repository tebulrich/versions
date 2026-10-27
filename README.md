# Versions

Each flight sim app reads its own file from this repo on startup.

Raw address: `https://raw.githubusercontent.com/tebulrich/versions/main/<file>`

| App | File |
| --- | --- |
| Traffic Audio | `traffic-audio.json` |
| Sim Companion | `sim-companion.json` |
| Home Assistant Bridge | `home-assistant-bridge.json` |
| Hangar Link | `hangar-link.json` |
| ACARS Printer Bridge | `acars-printer.json` |
| VMR Wizard | `vmr-wizard.json` |

`stable` is the release on flightsim.to. A higher stable number shows a banner. On a stable install that banner downloads `stableZip` and installs it. If `stableZip` is empty, the banner opens `stableUrl`.

`stableZip` is one zip, the latest stable only. It is a GitHub release asset named `stable.zip` on the tag `<file-without-json>-stable`, for example `traffic-audio-stable`. Put a new stable zip there with `publish-stable.ps1`. Do not upload an experimental build.

`experimental` is the latest build handed out on Discord. A higher experimental number shows that experimental updates are only on Discord and opens `experimentalUrl`. An experimental install never downloads `stableZip`.

`1.0.64-x` and `1.0.64x` are the same experimental build. The same digits without `x` are the stable release, and that release is newer. A build is also experimental when its number matches `experimental` and that number is higher than `stable`.

VMR Wizard has no flightsim.to addon page. Its stable link is the tebs profile until one exists.

Bump the number in the file when a build should be announced. The installed app picks it up on the next start. No app rebuild is required for that. A stable install can apply `stableZip` only after that install already contains the updater.
