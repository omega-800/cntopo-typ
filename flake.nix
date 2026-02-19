{
  description = "typst development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    {
      nixpkgs,
      ...
    }:
    let
      systems = nixpkgs.lib.platforms.unix;
      eachSystem =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              config = { };
              overlays = [ ];
            }
          )
        );
      fs = nixpkgs.lib.fileset;
      sources = map toString (fs.toList (fs.fileFilter (f: f.hasExt "typ") ./examples));
      names = map (s: builtins.elemAt (builtins.match ".*/([^/]+)\\.typ$" s) 0) sources;
    in
    {
      packages = eachSystem (
        pkgs:
        let
          inherit (pkgs.lib.fileset) toSource unions;
          tcntop = pkgs.buildTypstPackage {
            pname = "tcntop";
            version = "0.0.1";
            src = toSource {
              root = ./.;
              fileset = unions [
                ./lib
                ./typst.toml
              ];
            };
          };
        in
        {
          inherit tcntop;
          default = tcntop;
        }
      );

      devShells = eachSystem (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            typst
            typstyle
          ];
        };
      });

      apps = eachSystem (
        pkgs:
        let
          watch-open =
            name:
            let
              input = "examples/${name}.typ";
              output = "examples/${name}.pdf";
            in
            pkgs.writeShellApplication {
              name = "typst-watch-open-${name}";
              text = ''
                (trap 'kill 0' SIGINT; 
                  ${pkgs.zathura}/bin/zathura "$PWD/${output}" &
                  ${pkgs.typst}/bin/typst watch ${input} --root .
                )
              '';
            };
          scripts = map (
            name:
            let
              p = watch-open name;
            in
            {
              inherit name;
              value = {
                type = "app";
                program = "${p}/bin/typst-watch-open-${name}";
              };
            }
          ) names;
        in
        pkgs.lib.listToAttrs scripts
        // {
          default = (builtins.elemAt scripts 0).value;
        }
      );
    };
}
