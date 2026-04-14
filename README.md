# Package Template

A template for creating and publishing Roblox packages with [TestEZ](https://github.com/Roblox/testez) testing, [Selene](https://github.com/Kampfkarren/selene) linting, and [StyLua](https://github.com/JohnnyMorganz/StyLua) formatting preconfigured.

## Setup

Download and install [Rokit](https://github.com/rojo-rbx/rokit/releases), then run:
```sh
rokit install
wally install
```

## File Structure
```
.
├── src/                        # Package source code
├── test/                       # Test scripts (TestEZ)
├── default.project.json        # Rojo project for publishing
├── test-place.project.json     # Rojo project for local development & testing
├── wally.toml                  # Package manifest
└── rokit.toml                  # Tool versions
```

Use `default.project.json` when building or publishing your package, and `test-place.project.json` when developing locally in Roblox Studio with your test scripts.
