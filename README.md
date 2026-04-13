# blog

[blog.mulatta.io](https://blog.mulatta.io) 소스. Hugo + Stack 테마, Nix로 빌드, Radicle CI로 배포.

## 개발

```bash
nix develop       # hugo, lychee 포함 셸
just new <slug>   # 새 글 page bundle 생성
just build        # nix build .#blog
just serve        # 빌드 후 정적 서빙 (:1313)
just check        # 내부 링크 체크
just fmt          # treefmt
```

## 디렉토리

| 경로 | 역할 |
|---|---|
| `site/hugo.toml` | Hugo 설정 |
| `site/content/post/` | 글 (page bundle 또는 시리즈) |
| `site/content/page/{archives,search}` | Stack 테마 고정 페이지 |
| `site/static/images/` | 공용 정적 자산 (시리즈별 하위 폴더 권장) |
| `flake.nix`, `nix/` | 빌드 및 개발 환경 |

## 글 추가

### 단일 글 — Page Bundle

```bash
just new my-slug
```

생성 경로: `site/content/post/my-slug/index.md`.
이미지는 같은 폴더에 두고 `./image.png`로 참조.

### 시리즈 — Branch Bundle

`site/content/post/<series>/` 아래 `NN-chapter.md` 형식으로 여러 글을 둔다.
공용 이미지는 `site/static/images/<series>/`에 두고 `/images/<series>/foo.png`로 참조.

## 배포

Radicle CI 트리거 → `nix build .#blog` → NixOS nginx webroot 스위칭.
