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

`stable` is the release on flightsim.to. A higher stable number shows "A newer version is available." That line opens `stableUrl`.

`experimental` is the latest build handed out on Discord. A higher experimental number shows that experimental updates are only on Discord and opens `experimentalUrl`.

`1.0.64-x` and `1.0.64x` are the same experimental build. The same digits without `x` are the stable release, and that release is newer.

VMR Wizard has no flightsim.to addon page. Its stable link is the tebs profile until one exists.

Bump the number in the file when a build should be announced. The installed app picks it up on the next start. No app rebuild is required for that.
