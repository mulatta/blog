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
      };
    };
}
