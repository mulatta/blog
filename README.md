# blog

Source for [blog.mulatta.io](https://blog.mulatta.io). Built with Hugo and the
Stack theme, packaged by Nix, deployed via Radicle CI.

## Development

```bash
nix develop       # shell with hugo, lychee, miniserve
just new <slug>   # scaffold a new post (page bundle)
just build        # nix build .#blog
just serve        # build and serve statically (:1313)
just check        # build and run internal link check
just fmt          # treefmt
```

## Layout

| Path | Purpose |
|---|---|
| `site/hugo.toml` | Hugo configuration |
| `site/content/post/` | Posts (page bundles or series) |
| `site/content/page/{archives,search}` | Stack theme pages |
| `site/static/images/` | Shared static assets (prefer per-series subfolders) |
| `flake.nix`, `nix/` | Build and dev environment |

## Authoring

### Single post — Page Bundle

```bash
just new my-slug
```

Creates `site/content/post/my-slug/index.md`. Place images in the same folder
and reference them as `./image.png`.

### Series — Branch Bundle

Put multiple posts under `site/content/post/<series>/` as `NN-chapter.md`.
Store shared images under `site/static/images/<series>/` and reference them
as `/images/<series>/foo.png`.

## Deployment

Radicle CI triggers on push → `nix build .#blog` → NixOS nginx webroot is
switched atomically to the new store path.
