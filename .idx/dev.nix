# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.python3
    pkgs.rye
    pkgs.uv
  ];
  # Sets environment variables in the workspace
  env = {
    DJANGO_ALLOWED_HOSTS = "*";
    DJANGO_DEBUG = "True";
    DJANGO_SECRET_KEY = "django-insecure-+@6#6u791^+&s&nntn8mp1xbmc(wr)@8n68^o#7x-7xz9td9c*";
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "charliermarsh.ruff"
      "ms-python.python"
      "ms-python.debugpy"
      "streetsidesoftware.code-spell-checker"
    ];
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        rye-sync = "rye sync";
        # Open editors for the following files by default, if they exist:
        default.openFiles = [ "README.md" "pyproject.toml" ];
      };
      # To run something each time the workspace is (re)started, use the `onStart` hook
    };
    # Enable previews and customize configuration
    previews = {
      enable = true;
      previews = {
        web = {
          command = [ "rye" "run" "python" "mysite/manage.py" "runserver" "$PORT" ];
          env = {
            PORT = "$PORT";
          };
          manager = "web";
        };
      };
    };
  };
}
