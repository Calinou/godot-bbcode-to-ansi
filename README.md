# Godot BBCode to ANSI escape code converter

This can be used for colored console printing.

Not functional on Windows 10 and later yet, as Godot doesn't enable virtual terminal processing yet.

## Features

**Note:** Some of these features will only work in certain terminals. This is especially the case for italic and strikethrough where terminal support can be spotty.

- Bold/italic/underline/strikethrough (`[b]`, `[i]`, `[u]`, `[s]`).
- `[code]` tag (doesn't change font, but appears as "faint" in supported terminals).
- `[center]`/`[right]` alignment (emulated using tab characters).
- `[indent]` tag (emulated using 4 spadces).
- 16-color and 256-color ANSI codes for `[color]` (text color) and `[bgcolor]` (background color, used for highlighting text).
  - **Only named colors such as `red`, `green`, `blue` are supported.**
  - True color ANSI codes could be supported, but terminal support for them is not universal due to macOS's Terminal.app not supporting truecolor.
    Therefore, some named colors are approximated with a 256-color palette optimized for readability on dark and light backgrounds.
- `[fgcolor]` (redacted text) emulation using the same color as foreground and background.

For tags other than `[color]`, `[bgcolor]` and `[fgcolor]`, tags can be contained within each other and formatting will be preserved as done in RichTextLabel.
For color tags, it's possible to get the same visual appearance without nesting tags (but it may be less convenient to script on your end).

## License

Copyright © 2022 Hugo Locurcio and contributors

Unless otherwise specified, files in this repository are licensed under the
MIT license. See [LICENSE.md](LICENSE.md) for more information.
