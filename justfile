alias c := clean
alias r := repl

# List all available recipes.
default:
    @just --list

# Clean up build artifacts and temporary files.
[group("Maintenance")]
clean:
    rm -f result*

# Enter the nix repl in debug mode.
[group("Develop")]
repl:
    NIX_DEBUG_REPL=1 nix repl --expr "builtins.getFlake \"$PWD\""
