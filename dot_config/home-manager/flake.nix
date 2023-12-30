{
  description = "Home Manager configuration pointer";

  inputs = {
    universe.url = "git+https://git.sapphicco.de/SapphicCode/universe";
  };

  outputs = { universe, ... }: {
    inherit (universe) homeConfigurations;
  };
}
