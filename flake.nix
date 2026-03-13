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
      names = map (n: builtins.match ".*/([^/]+)/([^/]+)\\.typ$" (toString n)) (
        builtins.concatMap (d: fs.toList (fs.fileFilter (f: f.hasExt "typ") d)) [
          ./examples
          ./docs
        ]
      );
    in
    {
      packages = eachSystem (
        pkgs:
        let
          inherit (pkgs.lib.fileset) toSource unions;
          tcntop = pkgs.buildTypstPackage {
            pname = "cntopo";
            version = "0.1.0";
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
            path:
            let
              name = builtins.elemAt path 1;
              dir = builtins.elemAt path 0;
              input = "${dir}/${name}.typ";
              output = "${dir}/${name}.pdf";
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
            path:
            let
              name = builtins.elemAt path 1;
              p = watch-open path;
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
