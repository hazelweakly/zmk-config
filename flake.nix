{
  description = "My keyboard";

  outputs = { self, nixpkgs }: {

    devShells.x86_64-darwin.default =
      let pkgsCross = nixpkgs.legacyPackages.x86_64-darwin.pkgsCross.arm-embedded;
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
    in pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        (pkgsCross.buildPackages.python3.withPackages (p: with p; [
          # anytree
          canopen
          intelhex
          packaging
          progress
          psutil
          pyaml
          pyelftools
          pykwalify
          pylink-square
          west
        ]))
        ccache
        cmake
        dfu-util
        dtc
        pkgsCross.buildPackages.gcc
        pkgsCross.buildPackages.gcc-arm-embedded
        ninja
        wget
      ];
      shellHook = ''
        [ -f zmk/zephyr/zephyr-env.sh ] && source zmk/zephyr/zephyr-env.sh
      '';
      ZEPHYR_TOOLCHAIN_VARIANT= "gnuarmemb";
      GNUARMEMB_TOOLCHAIN_PATH = pkgsCross.buildPackages.gcc-arm-embedded;
    };
  };
}
