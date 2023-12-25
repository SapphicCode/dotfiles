{
  description = "A proxy to my home-manager config";

  inputs = {
    home = {
      url = "./dot_config/home-manager";
    };
  };

  outputs = { self, home }: {
    inherit (home) homeConfigurations;
  };
}
