{
  description = ''Compiler package providing the compiler sources as a library.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-compiler-v1_2_16.flake = false;
  inputs.src-compiler-v1_2_16.owner = "nim-lang";
  inputs.src-compiler-v1_2_16.ref   = "v1_2_16";
  inputs.src-compiler-v1_2_16.repo  = "Nim.git";
  inputs.src-compiler-v1_2_16.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-compiler-v1_2_16"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-compiler-v1_2_16";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}