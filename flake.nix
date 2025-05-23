{
  description = "Category Theory for Programmers";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";

  outputs = inputs@{ self, flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem = { config, pkgs, system, lib, ... }:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          ########################################################################
          # LaTeX Font
          inconsolata-lgc-latex = pkgs.stdenvNoCC.mkDerivation {
            name = "inconsolata-lgc-latex";
            pname = "inconsolata-lgc-latex";

            src = pkgs.inconsolata-lgc;

            dontConfigure = true;
            sourceRoot = ".";

            installPhase = ''
              runHook preInstall

              find $src -name '*.ttf' -exec install -m644 -Dt $out/fonts/truetype/public/inconsolata-lgc/ {} \;
              find $src -name '*.otf' -exec install -m644 -Dt $out/fonts/opentype/public/inconsolata-lgc/ {} \;

              runHook postInstall
            '';

            tlType = "run";
          };

          ########################################################################
          # LaTeX Environment
          texliveEnv = pkgs.texlive.combine {
            inherit
              (pkgs.texlive)
              adjustbox
              alegreya
              babel
              bookcover
              catchfile
              chngcntr
              collectbox
              currfile
              emptypage
              enumitem
              environ
              fgruler
              fontaxes
              framed
              fvextra
              idxlayout
              ifmtarg
              ifnextok
              ifplatform
              imakeidx
              import
              inconsolata
              l3packages
              lettrine
              libertine
              libertinus-fonts
              listings
              mdframed
              microtype
              minifp
              minted
              mweights
              needspace
              newtx
              noindentafter
              nowidow
              scheme-medium
              subfigure
              xecjk
              ctex
              zhnumber
              subfiles
              textpos
              tcolorbox
              tikz-cd
              titlecaps
              titlesec
              todonotes
              trimspaces
              upquote
              wrapfig
              xifthen
              xpatch
              xstring
              zref
              ;

            inconsolata-lgc-latex = {
              pkgs = [ inconsolata-lgc-latex ];
            };
          };

          commonAttrs = {
            texlive = pkgs.texlive.combine {
              inherit (pkgs.texlive) scheme-medium xetex xecjk ctex zhnumber;
            };
            nativeBuildInputs = [
              texliveEnv
              pkgs.wqy_microhei
              (
                pkgs.python3.withPackages (p: [ p.pygments p.pygments-style-github ])
              )
              pkgs.which
            ];
          };

          mkLatex = variant: edition:
            let
              maybeVariant = lib.optionalString (variant != null) "-${variant}";
              maybeEdition = lib.optionalString (edition != null) "-${edition}";
              variantStr =
                if variant == null
                then "reader"
                else variant;
              basename = "ctfp-${variantStr}${maybeEdition}";
              version = self.shortRev or self.lastModifiedDate;
              suffix = maybeVariant + maybeEdition;
              fullname = "ctfp${suffix}";
            in
            pkgs.stdenvNoCC.mkDerivation (commonAttrs
              // {
              inherit basename version;
              name = basename;

              src = "${self}/src";

              configurePhase = ''
                runHook preConfigure

                substituteInPlace "version.tex" --replace "dev" "${version}"

                runHook postConfigure
              '';

              buildPhase = ''
                runHook preBuild

                latexmk -file-line-error -shell-escape -logfilewarninglist \
                        -interaction=nonstopmode -halt-on-error -norc \
                        -jobname=ctfp -pdflatex="xelatex %O %S" -pdfxe \
                        "$basename.tex"

                runHook postBuild
              '';

              installPhase = "
                runHook preInstall

                install -m 0644 -vD ctfp.pdf \"$out/${fullname}.pdf\"

                runHook postInstall
              ";

              passthru.packageName = fullname;
            });

          editions = [ null "scala" "ocaml" "reason" ];
          variants = [ null "print" ];
        in
        {
          formatter = pkgs.nixpkgs-fmt;

          packages = lib.listToAttrs (lib.concatMap
            (variant:
              map
                (edition: rec {
                  value = mkLatex variant edition;
                  name = value.packageName;
                })
                editions)
            variants);

          # nix develop .
          devShells.default = pkgs.mkShellNoCC (commonAttrs
            // {
            nativeBuildInputs =
              commonAttrs.nativeBuildInputs
                ++ [
                pkgs.git
                pkgs.gnumake
              ];
          });
        };
    };
}
