#!/usr/bin/env python3
"""Convert all .mdx files to .md while stripping emoji characters.

The script walks the repository (rooted two directories above this file),
replacing every Markdown/MDX document with an emoji-free ``.md`` copy. The
original ``.mdx`` file is deleted after a successful conversion unless the
``--keep-original`` flag is provided.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Iterable, Tuple

# Emoji code point ranges taken from the Unicode emoji blocks. This heuristic
# will cover standard emoji glyphs (faces, gestures, transport icons, flags,
# pictographs, etc.) without removing ordinary punctuation or symbols.
EMOJI_RANGES: Tuple[Tuple[int, int], ...] = (
    (0x1F000, 0x1F02F),  # Mahjong tiles
    (0x1F0A0, 0x1F0FF),  # Playing cards
    (0x1F100, 0x1F1FF),  # Enclosed alphanumerics + regional indicators
    (0x1F200, 0x1F2FF),  # Enclosed ideographic supplement
    (0x1F300, 0x1F5FF),  # Misc symbols and pictographs
    (0x1F600, 0x1F64F),  # Emoticons
    (0x1F680, 0x1F6FF),  # Transport and map
    (0x1F700, 0x1F77F),  # Alchemical symbols
    (0x1F780, 0x1F7FF),  # Geometric shapes extended
    (0x1F800, 0x1F8FF),  # Supplemental arrows C
    (0x1F900, 0x1F9FF),  # Supplemental symbols and pictographs
    (0x1FA00, 0x1FAFF),  # Symbols and pictographs extended A
    (0x1FB00, 0x1FBFF),  # Symbols for legacy computing
    (0x2600, 0x26FF),    # Misc symbols
    (0x2700, 0x27BF),    # Dingbats
    (0xFE00, 0xFE0F),    # Variation selectors
    (0x1F3FB, 0x1F3FF),  # Skin tone modifiers
)

# Standalone code points frequently used in emoji sequences.
EMOJI_SINGLETONS = {
    0x200D,  # Zero width joiner
}


def is_emoji(char: str) -> bool:
    """Return True if the code point is considered an emoji glyph."""
    code_point = ord(char)
    if code_point in EMOJI_SINGLETONS:
        return True
    return any(start <= code_point <= end for start, end in EMOJI_RANGES)


def strip_emoji(text: str) -> str:
    """Remove emoji characters from text."""
    return "".join(ch for ch in text if not is_emoji(ch))


def convert_file(source: Path, delete_original: bool, dry_run: bool, force: bool) -> None:
    """Convert a single .mdx file to .md without emoji."""
    target = source.with_suffix(".md")
    if target.exists() and not force:
        raise FileExistsError(f"Target already exists: {target}")

    if dry_run:
        print(f"DRY RUN: would convert {source} -> {target}")
        return

    content = source.read_text(encoding="utf-8")
    cleaned = strip_emoji(content)
    target.write_text(cleaned, encoding="utf-8")

    if delete_original:
        source.unlink()


def walk_mdx_files(root: Path) -> Iterable[Path]:
    """Yield all .mdx files under the given root directory."""
    for path in root.rglob("*.mdx"):
        if "node_modules" in path.parts:
            continue
        if path.is_file():
            yield path


def parse_args(argv: Iterable[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--root",
        type=Path,
        default=Path(__file__).resolve().parents[1],
        help="Repository root to scan (default: project root)",
    )
    parser.add_argument(
        "--keep-original",
        action="store_true",
        help="Keep the original .mdx files instead of deleting them.",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Show which files would be converted without writing changes.",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Overwrite existing .md files if they already exist.",
    )
    return parser.parse_args(argv)


def main(argv: Iterable[str] | None = None) -> int:
    args = parse_args(argv if argv is not None else sys.argv[1:])

    root = args.root
    if not root.exists():
        print(f"Root path does not exist: {root}", file=sys.stderr)
        return 2

    mdx_files = list(walk_mdx_files(root))
    if not mdx_files:
        print("No .mdx files found. Nothing to do.")
        return 0

    mdx_files.sort()

    delete_original = not args.keep_original
    for source in mdx_files:
        try:
            convert_file(
                source=source,
                delete_original=delete_original,
                dry_run=args.dry_run,
                force=args.force,
            )
        except FileExistsError as exc:
            print(f"Skipping {source}: {exc}", file=sys.stderr)

    if args.dry_run:
        print("Dry run complete. Re-run without --dry-run to apply changes.")
    else:
        print(f"Converted {len(mdx_files)} file(s).{' Original files removed.' if delete_original else ''}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
