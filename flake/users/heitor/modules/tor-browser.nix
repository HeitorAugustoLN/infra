{
  heitor.tor-browser.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.tor-browser ];
    };
}
