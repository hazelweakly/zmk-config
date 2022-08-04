{
  description = "My keyboard";

  outputs = { self, nixpkgs }: {

    devShells.x86_64-darwin.default = let pkgs = nixpkgs.legacyPackages.x86_64-darwin; in pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        (python3.withPackages (p: with p; [
          anytree
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
        gcc
        gcc-arm-embedded
        ninja
        wget
      ];
      shellHook = ''
        [ -f zmk/zephyr/zephyr-env.sh ] && source zmk/zephyr/zephyr-env.sh
      '';
      ZEPHYR_TOOLCHAIN_VARIANT= "gnuarmemb";
      GNUARMEMB_TOOLCHAIN_PATH = pkgs.gcc-arm-embedded;
    };
  };
}
