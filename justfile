# Default recipe
default:
    @just --list

# Build with Nix
build:
    nix build .#blog

# Serve built site (run after build)
serve: build
    miniserve --index index.html -p 1313 result

# Create new post (usage: just new my-post-slug)
new slug:
    mkdir -p site/content/post/{{slug}}
    @echo '---' > site/content/post/{{slug}}/index.md
    @echo 'title: "{{slug}}"' >> site/content/post/{{slug}}/index.md
    @echo 'date: '$(date +%Y-%m-%d) >> site/content/post/{{slug}}/index.md
    @echo 'draft: true' >> site/content/post/{{slug}}/index.md
    @echo 'categories:' >> site/content/post/{{slug}}/index.md
    @echo '  - General' >> site/content/post/{{slug}}/index.md
    @echo 'tags:' >> site/content/post/{{slug}}/index.md
    @echo '  - ' >> site/content/post/{{slug}}/index.md
    @echo '---' >> site/content/post/{{slug}}/index.md
    @echo '' >> site/content/post/{{slug}}/index.md
    @echo 'Created: site/content/post/{{slug}}/index.md'

# Format code
fmt:
    nix fmt

# Clean build artifacts
clean:
    rm -rf result
