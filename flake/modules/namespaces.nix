{ inputs, ... }:
{
  imports = [
    (inputs.den.namespace "nodes" true)
    (inputs.den.namespace "_nodes" false)
  ];
}
