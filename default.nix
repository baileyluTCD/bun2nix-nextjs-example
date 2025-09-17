{
  mkBunDerivation,
  makeWrapper,
  bun,
  ...
}:
mkBunDerivation rec {
  pname = "bun2nix-nextjs";
  version = "1.0.0";

  src = ./.;

  bunNix = ./bun.nix;

  nativeBuildInputs = [
    makeWrapper
  ];

  buildPhase = ''
    bun run build
  '';

  installPhase = ''
    mkdir -p $out

    cp -r ./. $out/bun2nix-nextjs

    makeWrapper ${bun}/bin/bun $out/bin/${pname} \
      --chdir $out/bun2nix-nextjs \
      --append-flags "run start"
  '';

  meta.mainProgram = pname;
}
