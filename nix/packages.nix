{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      hugo-theme-stack = pkgs.fetchFromGitHub {
        owner = "CaiJimmy";
        repo = "hugo-theme-stack";
        rev = "v3.33.0";
        hash = "sha256-U1AKdgq5Wkz8hm4CNCpFTn6PSeZi+pAQIsCvCjWyfn8=";
      };
    in
    {
      packages.blog = pkgs.stdenvNoCC.mkDerivation {
        pname = "blog";
        version = "1.0";

        src = pkgs.lib.cleanSourceWith {
          src = ../site;
          filter = path: _type: baseNameOf path != "themes";
        };

        nativeBuildInputs = [ pkgs.hugo ];

        configurePhase = ''
          runHook preConfigure
          mkdir -p themes
          ln -s ${hugo-theme-stack} themes/stack
          runHook postConfigure
        '';

        buildPhase = ''
          runHook preBuild
          hugo \
            --minify \
            --themesDir themes \
            --theme stack \
            --destination public
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          mkdir -p $out
          cp -r public/* $out
          runHook postInstall
        '';

        postInstall = ''
          # robots.txt: Content Signals Policy up front, then the
          # upstream ai-robots-txt blocklist, then our sitemap pointer.
          # Mirrors the homepage derivation; Cloudflare's managed
          # robots.txt doesn't apply since mulatta.io is DNS-only.
          {
            echo "# Content Signals Policy (served from origin)"
            echo "User-Agent: *"
            echo "Content-Signal: search=yes, ai-train=no"
            echo "Allow: /"
            echo ""
            echo "# AI crawlers — sourced from ai-robots-txt/ai.robots.txt upstream"
            cat ${inputs.ai-robots-txt}/robots.txt
            echo ""
            echo "Sitemap: https://blog.mulatta.io/sitemap.xml"
          } > $out/robots.txt
        '';
      };
    };
}
