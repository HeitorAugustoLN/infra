{
  heitor.mullvad-browser.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.mullvad-browser ];
    };
}
